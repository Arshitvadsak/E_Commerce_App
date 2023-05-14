import 'package:flutter/material.dart';
import '../favourite.dart';
import 'cart_page.dart';
import 'product_page.dart';

class home_page extends StatefulWidget {
  const home_page({Key? key}) : super(key: key);

  @override
  State<home_page> createState() => _home_pageState();
}

late TabController tabController;
int initialTabIndex = 1;

class _home_pageState extends State<home_page> with TickerProviderStateMixin {
  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this, initialIndex: 1);
    super.initState();
  }

  PageController pageController = PageController();
  int selected = 0;
  @override
  void dispose() {
    // TODO: implement dispose
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
            ),
            label: "Favourite",
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: 'Product'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.shopping_cart,
              ),
              label: 'Cart')
        ],
        onTap: (val) {
          setState(() {
            initialTabIndex = val;
          });
        },
        currentIndex: initialTabIndex,
      ),
      body: IndexedStack(
        index: initialTabIndex,
        children: const [
          FavouritePage(),
          ProductPage(),
          cart_page(),
        ],
      ),
    );
  }
}
