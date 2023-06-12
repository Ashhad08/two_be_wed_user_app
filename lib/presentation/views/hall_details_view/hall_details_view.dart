import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:two_be_wedd_user_app/utils/extensions.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../configs/front_end_configs.dart';
import '../../../infrastructure/models/hall_model.dart';
import '../../../utils/navigation_helper.dart';
import '../../../utils/utils.dart';
import '../../elements/custom_image.dart';
import '../book_hall_view/book_hall_view.dart';

class HallDetailsView extends StatelessWidget {
  const HallDetailsView({Key? key, required this.hall}) : super(key: key);
  final HallModel hall;

  @override
  Widget build(BuildContext context) {
    final List<String> hallImages = [
      hall.firstImage ?? "",
      hall.secondImage ?? "",
      hall.thirdImage ?? "",
      hall.fourthImage ?? "",
    ];
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: context.theme.colorScheme.surface,
                borderRadius:
                    const BorderRadius.vertical(bottom: Radius.circular(35)),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context)
                        .colorScheme
                        .onPrimaryContainer
                        .withOpacity(0.7),
                    offset: const Offset(0, 4),
                    blurRadius: 20,
                  )
                ],
              ),
              child: CarouselSlider(
                options: CarouselOptions(
                  initialPage: 0,
                  autoPlay: true,
                  height: context.screenHeight * 0.4,
                  viewportFraction: 1,
                  autoPlayInterval: const Duration(seconds: 4),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  scrollDirection: Axis.horizontal,
                ),
                items: hallImages.map((i) {
                  return ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                          bottom: Radius.circular(35)),
                      child: CustomImage(
                        image: i,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ));
                }).toList(),
              ),
            ),
            Padding(
              padding: FrontEndConfigs.kAllSidePadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    hall.name ?? "",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontSize: 28),
                  ),
                  10.sH,
                  Text(
                    hall.address ?? "",
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  10.sH,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                                text: 'Rs ',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: context.colorScheme.primary)),
                            TextSpan(
                              text: "${hall.budget ?? 0}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(color: context.colorScheme.primary),
                            ),
                            TextSpan(
                              text: "\\-",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(color: context.colorScheme.primary),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "${hall.capacity ?? 0}",
                            style: context.textTheme.titleMedium!
                                .copyWith(color: context.colorScheme.primary),
                          ),
                          5.sW,
                          FaIcon(FontAwesomeIcons.peopleGroup,
                              size: 22, color: context.colorScheme.primary)
                        ],
                      )
                    ],
                  ),
                  10.sH,
                  Text(
                    'Hall Services',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    hall.description ?? "",
                    style: context.textTheme.bodySmall,
                  ),
                  10.sH,
                  const Divider(),
                  Text(
                    'Extra Services',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Wrap(
                      spacing: 8,
                      children: hall.extraServices!
                          .map(
                            (e) => ChoiceChip(
                              padding: EdgeInsets.zero,
                              label: Text(e.name),
                              onSelected: (val) {},
                              selected: true,
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  20.sH,
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: context.screenWidth * 0.5,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 3,
                          foregroundColor: context.colorScheme.onPrimary,
                          backgroundColor: context.colorScheme.primary,
                        ),
                        child: const Text(
                          'Book Now',
                        ),
                        onPressed: () {
                          NavigationHelper.push(
                              context,
                              BookHallView(
                                hall: hall,
                              ));
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () async {
          String messageString =
              '*Hall Name*: ${hall.name}\n*Address:* ${hall.address}\n';
          Uri url = Uri.parse(
              "whatsapp://send?phone=${hall.phoneNumber}&text=${Uri.encodeComponent(messageString)}");
          if (!(await launchUrl(url) && hall.phoneNumber != null)) {
            // ignore: use_build_context_synchronously
            Utils.showSnackBar(
                context: context,
                message: "Could not connect, Please try again");
          }
        },
        child: const FaIcon(
          FontAwesomeIcons.whatsapp,
          color: Colors.white,
        ),
      ),
    );
  }
}
