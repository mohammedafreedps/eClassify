import 'package:eClassify/wwlcommerce/helper/utils/generalImports.dart';

Widget buttonWidget(Widget icon, String lbl,
    {required Function onClickAction,
    required EdgeInsetsDirectional padding,
    required BuildContext context}) {
  return Padding(
    padding: padding,
    child: Container(
      decoration: DesignConfig.boxDecoration(Theme.of(context).cardColor, 10),
      padding: const EdgeInsets.all(5),
      child: InkWell(
        splashColor: ColorsRes.appColorLightHalfTransparent,
        highlightColor: Colors.transparent,
        onTap: () {
          onClickAction();
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Widgets.getSizedBox(
              height: 8,
            ),
            icon,
            Widgets.getSizedBox(
              height: 8,
            ),
            CustomTextLabel(
              jsonKey: lbl,
            ),
            Widgets.getSizedBox(
              height: 8,
            ),
          ],
        ),
      ),
    ),
  );
}
