import 'dart:io';

import 'package:country_picker/country_picker.dart';
import 'package:eClassify/Ui/screens/widgets/custom_text_form_field.dart';
import 'package:eClassify/Ui/screens/widgets/image_cropper.dart';
import 'package:eClassify/Utils/AppIcon.dart';
import 'package:eClassify/Utils/Extensions/extensions.dart';
import 'package:eClassify/Utils/responsiveSize.dart';
import 'package:eClassify/Utils/ui_utils.dart';
import 'package:eClassify/data/cubits/auth/auth_cubit.dart';
import 'package:eClassify/data/cubits/auth/authentication_cubit.dart';
import 'package:eClassify/data/cubits/slider_cubit.dart';
import 'package:eClassify/data/cubits/system/user_details.dart';
import 'package:eClassify/data/helper/custom_exception.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../../app/routes.dart';
import '../../../data/Repositories/auth_repository.dart';
import '../../../data/helper/widgets.dart';
import '../../../data/model/google_place_model.dart';
import '../../../data/model/user_model.dart';
import '../../../exports/main_export.dart';
import '../../../features/auth/models/user_modelaaa.dart' as UModel;

import '../../../features/jobs/model/company_model.dart';
import '../../../features/jobs/model/job_seeker_profile_model.dart';
import '../../../features/kyc/model/kyc_model.dart';
import '../../../features/tabbar/tabbar_screen.dart';
import '../../../utils/helper_utils.dart';
import '../widgets/AnimatedRoutes/blur_page_route.dart';
import '../widgets/BottomSheets/choose_location_bottomsheet.dart';

class UserProfileScreen extends StatefulWidget {
  final String from;
  final bool? navigateToHome;
  final bool? popToCurrent;
  final AuthenticationType? type;
  final Map<String, dynamic>? extraData;

  const UserProfileScreen({
    super.key,
    required this.from,
    this.navigateToHome,
    this.popToCurrent,
    required this.type,
    this.extraData,
  });

  @override
  State<UserProfileScreen> createState() => UserProfileScreenState();

  static Route route(RouteSettings routeSettings) {
    Map arguments = routeSettings.arguments as Map;
    return BlurredRouter(
      builder: (_) => UserProfileScreen(
        from: arguments['from'] as String,
        popToCurrent: arguments['popToCurrent'] as bool?,
        type: arguments['type'],
        navigateToHome: arguments['navigateToHome'] as bool?,
        extraData: arguments['extraData'],
      ),
    );
  }
}

class UserProfileScreenState extends State<UserProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  dynamic size;
  dynamic city, _state, country, placeid;
  String? latitude, longitude;
  String? name, email, address;
  late String mFUID;
  File? fileUserimg;
  bool isNotificationsEnabled = true;
  bool? isLoading;
  String? countryCode = Constant.defaultCountryCode;

  @override
  void initState() {
    super.initState();

    city = HiveUtils.getCityName();
    _state = HiveUtils.getStateName();
    country = HiveUtils.getCountryName();
    placeid = HiveUtils.getCityPlaceId();
    latitude = HiveUtils.getLatitude();
    longitude = HiveUtils.getLongitude();
    mFUID = HiveUtils.getUserId()!;
    nameController.text = (HiveUtils.getUserDetails().name) ?? "";
    emailController.text = HiveUtils.getUserDetails().email ?? "";
    addressController.text = HiveUtils.getUserDetails().address ?? "";
    if (HiveUtils.getCountryCode() != null) {
      countryCode = (HiveUtils.getCountryCode() != null
          ? HiveUtils.getCountryCode()!
          : "");
      phoneController.text = HiveUtils.getUserDetails().mobile != null
          ? HiveUtils.getUserDetails().mobile!.replaceFirst("+$countryCode", "")
          : "";
    } else {
      phoneController.text = HiveUtils.getUserDetails().mobile != null
          ? HiveUtils.getUserDetails().mobile!
          : "";
    }

    isNotificationsEnabled = true;
    //prefillDetails();
  }

