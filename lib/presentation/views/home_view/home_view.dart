import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:two_be_wedd_user_app/utils/extensions.dart';
import 'package:two_be_wedd_user_app/utils/navigation_helper.dart';

import '../../../configs/front_end_configs.dart';
import '../hall_details_view/hall_details_view.dart';
import '../update_user_profile_view/update_user_profile_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text("Home"),
          actions: [
            GestureDetector(
              onTap: () {
                NavigationHelper.push(context, const UpdateUserProfileView());
              },
              child: const CircleAvatar(
                backgroundImage:
                    AssetImage("assets/images/profile_image_placeholder.png"),
              ),
            ),
            20.sW,
          ],
        ),
        body: Padding(
          padding: FrontEndConfigs.kHorizontalPadding,
          child: Column(
            children: [
              5.sH,
              SearchBar(
                hintText: "Search",
                padding: MaterialStateProperty.all<EdgeInsets>(
                    FrontEndConfigs.kHorizontalPadding),
                trailing: [
                  const FaIcon(FontAwesomeIcons.magnifyingGlass),
                  10.sW,
                ],
              ),
              10.sH,
              Expanded(
                child: ListView.separated(
                  itemCount: 5,
                  padding: const EdgeInsets.only(bottom: 18),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        NavigationHelper.push(context, const HallDetailsView());
                      },
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Theme.of(context)
                                    .dividerColor
                                    .withOpacity(0.5)),
                            borderRadius: BorderRadius.circular(12)),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  children: [
                                    SizedBox(
                                      height: 100,
                                      width: 100,
                                      child: Card(
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            child: Image.asset(
                                                "assets/images/hall_image_1.jpg",
                                                fit: BoxFit.cover)),
                                      ),
                                    ),
                                    Positioned(
                                      top: 5,
                                      left: 5,
                                      child: Card(
                                        color: context.colorScheme.primary,
                                        child: Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: Text(
                                            "5000/Rs",
                                            style: context.textTheme.labelSmall!
                                                .copyWith(
                                                    color: context.theme
                                                                .brightness ==
                                                            Brightness.light
                                                        ? Colors.white
                                                        : Colors.black),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                6.sW,
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Deewan e Khas",
                                        style: context.textTheme.titleLarge,
                                      ),
                                      Text(
                                        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer",
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        style: context.textTheme.bodySmall,
                                      ),
                                      3.sH,
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          // Row(
                                          //   children: [
                                          //     Text(
                                          //       "Budget: ",
                                          //       style:
                                          //           context.textTheme.labelMedium,
                                          //     ),
                                          //     Text(
                                          //       "5000/Rs",
                                          //       style:
                                          //           context.textTheme.labelSmall,
                                          //     ),
                                          //   ],
                                          // ),
                                          Row(
                                            children: [
                                              Text(
                                                "Capacity: ",
                                                style: context
                                                    .textTheme.labelMedium,
                                              ),
                                              Text(
                                                "300",
                                                style: context
                                                    .textTheme.labelSmall,
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) => 10.sH,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
