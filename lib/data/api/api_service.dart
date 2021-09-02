import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:restaurant_app/data/model/restaurant.dart';

class ApiService {
  static final String _baseUrl = 'https://restaurant-api.dicoding.dev/';

  Uri restaurantListUrl = Uri.parse(_baseUrl + "/list");

  Future<RestaurantListResponse> getRestaurants() async {
    try {
      final response = await http.get(restaurantListUrl);
      if (response.statusCode == 200) {
        return RestaurantListResponse.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load list of restaurants');
      }
    } on SocketException catch (_) {
      throw Exception("No internet connection");
    }
  }

  Future<RestaurantDetailResponse> getRestaurantDetail(String id) async {
    try {
      var url = Uri.parse(_baseUrl + "/detail/$id");
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return RestaurantDetailResponse.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load detail restaurant');
      }
    } on SocketException catch (_) {
      throw Exception("No internet connection");
    }
  }

  Future<RestaurantSearchResponse> getSearchRestaurants(String query) async {
    try {
      var url = Uri.parse(_baseUrl + "/search?q=$query");
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return RestaurantSearchResponse.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load list of restaurants');
      }
    } on SocketException catch (_) {
      throw Exception("No internet connection");
    }
  }
}
