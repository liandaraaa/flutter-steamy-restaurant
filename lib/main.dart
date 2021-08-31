import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/db/database_helper.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/data/preferences/preferences_helper.dart';
import 'package:restaurant_app/data/provider/database_provider.dart';
import 'package:restaurant_app/data/provider/preferences_provider.dart';
import 'package:restaurant_app/data/provider/restaurant_list_provider.dart';
import 'package:restaurant_app/data/provider/scheduling_provider.dart';
import 'package:restaurant_app/ui/customer_reviews_page.dart';
import 'package:restaurant_app/ui/home_page.dart';
import 'package:restaurant_app/ui/restaurant_detail_page.dart';
import 'package:restaurant_app/ui/restaurant_list_page.dart';
import 'package:restaurant_app/ui/restaurant_search_page.dart';
import 'package:restaurant_app/ui/splash_screen_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Init.instance.initialize(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(home: SplashScreenPage());
        } else {
          return MainPage();
        }
      },
    );
  }
}

class MainPage extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => RestaurantListProvider(apiService: ApiService())),
        ChangeNotifierProvider(create: (_) => SchedulingProvider()),
        ChangeNotifierProvider(
            create: (_) => PreferencesProvider(
                preferencesHelper: PreferencesHelper(
                    sharedPreferences: SharedPreferences.getInstance()))),
        ChangeNotifierProvider(create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper()))
      ],
      child: Consumer<PreferencesProvider>(
        builder: (context, provider, child) {
          return MaterialApp(
            title: 'Steamy Restaurant',
            theme: provider.themeData,
            initialRoute: HomePage.routName,
            routes: {
              HomePage.routName: (context) => HomePage(),
              RestaurantListPage.routName: (context) => RestaurantListPage(),
              RestaurantPage.routName: (context) => RestaurantPage(
                  restaurant:
                      ModalRoute.of(context)?.settings.arguments as Restaurant),
              RestaurantSearchPage.routName: (context) => RestaurantSearchPage(
                  query: ModalRoute.of(context)?.settings.arguments as String),
              CustomerReviewsPage.routName: (context) => CustomerReviewsPage(
                  reviews: ModalRoute.of(context)?.settings.arguments
                      as List<CustomerReview>)
            },
          );
        },
      ),
    );
  }
}
