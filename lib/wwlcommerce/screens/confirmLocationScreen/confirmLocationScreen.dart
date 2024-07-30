import 'package:eClassify/wwlcommerce/helper/generalWidgets/bottomSheetLocationSearch/widget/flutterGooglePlaces.dart';
import 'package:eClassify/wwlcommerce/helper/utils/generalImports.dart';
import 'package:google_maps_webservice/places.dart';
import 'dart:developer' as developer;
class ConfirmLocation extends StatefulWidget {
  final GeoAddress? address;
  final String from;

  const ConfirmLocation({Key? key, this.address, required this.from})
      : super(key: key);

  @override
  State<ConfirmLocation> createState() => _ConfirmLocationState();
}

class _ConfirmLocationState extends State<ConfirmLocation> {
  late GoogleMapController controller;
  late CameraPosition kGooglePlex;
  late LatLng kMapCenter;
  double mapZoom = 14.4746;

  List<Marker> customMarkers = [];

  @override
  void initState() {
    kMapCenter = LatLng(0.0, 0.0);

    kGooglePlex = CameraPosition(
      target: kMapCenter,
      zoom: mapZoom,
    );

    if (widget.address != null) {
      kMapCenter = LatLng(double.parse(widget.address!.lattitud!),
          double.parse(widget.address!.longitude!));

      kGooglePlex = CameraPosition(
        target: kMapCenter,
        zoom: mapZoom,
      );
    } else {
      GeneralMethods.determinePosition().then((value) async {
        updateMap(value.latitude, value.longitude);
      });
    }

    setMarkerIcon();
    super.initState();
  }

  updateMap(double latitude, double longitude) {
    kMapCenter = LatLng(latitude, longitude);
    kGooglePlex = CameraPosition(
      target: kMapCenter,
      zoom: mapZoom,
    );
    setMarkerIcon();
    controller.animateCamera(CameraUpdate.newCameraPosition(kGooglePlex));
  }

  setMarkerIcon() async {
    MarkerGenerator(const MapDeliveredMarker(), (bitmaps) {
      setState(() {
        bitmaps.asMap().forEach((i, bmp) {
          customMarkers.add(Marker(
            markerId: MarkerId("$i"),
            position: kMapCenter,
            icon: BitmapDescriptor.fromBytes(bmp),
          ));
        });
      });
    }).generate(context);

    Constant.cityAddressMap =
        await GeneralMethods.getCityNameAndAddress(kMapCenter, context);

    if (widget.from == "location") {
      Map<String, dynamic> params = {};
      // params[ApiAndParams.cityName] = Constant.cityAddressMap["city"];

      params[ApiAndParams.longitude] = kMapCenter.longitude.toString();
      params[ApiAndParams.latitude] = kMapCenter.latitude.toString();

      await context
          .read<CityByLatLongProvider>()
          .getCityByLatLongApiProvider(context: context, params: params);
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: getAppBar(
          context: context,
          title: CustomTextLabel(
            jsonKey: "confirm_location",
          ),
        ),
        body: WillPopScope(
          onWillPop: () async {
            return Future.delayed(const Duration(milliseconds: 500))
                .then((value) => true);
          },
          child: Column(children: [
            Expanded(
              child: Stack(
                children: [
                  PositionedDirectional(
                    top: 0,
                    end: 0,
                    start: 0,
                    bottom: 0,
                    child: mapWidget(),
                  ),
                  PositionedDirectional(
                    top: 15,
                    end: 15,
                    start: 15,
                    child: Row(children: [
                      Expanded(
                          child: GestureDetector(
                        onTap: () async {
                          Prediction? p = await PlacesAutocomplete.show(
                              context: context,
                              apiKey: Constant.googleApiKey,
                              decoration: InputDecoration(
                                labelStyle: TextStyle(
                                  color: ColorsRes.mainTextColor,
                                ),
                              ),
                              textStyle: TextStyle(
                                color: ColorsRes.mainTextColor,
                              ));

                          GeneralMethods.displayPrediction(p, context).then(
                            (value) => updateMap(
                              double.parse(value?.lattitud ?? "0.0"),
                              double.parse(
                                value?.longitude ?? "0.0",
                              ),
                            ),
                          );
                        },
                        child: Container(
                          decoration: DesignConfig.boxDecoration(
                            Theme.of(context).scaffoldBackgroundColor,
                            10,
                          ),
                          child: ListTile(
                            title: TextField(
                              enabled: false,
                              decoration: InputDecoration(
                                isDense: true,
                                border: InputBorder.none,
                                hintText: context
                                            .read<LanguageProvider>()
                                            .currentLanguage[
                                        "search_location_hint"] ??
                                    "search_location_hint",
                              ),
                            ),
                            contentPadding: EdgeInsetsDirectional.only(
                              start: Constant.size12,
                            ),
                            trailing: IconButton(
                              padding: EdgeInsets.zero,
                              icon: Icon(
                                Icons.search,
                                color: ColorsRes.mainTextColor,
                              ),
                              onPressed: () {},
                            ),
                          ),
                        ),
                      )),
                      SizedBox(width: Constant.size10),
                      GestureDetector(
                        onTap: () =>
                            GeneralMethods.determinePosition().then((value) {
                          updateMap(value.latitude, value.longitude);
                        }),
                        child: Container(
                          decoration: DesignConfig.boxGradient(10),
                          padding: EdgeInsets.symmetric(
                              horizontal: 18, vertical: 18),
                          child: Widgets.defaultImg(
                            image: "my_location_icon",
                            iconColor: ColorsRes.mainIconColor,
                          ),
                        ),
                      ),
                    ]),
                  ),
                ],
              ),
            ),
            confirmBtnWidget(),
          ]),
        ));
  }

