import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/data/provider/restaurant_provider.dart';

import 'restaurant_detail_page.dart';
import 'restaurant_list_page.dart';

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

class SplashScreenPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xe1f5fe).withOpacity(1.0),
      body: Center(child: Image.asset('images/steamy_logo_big.png')),
    );
  }
}

class Init {
  Init._();

  static final instance = Init._();

  Future initialize() async {
    await Future.delayed(Duration(seconds: 3));
  }
}

class MainPage extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Steamy Restaurant',
      theme: ThemeData(
          primaryColor: primaryColor,
          accentColor: secondaryColor,
          scaffoldBackgroundColor: Colors.white,
          textTheme: myTextTheme,
          appBarTheme: AppBarTheme(
              textTheme: myTextTheme.apply(bodyColor: Colors.black)),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  primary: secondaryColor,
                  textStyle: TextStyle(),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(0))))),
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity),
      initialRoute: HomePage.routName,
      routes: {
        HomePage.routName: (context) => HomePage(),
        RestaurantPage.routName: (context) => RestaurantPage(
            restaurant:
                ModalRoute.of(context)?.settings.arguments as Restaurant)
      },
    );
  }
}

class HomePage extends StatefulWidget {
  static const routName = '/home_page';

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  List<Widget> listWidget = [
    ChangeNotifierProvider(
      create: (_) => RestaurantListProvider(apiService: ApiService()),
      child: RestaurantListPage(),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RestaurantListProvider(apiService: ApiService()),
      child: RestaurantListPage(),
    );
  }
}