/*  void prefillDetails() {
    if (widget.from == "login") {
      if (widget.type == AuthenticationType.email) {
        nameController.text = widget.extraData?['username'] ?? "";
        emailController.text = widget.extraData?['email'] ?? "";
      } else if (widget.type == AuthenticationType.google) {
        emailController.text = widget.extraData?['email'] ?? "";
      } else if (widget.type == AuthenticationType.phone) {
        countryCode = widget.extraData?['countryCode'] ?? "";
        phoneController.text = widget.extraData?['mobile']
                .toString()
                .replaceFirst("$countryCode", "") ??
            "";
      }
    }
  }*/

  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
    nameController.dispose();
    emailController.dispose();
    addressController.dispose();
  }

  void _onTapChooseLocation() async {
    FocusManager.instance.primaryFocus?.unfocus();

    if (!const bool.fromEnvironment("force-disable-demo-mode",
        defaultValue: false)) {
      /*    if (Constant.isDemoModeOn) {
        HelperUtils.showSnackBarMessage(context, "Not valid in demo mode");

        return;
      }*/
    }

    var result = await showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      context: context,
      builder: (context) {
        return const ChooseLocatonBottomSheet();
      },
    );
    if (result != null) {
      GooglePlaceModel place = (result as GooglePlaceModel);

      city = place.city;
      country = place.country;
      _state = place.state;
      placeid = place.placeId;
      latitude = place.latitude;
      longitude = place.longitude;
    }
  }

  void _onTapVerifyPhoneNumber() {
    //verify phone number before update
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: safeAreaCondition(
        child: Scaffold(
          backgroundColor: context.color.primaryColor,
          appBar: widget.from == "login"
              ? null
              : UiUtils.buildAppBar(context, showBackButton: true),
          body: Stack(
            children: [
              ScrollConfiguration(
                behavior: RemoveGlow(),
                child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Form(
                          key: _formKey,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Align(
                                  alignment: AlignmentDirectional.center,
                                  child: buildProfilePicture(),
                                ),
                                buildTextField(
                                  context,
                                  title: "fullName",
                                  controller: nameController,
                                  validator: CustomTextFieldValidator.nullCheck,
                                ),
                                buildTextField(
                                  context,
                                  readOnly: HiveUtils.getUserDetails().type ==
                                              AuthenticationType.email ||
                                          HiveUtils.getUserDetails().type ==
                                              AuthenticationType.google
                                      ? true
                                      : false,
                                  title: "emailAddress",
                                  controller: emailController,
                                  validator: CustomTextFieldValidator.email,
                                ),
                                phoneWidget(),
                                buildAddressTextField(
                                  context,
                                  title: "addressLbl",
                                  controller: addressController,
                                  validator: CustomTextFieldValidator.nullCheck,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text("enablesNewSection".translate(context))
                                    .size(context.font.small)
                                    .bold(weight: FontWeight.w300)
                                    .color(
                                      context.color.textColorDark
                                          .withOpacity(0.8),
                                    ),
                                SizedBox(
                                  height: 20.rh(context),
                                ),
                                Text(
                                  "notification".translate(context),
                                ),
                                SizedBox(
                                  height: 10.rh(context),
                                ),
                                buildNotificationEnableDisableSwitch(context),
                                SizedBox(
                                  height: 25.rh(context),
                                ),
                                UiUtils.buildButton(
                                  context,
                                  onPressed: () {
                                    if (widget.from == 'login') {
                                      validateData();
                                    } else {
                                      if (city != null && city != "") {
                                        HiveUtils.setLocation(
                                            city: city,
                                            state: _state,
                                            country: country,
                                            placeId: placeid,
                                            latitude: latitude,
                                            longitude: longitude);

                                        context
                                            .read<SliderCubit>()
                                            .fetchSlider(context);
                                      } else {
                                        HiveUtils.clearLocation();

                                        context
                                            .read<SliderCubit>()
                                            .fetchSlider(context);
                                      }
                                      validateData();
                                    }
                                  },
                                  height: 48.rh(context),
                                  buttonTitle:
                                      "updateProfile".translate(context),
                                )
                              ])),
                    )),
              ),
              if (isLoading != null && isLoading!)
                Center(
                  child: UiUtils.progress(
                    normalProgressColor: context.color.territoryColor,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget phoneWidget() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(
        height: 10.rh(context),
      ),
      Text("phoneNumber".translate(context))
          .color(context.color.textDefaultColor),
      SizedBox(
        height: 10.rh(context),
      ),
      CustomTextFormField(
        controller: phoneController,
        validator: CustomTextFieldValidator.phoneNumber,
        keyboard: TextInputType.phone,
        isReadOnly: HiveUtils.getUserDetails().type == AuthenticationType.phone
            ? true
            : false,
        fillColor: context.color.secondaryColor,
        // borderColor: context.color.borderColor.darken(10),
        onChange: (value) {
          setState(() {});
        },
        /* suffix: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: _onTapVerifyPhoneNumber,
              child: Padding(
                padding: const EdgeInsets.only(right: 15),
                child: SizedBox(
                  child: Text("verify".translate(context))
                      .bold()
                      .color(context.color.territoryColor),
                ),
              ),
            ),
          ],
        ),*/
        fixedPrefix: SizedBox(
          width: 55,
          child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: GestureDetector(
                onTap: () {
                  showCountryCode();
                },
                child: Container(
                  // color: Colors.red,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
                  child: Center(
                      child: Text("+$countryCode")
                          .size(context.font.large)
                          .centerAlign()),
                ),
              )),
        ),
        hintText: "phoneNumber".translate(context),
      )
    ]);
  }

  Widget locationWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10.0,
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                  color: context.color.secondaryColor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: context.color.borderColor.darken(40),
                    width: 1.5,
                  )),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.only(start: 10.0),
                    child: Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: (city != "" && city != null)
                            ? Text("$city,$_state,$country")
                            : Text(
                                "selectLocationOptional".translate(context))),
                  ),
                  const Spacer(),
                  if (city != "" && city != null)
                    Padding(
                      padding: const EdgeInsetsDirectional.only(end: 10.0),
                      child: GestureDetector(
                        onTap: () {
                          city = "";
                          _state = "";
                          country = "";
                          latitude = '';
                          longitude = '';
                          setState(() {});
                        },
                        child: Icon(
                          Icons.close,
                          color: context.color.textColorDark,
                        ),
                      ),
                    )
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          GestureDetector(
            onTap: _onTapChooseLocation,
            child: Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                  color: context.color.secondaryColor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: context.color.borderColor.darken(40),
                    width: 1.5,
                  )),
              child: Icon(
                Icons.location_searching_sharp,
                color: context.color.territoryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget safeAreaCondition({required Widget child}) {
    if (widget.from == "login") {
      return SafeArea(child: child);
    }
    return child;
  }

  Widget buildNotificationEnableDisableSwitch(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
            color: context.color.borderColor.darken(40),
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(10),
          color: context.color.secondaryColor),
      height: 60,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text((isNotificationsEnabled
                        ? "enabled".translate(context)
                        : "disabled".translate(context))
                    .translate(context))
                .size(context.font.large),
          ),
          CupertinoSwitch(
            activeColor: context.color.territoryColor,
            value: isNotificationsEnabled,
            onChanged: (value) {
              isNotificationsEnabled = value;
              setState(() {});
            },
          )
        ],
      ),
    );
  }

  Widget buildTextField(BuildContext context,
      {required String title,
      required TextEditingController controller,
      CustomTextFieldValidator? validator,
      bool? readOnly}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 10.rh(context),
        ),
        Text(title.translate(context)).color(context.color.textDefaultColor),
        SizedBox(
          height: 10.rh(context),
        ),
        CustomTextFormField(
          controller: controller,
          isReadOnly: readOnly,
          validator: validator,
          // formaters: [FilteringTextInputFormatter.deny(RegExp(","))],
          fillColor: context.color.secondaryColor,
        ),
      ],
    );
  }

  Widget buildAddressTextField(BuildContext context,
      {required String title,
      required TextEditingController controller,
      CustomTextFieldValidator? validator,
      bool? readOnly}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 10.rh(context),
        ),
        Text(title.translate(context)),
        SizedBox(
          height: 10.rh(context),
        ),
        CustomTextFormField(
          controller: controller,
          maxLine: 5,
          action: TextInputAction.newline,
          isReadOnly: readOnly,
          validator: validator,
          fillColor: context.color.secondaryColor,
        ),
        const SizedBox(
          width: 10,
        ),
        locationWidget(context),
      ],
    );
  }

  Widget getProfileImage() {
    if (fileUserimg != null) {
      return Image.file(
        fileUserimg!,
        fit: BoxFit.cover,
      );
    } else {
      if (widget.from == "login") {
        if (HiveUtils.getUserDetails().profile != "" &&
            HiveUtils.getUserDetails().profile != null) {
          return UiUtils.getImage(
            HiveUtils.getUserDetails().profile!,
            fit: BoxFit.cover,
          );
        }

        return UiUtils.getSvg(
          AppIcons.defaultPersonLogo,
          color: context.color.territoryColor,
          fit: BoxFit.none,
        );
      } else {
        if ((HiveUtils.getUserDetails().profile ?? "").isEmpty) {
          return UiUtils.getSvg(
            AppIcons.defaultPersonLogo,
            color: context.color.territoryColor,
            fit: BoxFit.none,
          );
        } else {
          return UiUtils.getImage(
            HiveUtils.getUserDetails().profile!,
            fit: BoxFit.cover,
          );
        }
      }
    }
  }

  Widget buildProfilePicture() {
    return Stack(
      children: [
        Container(
          height: 124.rh(context),
          width: 124.rw(context),
          alignment: AlignmentDirectional.center,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border:
                  Border.all(color: context.color.territoryColor, width: 2)),
          child: Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: context.color.territoryColor.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            width: 106.rw(context),
            height: 106.rh(context),
            child: getProfileImage(),
          ),
        ),
        PositionedDirectional(
          bottom: 0,
          end: 0,
          child: InkWell(
            onTap: showPicker,
            child: Container(
                height: 37.rh(context),
                width: 37.rw(context),
                alignment: AlignmentDirectional.center,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: context.color.buttonColor, width: 1.5),
                    shape: BoxShape.circle,
                    color: context.color.territoryColor),
                child: SizedBox(
                    width: 15.rw(context),
                    height: 15.rh(context),
                    child: UiUtils.getSvg(AppIcons.edit))),
          ),
        )
      ],
    );
  }

  Future<void> validateData() async {
    if (_formKey.currentState!.validate()) {
      uploadtofirebase();
      profileupdateprocess();
    }
  }

  Future<UModel.UserModelS> uploadtofirebase() async {
    UModel.UserModelS userModel;
    FirebaseFirestore firestore = FirebaseFirestore.instance;
      userModel = UModel.UserModelS(
        name: nameController.text.trim() ?? "",
        email: emailController.text.trim() ?? "",
        profilePic: "",
        uid: mFUID,
        phoneNumber: phoneController.text ?? "",
        isPartner: false,
        address: "",
        userPincode: "",
        jobDetailsUpdated: "",
        kycModel: KYCModel(
          name: "",
          fatherName: '',
          motherName: '',
          aadhaarNumber: '',
          panNumber: '',
          mobileNuber: '',
          email: '',
          ifscCode: '',
          areaPincode: '',
          age: 0,
          company: '',
          accountNumber: '',
        ),
        jobSeekerProfileModel: JobSeekerProfileModel(
          name: "",
          email: "",
          jobTitle: "",
          experience: 1,
          bio: "",
          resume: "",
        ),
        companyModel: CompanyModel(
          companyName: "",
          industry: "",
          companySize: 0,
          location: "",
          companyWebsiteURL: '',
          recruiterUid: "",
        ),
      );
      await firestore.collection("users").doc(mFUID).set(userModel.toMap());
     return userModel;
    }

  profileupdateprocess() async {
    setState(() {
      isLoading = true;
    });
    // Widgets.showLoader(context);
    try {
      var response = await context.read<AuthCubit>().updateuserdata(context,
          name: nameController.text.trim(),
          email: emailController.text.trim(),
          fileUserimg: fileUserimg,
          address: addressController.text,
          mobile: phoneController.text,
          notification: isNotificationsEnabled == true ? "1" : "0");

      Future.delayed(
        Duration.zero,
        () {
          context
              .read<UserDetailsCubit>()
              .copy(UserModel.fromJson(response['data']));
        },
      );

      Future.delayed(
        Duration.zero,
        () {
          setState(() {
            isLoading = false;
          });
          // Widgets.hideLoder(context);
          HelperUtils.showSnackBarMessage(
            context,
            "profileupdated".translate(context),
            /*onClose: () {
              if (mounted) Navigator.pop(context);
            },*/
          );
          if (widget.from != "login") {
            Navigator.pop(context);
          }
        },
      );

      if (widget.from == "login" && widget.popToCurrent != true) {
        Future.delayed(
          Duration.zero,
          () {
            // HelperUtils.killPreviousPages(
            //     context, Routes.personalizedItemScreen, {
            //   "type": PersonalizedVisitType.FirstTime,
            // });

            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const TabbarScreen(),
              ),
            );

           /* HelperUtils.killPreviousPages(
                context, Routes.main, {"from": widget.from});*/
          },
        );
      } else if (widget.from == "login" && widget.popToCurrent == true) {
        Future.delayed(Duration.zero, () {
          Navigator.of(context)
            ..pop()
            ..pop();
        });
      }
    } on CustomException catch (e) {
      Future.delayed(Duration.zero, () {
        Widgets.hideLoder(context);
        HelperUtils.showSnackBarMessage(context, e.toString());
      });
    }
  }

  void showPicker() {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
            side: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(10)),
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: Text("gallery".translate(context)),
                    onTap: () {
                      _imgFromGallery(ImageSource.gallery);
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: Text("camera".translate(context)),
                  onTap: () {
                    _imgFromGallery(ImageSource.camera);
                    Navigator.of(context).pop();
                  },
                ),
                if (fileUserimg != null && widget.from == 'login')
                  ListTile(
                    leading: const Icon(Icons.clear_rounded),
                    title: Text("lblremove".translate(context)),
                    onTap: () {
                      fileUserimg = null;

                      Navigator.of(context).pop();
                      setState(() {});
                    },
                  ),
              ],
            ),
          );
        });
  }

  _imgFromGallery(ImageSource imageSource) async {
    CropImage.init(context);

    final pickedFile = await ImagePicker().pickImage(source: imageSource);

    if (pickedFile != null) {
      CroppedFile? croppedFile;
      croppedFile = await CropImage.crop(
        filePath: pickedFile.path,
      );
      if (croppedFile == null) {
        fileUserimg = null;
      } else {
        fileUserimg = File(croppedFile.path);
      }
    } else {
      fileUserimg = null;
    }
    setState(() {});
  }

  void showCountryCode() {
    showCountryPicker(
      context: context,
      showWorldWide: false,
      showPhoneCode: true,
      countryListTheme:
          CountryListThemeData(borderRadius: BorderRadius.circular(11)),
      onSelect: (Country value) {
        countryCode = value.phoneCode;
        setState(() {});
      },
    );
  }
}
