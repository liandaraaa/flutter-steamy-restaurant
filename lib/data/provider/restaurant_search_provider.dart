import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/common/state.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant.dart';

class RestaurantSearchProvider extends ChangeNotifier {
  final ApiService apiService;
  late RestaurantSearchResponse restaurantSearchResponse;
  late String _message = '';
  late ResultState _state;
  late String query = '';

  RestaurantSearchProvider({required this.apiService, required this.query}) {
    _fetchSearchRestaurants();
  }

  String get message => _message;

  RestaurantSearchResponse get response => restaurantSearchResponse;

  ResultState get state => _state;

  Future<dynamic> _fetchSearchRestaurants() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final response = await apiService.getSearchRestaurants(query);
      if (response.restaurants.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return restaurantSearchResponse = response;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = '$e';
    }
  }
}
