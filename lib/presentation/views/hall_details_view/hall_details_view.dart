import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:two_be_wedd_user_app/configs/front_end_configs.dart';
import 'package:two_be_wedd_user_app/utils/extensions.dart';
import 'package:two_be_wedd_user_app/utils/navigation_helper.dart';

import '../book_hall_view/book_hall_view.dart';

class HallDetailsView extends StatelessWidget {
  const HallDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
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
                items: List.generate(4,
                        (index) => "assets/images/hall_image_${index + 1}.jpg")
                    .map((i) {
                  return ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                          bottom: Radius.circular(35)),
                      child: Image.asset(i, fit: BoxFit.fill));
                }).toList(),
              ),
            ),
            Padding(
              padding: FrontEndConfigs.kAllSidePadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Deewan e Khas",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontSize: 28),
                  ),
                  10.sH,
                  Text(
                    '123 Maple Avenue, Pleasantville, Exampleville, 98765.',
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
                              text: "5000",
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
                            "300",
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
                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer",
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
                      children: [
                        ChoiceChip(
                          padding: EdgeInsets.zero,
                          label: const Text("DJ"),
                          onSelected: (val) {},
                          selected: true,
                        ),
                        ChoiceChip(
                          padding: EdgeInsets.zero,
                          label: const Text("Photography"),
                          onSelected: (val) {},
                          selected: false,
                        ),
                        ChoiceChip(
                          padding: EdgeInsets.zero,
                          label: const Text("Catering"),
                          onSelected: (val) {},
                          selected: true,
                        ),
                        ChoiceChip(
                          label: const Text("Stage and Hall decoration"),
                          padding: EdgeInsets.zero,
                          onSelected: (val) {},
                          selected: true,
                        ),
                      ],
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
                          NavigationHelper.push(context, const BookHallView());
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
        onPressed: () {},
        child: const FaIcon(
          FontAwesomeIcons.whatsapp,
          color: Colors.white,
        ),
      ),
    );
  }
}
