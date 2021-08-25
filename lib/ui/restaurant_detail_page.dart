import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/state.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/data/provider/restaurant_detail_provider.dart';
import 'package:restaurant_app/ui/customer_reviews_page.dart';
import 'package:restaurant_app/widgets/error_widget.dart';
import 'package:restaurant_app/widgets/menu_list_widgets.dart';

class RestaurantPage extends StatefulWidget {
  static const routName = '/restaurant_detail';

  final Restaurant restaurant;

  const RestaurantPage({required this.restaurant});

  @override
  RestaurantPageState createState() => RestaurantPageState(id: restaurant.id);
}

class RestaurantPageState extends State<RestaurantPage> {
  String id;

  RestaurantPageState({required this.id});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RestaurantDetailProvider(apiService: ApiService(), id: id),
      child: RestaurantDetailPage(),
    );
  }
}

class RestaurantDetailPage extends StatelessWidget {
  Widget _buildDetail(BuildContext context) {
    return Consumer<RestaurantDetailProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.Loading) {
          return Center(child: CircularProgressIndicator());
        } else if (state.state == ResultState.HasData) {
          var restaurant = state.restaurantDetailResponse.restaurant;
          return _restaurantDetail(context, restaurant);
        } else if (state.state == ResultState.Error) {
          return ErrorWidgetPage(
              message: state.message, image: 'images/ic_error.png');
        } else {
          return Center(child: Text(''));
        }
      },
    );
  }

  Widget _restaurantDetail(BuildContext context, RestaurantDetail restaurants) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          restaurants.name,
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.network(restaurants.pictureId),
              Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        restaurants.name,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      SizedBox(height: 10),
                      InkWell(
                          child: Text("Tap to view Customer Reviews",
                          style: TextStyle(fontSize: 8, color: Colors.blue),),
                        onTap: () {
                          Navigator.pushNamed(context, CustomerReviewsPage.routName,
                              arguments: restaurants.customerReviews);
                        },
                      ),
                      Divider(color: Colors.grey),
                      Text('Rating: ${restaurants.rating}'),
                      SizedBox(height: 10),
                      Text('City: ${restaurants.city}'),
                      Divider(color: Colors.grey),
                      Text(
                        restaurants.description,
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 10),
                      Text("Foods",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14)),
                      SizedBox(height: 10),
                      MenuListWidget(menus: restaurants.menus, isFood: true),
                      SizedBox(height: 10),
                      Text("Drinks",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14)),
                      SizedBox(height: 10),
                      MenuListWidget(menus: restaurants.menus, isFood: false)
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildDetail(context);
  }
}