  Widget mapWidget() {
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: kGooglePlex,
      myLocationEnabled: false,
      myLocationButtonEnabled: false,
      onTap: (argument) async {
        updateMap(argument.latitude, argument.longitude);
      },
      onMapCreated: _onMapCreated,
      markers: customMarkers.toSet(),
      zoomControlsEnabled: true,
      zoomGesturesEnabled: true,
      onCameraMove: (position) {
        mapZoom = position.zoom;
      },
      // markers: markers,
    );
  }

  Future<void> _onMapCreated(GoogleMapController controllerParam) async {
    controller = controllerParam;
    // This callback is called every time the brightness changes from the device.
    if (Constant.session.getBoolData(SessionManager.isDarkTheme)) {
      controllerParam.setMapStyle(
          await rootBundle.loadString('assets/mapTheme/darkMode.json'));
    }
  }

  confirmBtnWidget() {
    return Card(
      color: Theme.of(context).cardColor,
      surfaceTintColor: Theme.of(context).cardColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          (widget.from == "location" &&
                  !context.read<CityByLatLongProvider>().isDeliverable)
              ? CustomTextLabel(
                  jsonKey: "does_not_delivery_long_message",
                  style: Theme.of(context).textTheme.bodySmall!.apply(
                        color: ColorsRes.appColorRed,
                      ),
                )
              : const SizedBox.shrink(),
          Padding(
            padding: EdgeInsetsDirectional.only(start: 20, end: 20, top: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Widgets.defaultImg(
                  image: "address_icon",
                  iconColor: ColorsRes.appColor,
                  height: 25,
                  width: 25,
                ),
                Widgets.getSizedBox(
                  width: 20,
                ),
                Expanded(
                  child: CustomTextLabel(
                    text: Constant.cityAddressMap["address"] ?? "",
                  ),
                ),
              ],
            ),
          ),
          if ((widget.from == "location" &&
                  context.read<CityByLatLongProvider>().isDeliverable) ||
              widget.from == "address")
            ConfirmButtonWidget(
              voidCallback: () {
                developer.log('Setting longitude: ${kMapCenter.longitude}');
                developer.log('Setting latitude: ${kMapCenter.latitude}');
                Constant.session.setData(SessionManager.keyLongitude,
                    kMapCenter.longitude.toString(), false);
                Constant.session.setData(SessionManager.keyLatitude,
                    kMapCenter.latitude.toString(), false);
                if (widget.from == "location" &&
                    context.read<CityByLatLongProvider>().isDeliverable) {
                  context
                      .read<CartListProvider>()
                      .getAllCartItems(context: context);

                  developer.log('Setting address: ${Constant.cityAddressMap["address"]}');

                  Constant.session.setData(SessionManager.keyAddress,
                      Constant.cityAddressMap["address"], true);
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    mainHomeScreen,
                    (Route<dynamic> route) => false,
                  );
                } else if (widget.from == "address") {
                  Future.delayed(const Duration(milliseconds: 500)).then(
                    (value) {
                      Navigator.pop(context, true);
                    },
                  );
                }
              },
            )
        ],
      ),
    );
  }
}
