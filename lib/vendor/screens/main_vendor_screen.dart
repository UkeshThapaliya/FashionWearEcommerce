import 'package:fashionwear_ecommerce/vendor/screens/earning_screen.dart';
import 'package:fashionwear_ecommerce/vendor/screens/edit_product_screen.dart';
import 'package:fashionwear_ecommerce/vendor/screens/upload_screen.dart';
import 'package:fashionwear_ecommerce/vendor/screens/vendor_order_screen.dart';
import 'package:fashionwear_ecommerce/vendor/views/auth/vendor_auth_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainvendorScreen extends StatefulWidget {
  const MainvendorScreen({super.key});

  @override
  State<MainvendorScreen> createState() => _MainvendorScreenState();
}

class _MainvendorScreenState extends State<MainvendorScreen> {
  int _pageIndex = 0;

  List<Widget> _pages = [
    EarningScreen(),
    UploadScreen(),
    EditProductScreen(),
    VenderOrderScreen(),
    VendorAuthScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _pageIndex,
        onTap: ((value) {
          setState(() {
            _pageIndex = value;
          });
        }),
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.green,
        items: [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.money_dollar),
            label: 'EARNINGS',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.upload),
            label: 'UPLOAD',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.edit),
            label: 'EDIT',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.shopping_cart),
            label: 'ORDERS',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout),
            label: 'LOGOUT',
          ),
        ],
      ),
      body: _pages[_pageIndex],
    );
  }
}
