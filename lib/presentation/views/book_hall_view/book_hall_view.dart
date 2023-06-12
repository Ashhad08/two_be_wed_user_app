import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:two_be_wedd_user_app/configs/front_end_configs.dart';
import 'package:two_be_wedd_user_app/infrastructure/models/hall_model.dart';
import 'package:two_be_wedd_user_app/infrastructure/services/system_services.dart';
import 'package:two_be_wedd_user_app/presentation/elements/loading_overlay.dart';
import 'package:two_be_wedd_user_app/utils/extensions.dart';

import '../../../infrastructure/models/extra_service.dart';
import '../../../infrastructure/models/hall_booking_model.dart';
import '../../../infrastructure/providers/loading_helper.dart';
import '../../../infrastructure/services/user_services.dart';
import '../../../utils/backend_configs.dart';
import '../../../utils/utils.dart';

class BookHallView extends StatefulWidget {
  const BookHallView({Key? key, required this.hall}) : super(key: key);
  final HallModel hall;

  @override
  State<BookHallView> createState() => _BookHallViewState();
}

class _BookHallViewState extends State<BookHallView> {
  num _totalBudget = 0;
  DateTime? _pickedDate;
  TimeOfDay? _pickedTime;
  final List<ExtraService> _extraServices = [];
  List<Timestamp> _allHalsBookingsTimes = [];

  @override
  void initState() {
    super.initState();
    _totalBudget = widget.hall.budget ?? 0;
    setState(() {});
    _getHallHalsBookingsTimes();
  }

  _getHallHalsBookingsTimes() async {
    _allHalsBookingsTimes = await SystemServices().fetchHallBookingsTimes();
  }

  Timestamp? get _date => _pickedDate == null || _pickedTime == null
      ? null
      : Timestamp.fromDate(DateTime(_pickedDate!.year, _pickedDate!.month,
          _pickedDate!.day, _pickedTime!.hour, _pickedTime!.minute));

  @override
  Widget build(BuildContext context) {
    return CustomLoadingOverlay(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Book Hall"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: FrontEndConfigs.kAllSidePadding,
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color:
                              Theme.of(context).dividerColor.withOpacity(0.5)),
                      borderRadius: BorderRadius.circular(12)),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage:
                            NetworkImage(widget.hall.firstImage ?? ""),
                        radius: 30,
                      ),
                      10.sW,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.hall.name ?? "",
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            Text(
                              widget.hall.description ?? "",
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
                15.sH,
                Text(
                  _date == null
                      ? "Select Date and Time"
                      : DateFormat.yMEd().add_jms().format(_date!.toDate()),
                  style: context.textTheme.bodyLarge,
                ),
                5.sH,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 80,
                      child: ElevatedButton(
                          onPressed: () async {
                            await showDatePicker(
                              context: context,
                              firstDate: DateTime(2000),
                              initialDate: DateTime.now(),
                              lastDate: DateTime(3000),
                            ).then((value) {
                              if (value != null) {
                                if (value.isBefore(DateTime.now()
                                    .add(const Duration(days: 1)))) {
                                  Utils.showSnackBar(
                                      context: context,
                                      color: context.colorScheme.error,
                                      message:
                                          "Date must be after today's date");
                                } else {
                                  _pickedDate = value;
                                  setState(() {});
                                }
                              }
                            });
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
                            _pickedTime = await showTimePicker(
                                context: context, initialTime: TimeOfDay.now());
                            setState(() {});
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
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Extra Services',
                    style: context.textTheme.titleLarge,
                  ),
                ),
                for (ExtraService e in widget.hall.extraServices!) ...{
                  CheckboxListTile(
                    value: _extraServices.contains(e),
                    onChanged: (val) {
                      if (val!) {
                        _extraServices.add(e);
                        _totalBudget = _totalBudget + e.budget;
                        setState(() {});
                      } else {
                        _extraServices.remove(e);
                        _totalBudget = _totalBudget - e.budget;
                        setState(() {});
                      }
                    },
                    title: Text(
                      e.name,
                    ),
                  ),
                },
                const Divider(),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color:
                              Theme.of(context).dividerColor.withOpacity(0.5)),
                      borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    children: [
                      for (ExtraService e in _extraServices) ...{
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              e.name,
                              style: context.textTheme.bodySmall!.copyWith(
                                  fontSize: 14, fontWeight: FontWeight.w400),
                            ),
                            Text("Rs ${e.budget}/-"),
                          ],
                        ),
                        15.sH,
                      },
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
                            "Rs $_totalBudget/-",
                            style: context.textTheme.titleLarge!.copyWith(
                                fontSize: 16,
                                color: context.colorScheme.primary),
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
                      onPressed: () async {
                        if (_date == null) {
                          Utils.showSnackBar(
                              context: context,
                              message: "Kindly Select Date and Time",
                              color: context.colorScheme.error);
                        } else if (_allHalsBookingsTimes.contains(_date!)) {
                          Utils.showSnackBar(
                              context: context,
                              message:
                                  "Hall is already Booked on this Date, Kindly Select any other date",
                              color: context.colorScheme.error);
                        } else {
                          await _bookHall(context);
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _bookHall(BuildContext context) async {
    final loadingProvider = Provider.of<LoadingHelper>(context, listen: false);

    loadingProvider.stateStatus(StateStatus.IsBusy);

    await UserServices()
        .bookHall(
            bookingModel: HallBookingModel(
                bookedBy: FirebaseAuth.instance.currentUser!.uid,
                bookedExtraServices: _extraServices,
                bookingDateTime: _date!,
                hallId: widget.hall.hallId!,
                isConfirmed: false,
                totalBudget: _totalBudget),
            context: context)
        .then((value) async {
      final String token = await BackEndConfigs.adminsCollectionsRef
          .doc(widget.hall.adminId!)
          .get()
          .then((value) => value.get("notificationToken"));
      final String adminName = await BackEndConfigs.adminsCollectionsRef
          .doc(widget.hall.adminId!)
          .get()
          .then((value) => value.get("name"));
      await SystemServices()
          .sendPushNotification(
              token: token,
              date: DateFormat.yMEd().add_jms().format(_date!.toDate()),
              userName: adminName)
          .then((value) {
        loadingProvider.stateStatus(StateStatus.IsFree);
        Navigator.pop(context);
        Utils.showSnackBar(
            context: context,
            maxLines: 2,
            message:
                "Hall Booked Successfully, wait for Confirmation notification");
      }).onError((error, stackTrace) {
        loadingProvider.stateStatus(StateStatus.IsError);
        Utils.showSnackBar(
            context: context,
            message: error.toString().replaceAll(RegExp(r'\[.*?\]'), '').trim(),
            color: Theme.of(context).colorScheme.error);
      });
    }).onError((error, stackTrace) {
      loadingProvider.stateStatus(StateStatus.IsError);
      Utils.showSnackBar(
          context: context,
          message: error.toString().replaceAll(RegExp(r'\[.*?\]'), '').trim(),
          color: Theme.of(context).colorScheme.error);
    });
  }
}
