// import 'package:flutter/material.dart';
//
// import '../../utils/navigation_helper.dart';
//
// class DrawerDestinationProvider extends ChangeNotifier {
//   int _index = 0;
//
//   int get index => _index;
//
//   changeIndex(int index, BuildContext context) {
//     if (index != 3) {
//       _index = index;
//       notifyListeners();
//       switch (index) {
//         case 0:
//           NavigationHelper.pushReplacement(context, const DashboardView());
//         case 1:
//           NavigationHelper.pushReplacement(context, const HallBookingsView());
//         case 2:
//           NavigationHelper.pushReplacement(
//               context, const ConfirmedOrdersView());
//       }
//     }
//   }
// }
