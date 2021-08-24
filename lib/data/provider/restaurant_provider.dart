import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant.dart';

enum ResultState { Loading, NoData, HasData, Error }

class RestaurantListProvider extends ChangeNotifier {
  final ApiService apiService;
  late RestaurantListResponse restaurantListResponse;
  late String _message = '';
  late ResultState _state;

  RestaurantListProvider({required this.apiService}) {
    _fetchAllRestaurants();
  }

  String get message => _message;

  RestaurantListResponse get response => restaurantListResponse;

  ResultState get state => _state;

  Future<dynamic> _fetchAllRestaurants() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final response = await apiService.getRestaurants();
      if (response.restaurants.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return restaurantListResponse = response;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiService apiService;
  late RestaurantDetailResponse restaurantDetailResponse;
  late String _message = '';
  late ResultState _state;
  late String id = '';

  RestaurantDetailProvider({required this.apiService, required this.id}) {
    _fetchRestaurantDetail(id);
  }

  String get message => _message;

  RestaurantDetailResponse get detailResponse => restaurantDetailResponse;

  ResultState get state => _state;

  Future<dynamic> _fetchRestaurantDetail(String id) async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final response = await apiService.getRestaurantDetail(id);
      _state = ResultState.HasData;
      notifyListeners();
      return restaurantDetailResponse = response;
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
