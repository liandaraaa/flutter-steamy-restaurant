import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/ui/restaurant_list_page.dart';
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

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(androidBuilder: _buildAndroid, iosBuilder: _buildIos);
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      body: bottomNavIndex == 0 ? RestaurantListPage() : Placeholder(),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: secondaryColor,
        unselectedItemColor: Colors.grey,
        currentIndex: bottomNavIndex,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.restaurant), title: Text('Home')),
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
              icon: Icon(Icons.settings), title: Text('Settings'))
        ],
      ),
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return RestaurantListPage();
          case 1:
            return Placeholder();
          default:
            return Placeholder();
        }
      },
    );
  }
}
