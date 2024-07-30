import 'package:eClassify/wwlcommerce/helper/utils/generalImports.dart';
import 'package:google_maps_webservice/places.dart';

class BottomSheetLocationSearch extends StatefulWidget {
  const BottomSheetLocationSearch({super.key});

  @override
  State<BottomSheetLocationSearch> createState() =>
      _BottomSheetLocationSearchState();
}

class _BottomSheetLocationSearchState extends State<BottomSheetLocationSearch> {
  void onError(PlacesAutocompleteResponse response) {
    GeneralMethods.showMessage(
        context, response.errorMessage!, MessageType.warning);
  }

  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) async {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
