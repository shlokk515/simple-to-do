import 'dart:async';

import 'package:flutter/material.dart';
import 'package:navbar_router/navbar_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

const Color mediumPurple = Color.fromRGBO(79, 0, 241, 1.0);
final List<Color> colors = [mediumPurple, Colors.orange, Colors.teal];

class _HomePageState extends State<HomePage> {
  List<NavbarItem> items = [
    NavbarItem(Icons.home, 'Home', backgroundColor: colors[0]),
    NavbarItem(Icons.shopping_bag, 'Products', backgroundColor: colors[1]),
    NavbarItem(Icons.person, 'Me', backgroundColor: colors[2]),
    NavbarItem(Icons.settings, 'Settings', backgroundColor: colors[0]),
  ];

  final Map<int, Map<String, Widget>> _routes = const {
    0: {
      '/': HomeFeeds(),
      FeedDetail.route: FeedDetail(),
    },
    1: {
      '/': ProductList(),
      ProductDetail.route: ProductDetail(),
      ProductComments.route: ProductComments(),
    },
    2: {
      '/': UserProfile(),
      ProfileEdit.route: ProfileEdit(),
    },
    3: {
      '/': Settings(),
    },
  };

  void showSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        behavior: SnackBarBehavior.floating,
        duration: Duration(milliseconds: 600),
        margin: EdgeInsets.only(
            bottom: kBottomNavigationBarHeight, right: 2, left: 2),
        content: Text('Tap back button again to exit'),
      ),
    );
  }

  void hideSnackBar() {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }

  DateTime oldTime = DateTime.now();
  DateTime newTime = DateTime.now();

  /// This is only for demo purposes
  void simulateTabChange() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      for (int i = 0; i < items.length * 2; i++) {
        NavbarNotifier.index = i % items.length;
        await Future.delayed(const Duration(milliseconds: 1000));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    // simulateTabChange();
    NavbarNotifier.addIndexChangeListener((x) {
      print('NavbarNotifier.indexChangeListener: $x');
    });
  }

  @override
  void dispose() {
    NavbarNotifier.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 60.0),
        child: FloatingActionButton(
          child: Icon(NavbarNotifier.isNavbarHidden
              ? Icons.toggle_off
              : Icons.toggle_on),
          onPressed: () {
            // Programmatically toggle the Navbar visibility
            if (NavbarNotifier.isNavbarHidden) {
              NavbarNotifier.hideBottomNavBar = false;
            } else {
              NavbarNotifier.hideBottomNavBar = true;
            }
            setState(() {});
          },
        ),
      ),
      body: NavbarRouter(
        errorBuilder: (context) {
          return const Center(child: Text('Error 404'));
        },
        isDesktop: size.width > 600 ? true : false,
        onBackButtonPressed: (isExitingApp) {
          if (isExitingApp) {
            newTime = DateTime.now();
            int difference = newTime.difference(oldTime).inMilliseconds;
            oldTime = newTime;
            if (difference < 1000) {
              hideSnackBar();
              return isExitingApp;
            } else {
              showSnackBar();
              return false;
            }
          } else {
            return isExitingApp;
          }
        },
        initialIndex: 2,
        type: NavbarType.material3,
        destinationAnimationCurve: Curves.fastOutSlowIn,
        destinationAnimationDuration: 600,
        decoration: M3NavbarDecoration(
            labelTextStyle: const TextStyle(
                color: Color.fromARGB(255, 176, 207, 233), fontSize: 14),
            elevation: 3.0,
            backgroundColor: Colors.indigo,
            indicatorShape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            indicatorColor: const Color.fromARGB(255, 176, 207, 233),
            // iconTheme: const IconThemeData(color: Colors.indigo),
            /// labelTextStyle: const TextStyle(color: Colors.white, fontSize: 14),
            labelBehavior: NavigationDestinationLabelBehavior.alwaysShow),
        onChanged: (x) {},
        backButtonBehavior: BackButtonBehavior.rememberHistory,
        destinations: [
          for (int i = 0; i < items.length; i++)
            DestinationRouter(
              navbarItem: items[i],
              destinations: [
                for (int j = 0; j < _routes[i]!.keys.length; j++)
                  Destination(
                    route: _routes[i]!.keys.elementAt(j),
                    widget: _routes[i]!.values.elementAt(j),
                  ),
              ],
              initialRoute: _routes[i]!.keys.first,
            ),
        ],
      ),
    );
  }
}
