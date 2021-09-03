import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant.dart';

import 'restaurant_list_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('Fetch restaurant api', () {
    final restaurantsExpected = [
      Restaurant(
          id: '12',
          name: 'resto',
          description: 'bagus',
          city: 'bogor',
          pictureId: '23223',
          rating: 23),
      Restaurant(
          id: '13',
          name: 'resto',
          description: 'bagus',
          city: 'bogor',
          pictureId: '23223',
          rating: 23),
      Restaurant(
          id: '14',
          name: 'resto',
          description: 'bagus',
          city: 'bogor',
          pictureId: '23223',
          rating: 23),
      Restaurant(
          id: '15',
          name: 'resto',
          description: 'bagus',
          city: 'bogor',
          pictureId: '23223',
          rating: 23),
    ];

    final responseExpected = RestaurantListResponse(
        error: false,
        message: 'berhasil',
        count: 4,
        restaurants: restaurantsExpected);

    test('should contain list of restaurant when api success', () async {
      //arrange
      final api = ApiService();
      final client = MockClient();

      //act
      var json = jsonEncode(responseExpected.toJson());
      when(client.get(api.restaurantListUrl))
          .thenAnswer((_) async => http.Response(json, 200));

      //assert
      var restaurantActual = await api.getRestaurants(client);
      expect(restaurantActual, isA<RestaurantListResponse>());
    });

    test('should contain list of restaurant when api failed', () {
      //arrange
      final api = ApiService();
      final client = MockClient();

      when(client.get(api.restaurantListUrl)).thenAnswer((_) async =>
          http.Response('Failed to load list of restaurants', 404));

      var restaurantActual = api.getRestaurants(client);
      expect(restaurantActual, throwsException);
    });

    test('should contain list of restaurant when no internet connection', () {
      //arrange
      final api = ApiService();
      final client = MockClient();

      when(client.get(api.restaurantListUrl)).thenAnswer(
          (_) async => throw SocketException('No Internet Connection'));

      var restaurantActual = api.getRestaurants(client);
      expect(restaurantActual, throwsException);
    });
  });
}
