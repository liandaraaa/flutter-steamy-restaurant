import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/state.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/provider/restaurant_search_provider.dart';
import 'package:restaurant_app/widgets/error_widget.dart';
import 'package:restaurant_app/widgets/platform_widgets.dart';
import 'package:restaurant_app/widgets/restaurant_item.dart';

class RestaurantSearchPage extends StatefulWidget {
  static const routName = '/restaurant_search';

  String query = '';

  RestaurantSearchPage({required this.query});

  @override
  RestaurantSearchPageState createState() =>
      RestaurantSearchPageState(query: query);
}

class RestaurantSearchPageState extends State<RestaurantSearchPage> {
  String query = '';

  RestaurantSearchPageState({required this.query});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          RestaurantSearchProvider(apiService: ApiService(), query: query),
      child:
          PlatformWidget(androidBuilder: _buildAndroid, iosBuilder: _buildIos),
    );
  }

  Widget _buildList(BuildContext context) {
    return Consumer<RestaurantSearchProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.Loading) {
          return Center(child: CircularProgressIndicator());
        } else if (state.state == ResultState.HasData) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: state.response.restaurants.length,
            itemBuilder: (context, index) {
              var restaurant = state.response.restaurants[index];
              return RestaurantItem(restaurant: restaurant);
            },
          );
        } else if (state.state == ResultState.NoData) {
          return ErrorWidgetPage(
            message: state.message,
            image: 'images/ic_empty.png',
          );
        } else if (state.state == ResultState.Error) {
          return ErrorWidgetPage(
            message: state.message,
            image: 'images/ic_error.png',
          );
        } else {
          return Center(child: Text(''));
        }
      },
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text(query)),
      body: _buildList(context),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          query,
        ),
      ),
      child: _buildList(context),
    );
  }
}
