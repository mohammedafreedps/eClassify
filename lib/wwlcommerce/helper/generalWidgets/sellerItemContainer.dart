import 'package:eClassify/wwlcommerce/helper/utils/generalImports.dart';

class SellerItemContainer extends StatelessWidget {
  final Sellers? seller;
  final VoidCallback voidCallBack;

  const SellerItemContainer({Key? key, this.seller, required this.voidCallBack})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: voidCallBack,
      child: Container(
        decoration: DesignConfig.boxDecoration(
            Theme.of(context).scaffoldBackgroundColor, 8),
        child: Column(children: [
          Expanded(
            flex: 8,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: SizedBox(
                height: context.width,
                width: context.height,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Widgets.setNetworkImg(
                    boxFit: BoxFit.cover,
                    image: seller?.logoUrl ?? "",
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: Padding(
                padding: EdgeInsetsDirectional.only(start: 4, end: 4),
                child: CustomTextLabel(
                  text: seller?.name,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
