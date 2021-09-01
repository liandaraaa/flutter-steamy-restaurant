import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/ui/restaurant_detail_page.dart';
import 'package:restaurant_app/ui/restaurant_favorite_list_page.dart';
import 'package:restaurant_app/ui/restaurant_list_page.dart';
import 'package:restaurant_app/ui/settings_page.dart';
import 'package:restaurant_app/utils/notification_helper.dart';
import 'package:restaurant_app/widgets/platform_widgets.dart';

class HomePage extends StatefulWidget {
  static const routName = '/home_page';

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  var bottomNavIndex = 0;

  Widget appBarTitle = Text("Steamy Restaurant");
  Icon actionIcon = Icon(Icons.search);

  final NotificationHelper _notificationHelper = NotificationHelper();

  List<Widget> _listWidget = [
    RestaurantListPage(),
    RestaurantFavoriteListPage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(androidBuilder: _buildAndroid, iosBuilder: _buildIos);
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      body: _listWidget[bottomNavIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: secondaryColor,
        unselectedItemColor: Colors.grey,
        currentIndex: bottomNavIndex,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.restaurant), title: Text('Home')),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), title: Text('Favorite')),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), title: Text("Settings"))
        ],
        onTap: (selected) {
          setState(() {
            bottomNavIndex = selected;
          });
        },
      ),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.restaurant), title: Text('Home')),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), title: Text('Favorite')),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), title: Text('Settings'))
        ],
      ),
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return RestaurantListPage();
          case 1:
            return RestaurantFavoriteListPage();
          case 2:
            return SettingsPage();
          default:
            return RestaurantListPage();
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _notificationHelper
        .configureSelectNotificationSubject(RestaurantPage.routName);
  }

  @override
  void dispose() {
    selectNotificationSubject.close();
    super.dispose();
  }
}
