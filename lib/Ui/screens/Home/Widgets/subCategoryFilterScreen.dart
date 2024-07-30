import 'package:eClassify/Utils/Extensions/extensions.dart';
import 'package:eClassify/data/model/category_model.dart';
import 'package:flutter/material.dart';

import '../../../../Utils/ui_utils.dart';
import '../../Widgets/AnimatedRoutes/blur_page_route.dart';

class SubCategoryFilterScreen extends StatefulWidget {
  final Function addModel;
  final List<CategoryModel> model;

  const SubCategoryFilterScreen(
      {super.key, required this.addModel, required this.model});

  @override
  State<SubCategoryFilterScreen> createState() =>
      _SubCategoryFilterScreenState();

  static Route route(RouteSettings routeSettings) {
    Map? args = routeSettings.arguments as Map?;
    return BlurredRouter(
      builder: (_) => SubCategoryFilterScreen(
        addModel: args!["addModel"],
        model: args["model"],
      ),
    );
  }
}

class _SubCategoryFilterScreenState extends State<SubCategoryFilterScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.color.backgroundColor,
      appBar: UiUtils.buildAppBar(
        context,
        showBackButton: true,
        title: "classifieds".translate(context),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 12),
        child: SizedBox(
            width: context.screenWidth,
            child: Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Container(
                color: context.color.secondaryColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 18),
                      child: Text(
                        "allInClassified".translate(context),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      )
                          .color(context.color.textDefaultColor)
                          .size(context.font.normal)
                          .bold(weight: FontWeight.w600),
                    ),
                    const Divider(
                      thickness: 1.2,
                      height: 10,
                    ),
                    Expanded(
                      child: ListView.separated(
                        itemCount: widget.model.length,
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        separatorBuilder: (context, index) {
                          return const Divider(
                            thickness: 1.2,
                            height: 10,
                          );
                        },
                        itemBuilder: (context, index) {
                          CategoryModel category = widget.model[index];

                          return ListTile(
                            onTap: () {
                              widget.addModel(widget.model[index]);
                              Navigator.pop(context);
                            },
                            leading: Container(
                                width: 40,
                                height: 40,
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: context.color.territoryColor
                                        .withOpacity(0.1)),
                                child: UiUtils.imageType(
                                  category.url,
                                  color: context.color.territoryColor,
                                  fit: BoxFit.cover,
                                )),
                            title: Text(
                              category.name,
                              textAlign: TextAlign.start,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            )
                                .color(context.color.textDefaultColor)
                                .size(context.font.normal),
                            trailing: Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color:
                                        context.color.borderColor.darken(10)),
                                child: Icon(
                                  Icons.chevron_right_outlined,
                                  color: context.color.textDefaultColor,
                                )),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}