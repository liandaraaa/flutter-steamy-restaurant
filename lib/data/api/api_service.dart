import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:restaurant_app/data/model/restaurant.dart';

class ApiService {
  static final String _baseUrl = 'https://restaurant-api.dicoding.dev/';

  Future<RestaurantListResponse> getRestaurants() async {
    var url = Uri.parse(_baseUrl + "/list");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return RestaurantListResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load list of restaurants');
    }
  }

  Future<RestaurantDetailResponse> getRestaurantDetail(String id) async {
    var url = Uri.parse(_baseUrl + "/detail/$id");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return RestaurantDetailResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load detail restaurant');
    }
  }

  Future<RestaurantSearchResponse> getSearchRestaurants(String query) async {
    var url = Uri.parse(_baseUrl + "/search?q=$query");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return RestaurantSearchResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load list of restaurants');
    }
  }
}
