import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:two_be_wedd_user_app/utils/extensions.dart';

import '../../../configs/front_end_configs.dart';
import '../../../infrastructure/models/hall_model.dart';
import '../../../infrastructure/models/user_model.dart';
import '../../../infrastructure/providers/search_halls_provider.dart';
import '../../../infrastructure/services/system_services.dart';
import '../../../utils/navigation_helper.dart';
import '../../elements/custom_image.dart';
import '../hall_details_view/hall_details_view.dart';
import '../update_user_profile_view/update_user_profile_view.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);
  final SystemServices _systemServices = SystemServices();

  @override
  Widget build(BuildContext context) {
    final searchHalls = context.watch<SearchHallsProvider>();
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
            StreamProvider.value(
                value: _systemServices.fetchCurrentUser(),
                initialData: UserModel(),
                builder: (context, child) {
                  final user = context.watch<UserModel>();

                  return GestureDetector(
                    onTap: () {
                      NavigationHelper.push(
                          context,
                          UpdateUserProfileView(
                            user: user,
                          ));
                    },
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                        user.profileImage ??
                            "https://cdn-icons-png.flaticon.com/128/5509/5509505.png",
                      ),
                    ),
                  );
                }),
            20.sW,
          ],
        ),
        body: StreamProvider.value(
            value: _systemServices.fetchAllHalls(),
            initialData: const <HallModel>[],
            builder: (context, snapshot) {
              final List<HallModel> allHalls = context.watch<List<HallModel>>();
              return allHalls.isEmpty
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Padding(
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
                            onChanged: (v) {
                              if (v.isNotEmpty && allHalls.isNotEmpty) {
                                Timer(
                                  const Duration(microseconds: 500),
                                  () {
                                    searchHalls.searchHall(allHalls, v);
                                  },
                                );
                              } else {
                                searchHalls.clearList();
                                searchHalls.setSearchFalse();
                              }
                            },
                          ),
                          10.sH,
                          searchHalls.searchedDataList.isEmpty &&
                                  searchHalls.isSearched == false
                              ? Expanded(
                                  child: HallsListBuilder(
                                    halls: allHalls,
                                  ),
                                )
                              : searchHalls.searchedDataList.isEmpty
                                  ? Center(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const CustomImage(
                                            image:
                                                "https://cdn-icons-png.flaticon.com/128/3670/3670605.png",
                                            height: 100,
                                            width: 100,
                                          ),
                                          10.sH,
                                          Text(
                                            "No Halls Found",
                                            style: context.textTheme.titleLarge!
                                                .copyWith(
                                                    color: context
                                                        .colorScheme.primary),
                                          )
                                        ],
                                      ),
                                    )
                                  : Expanded(
                                      child: HallsListBuilder(
                                        halls: searchHalls.searchedDataList,
                                      ),
                                    )
                        ],
                      ),
                    );
            }),
      ),
    );
  }
}

class HallsListBuilder extends StatelessWidget {
  const HallsListBuilder({
    super.key,
    required this.halls,
  });

  final List<HallModel> halls;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: halls.length,
      padding: const EdgeInsets.only(bottom: 18),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            NavigationHelper.push(
                context,
                HallDetailsView(
                  hall: halls[index],
                ));
          },
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
                border: Border.all(
                    color: Theme.of(context).dividerColor.withOpacity(0.5)),
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
                                borderRadius: BorderRadius.circular(4),
                                child: CustomImage(
                                  fit: BoxFit.cover,
                                  image: halls[index].firstImage ?? "",
                                )),
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
                                "${halls[index].budget}/Rs",
                                style: context.textTheme.labelSmall!.copyWith(
                                    color: context.theme.brightness ==
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            halls[index].name ?? "",
                            style: context.textTheme.titleLarge,
                          ),
                          Text(
                            halls[index].description ?? "",
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: context.textTheme.bodySmall,
                          ),
                          3.sH,
                          Row(
                            children: [
                              Text(
                                "Capacity: ",
                                style: context.textTheme.labelMedium,
                              ),
                              Text(
                                halls[index].capacity.toString(),
                                style: context.textTheme.labelSmall,
                              ),
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
    );
  }
}
