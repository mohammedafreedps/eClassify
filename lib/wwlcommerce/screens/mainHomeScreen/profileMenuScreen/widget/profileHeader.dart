import 'package:eClassify/wwlcommerce/helper/utils/generalImports.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          Constant.session.isUserLoggedIn() ? editProfileScreen : loginScreen,
          arguments: "header",
        );
      },
      child: Container(
        decoration: DesignConfig.boxDecoration(Theme.of(context).cardColor, 10),
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsetsDirectional.only(
          top: 10,
          start: 10,
          end: 10,
        ),
        child: Stack(
          children: [
            Row(children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Constant.session.isUserLoggedIn()
                      ? Consumer<UserProfileProvider>(
                          builder: (context, value, child) {
                            return Widgets.setNetworkImg(
                              height: 60,
                              width: 60,
                              boxFit: BoxFit.cover,
                              image: Constant.session.getData(
                                SessionManager.keyUserImage,
                              ),
                            );
                          },
                        )
                      : Widgets.defaultImg(
                          height: 60,
                          width: 60,
                          image: "default_user",
                        ),
                ),
              ),
              Expanded(
                  child: ListTile(
                contentPadding: EdgeInsets.zero,
                title: Consumer<UserProfileProvider>(
                  builder: (context, userProfileProvide, _) => CustomTextLabel(
                    text: Constant.session.isUserLoggedIn()
                        ? userProfileProvide.getUserDetailBySessionKey(
                            isBool: false,
                            key: SessionManager.keyUserName,
                          )
                        : getTranslatedValue(
                            context,
                            "welcome",
                          ),
                  ),
                ),
                subtitle: CustomTextLabel(
                  jsonKey: Constant.session.isUserLoggedIn()
                      ? Constant.session.getData(
                          SessionManager.keyPhone,
                        )
                      : "login",
                  style: Theme.of(context).textTheme.bodySmall!.apply(
                        color: ColorsRes.appColor,
                      ),
                ),
              )),
            ]),
            if (Constant.session.isUserLoggedIn())
              Align(
                alignment: AlignmentDirectional.topEnd,
                child: Container(
                  decoration: DesignConfig.boxGradient(5),
                  padding: const EdgeInsets.all(5),
                  margin: const EdgeInsetsDirectional.only(
                    end: 8,
                    top: 8,
                  ),
                  child: Widgets.defaultImg(
                    image: "edit_icon",
                    iconColor: ColorsRes.mainIconColor,
                    height: 20,
                    width: 20,
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
