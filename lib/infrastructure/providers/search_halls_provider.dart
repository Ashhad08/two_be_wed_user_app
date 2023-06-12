import 'package:flutter/material.dart';

import '../models/hall_model.dart';

class SearchHallsProvider with ChangeNotifier {
  final List<HallModel> _searchedDataList = [];

  bool _isSearched = false;

  bool get isSearched => _isSearched;

  List<HallModel> get searchedDataList => _searchedDataList;

  clearList() {
    _searchedDataList.clear();
    notifyListeners();
  }

  setSearchFalse() {
    _isSearched = false;
    notifyListeners();
  }

  void searchHall(List<HallModel> allData, String value) {
    _searchedDataList.clear();

    for (var i in allData) {
      var lowerCaseString = i.name.toString().toLowerCase();
      var upperCaseString = i.name.toString().toUpperCase();
      var defaultCaseString = i.name.toString();

      if (lowerCaseString.contains(value) ||
          defaultCaseString.contains(value) ||
          upperCaseString.contains(value)) {
        _searchedDataList.add(i);
        notifyListeners();
      } else {
        _isSearched = true;
        notifyListeners();
      }
    }
  }
}
