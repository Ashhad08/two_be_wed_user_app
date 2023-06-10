import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:two_be_wedd_user_app/configs/front_end_configs.dart';
import 'package:two_be_wedd_user_app/utils/extensions.dart';

class BookHallView extends StatelessWidget {
  const BookHallView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Book Hall"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: FrontEndConfigs.kAllSidePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Theme.of(context).dividerColor.withOpacity(0.5)),
                    borderRadius: BorderRadius.circular(12)),
                child: Row(
                  children: [
                    const CircleAvatar(
                      backgroundImage:
                          AssetImage("assets/images/hall_image_1.jpg"),
                      radius: 30,
                    ),
                    10.sW,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Deewan e khas",
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          Text(
                            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyMedium,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              10.sH,
              Row(
                children: [
                  Text(
                    "Select Date and Time",
                    style: context.textTheme.bodyLarge,
                  ),
                  const Spacer(),
                  SizedBox(
                    width: 80,
                    child: ElevatedButton(
                        onPressed: () async {
                          final DateTime? pickedDate = await showDatePicker(
                            context: context,
                            firstDate: DateTime(2000),
                            initialDate: DateTime.now(),
                            lastDate: DateTime(3000),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 3,
                          padding: EdgeInsets.zero,
                          foregroundColor: context.colorScheme.onPrimary,
                          backgroundColor: context.colorScheme.primary,
                        ),
                        child: const Text(
                          "Pick Date",
                          style: TextStyle(fontSize: 13),
                        )),
                  ),
                  5.sW,
                  SizedBox(
                    width: 80,
                    child: ElevatedButton(
                        onPressed: () async {
                          TimeOfDay? pickedTime = await showTimePicker(
                              context: context, initialTime: TimeOfDay.now());
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 3,
                          padding: EdgeInsets.zero,
                          foregroundColor: context.colorScheme.onPrimary,
                          backgroundColor: context.colorScheme.primary,
                        ),
                        child: const Text(
                          "Pick Time",
                          style: TextStyle(fontSize: 13),
                        )),
                  )
                ],
              ),
              10.sH,
              Text(
                'Extra Services',
                style: context.textTheme.titleLarge,
              ),
              CheckboxListTile(
                value: true,
                onChanged: (val) {},
                title: const Text(
                  "DJ",
                ),
              ),
              CheckboxListTile(
                value: false,
                onChanged: (val) {},
                title: const Text(
                  "Photography",
                ),
              ),
              CheckboxListTile(
                value: true,
                onChanged: (val) {},
                title: const Text(
                  "Catering",
                ),
              ),
              CheckboxListTile(
                value: true,
                onChanged: (val) {},
                title: const Text(
                  "Stage and Hall decoration",
                ),
              ),
              const Divider(),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Theme.of(context).dividerColor.withOpacity(0.5)),
                    borderRadius: BorderRadius.circular(12)),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Hall Budget",
                          style: context.textTheme.bodySmall!.copyWith(
                              fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                        const Text("Rs 3000/-"),
                      ],
                    ),
                    15.sH,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Catering",
                          style: context.textTheme.bodySmall!.copyWith(
                              fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                        const Text("Rs 1000/-"),
                      ],
                    ),
                    15.sH,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Stage and Hall decoration",
                          style: context.textTheme.bodySmall!.copyWith(
                              fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                        const Text("Rs 5000/-"),
                      ],
                    ),
                    15.sH,
                    const DottedLine(
                      direction: Axis.horizontal,
                      lineThickness: 1.0,
                      dashLength: 5.0,
                      dashColor: Colors.grey,
                    ),
                    10.sH,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total Budget",
                          style: context.textTheme.titleLarge!
                              .copyWith(fontSize: 16),
                        ),
                        Text(
                          "Rs 10000/-",
                          style: context.textTheme.titleLarge!.copyWith(
                              fontSize: 16, color: context.colorScheme.primary),
                        ),
                      ],
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
                      'Book',
                    ),
                    onPressed: () {},
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
