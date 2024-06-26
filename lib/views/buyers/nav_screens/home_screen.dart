import 'package:fashionwear_ecommerce/views/buyers/nav_screens/widgets/banner_widget.dart';
import 'package:flutter/material.dart';
import 'package:fashionwear_ecommerce/views/buyers/nav_screens/widgets/category_text.dart';
import 'package:fashionwear_ecommerce/views/buyers/nav_screens/widgets/search_input_widget.dart';
import 'package:fashionwear_ecommerce/views/buyers/nav_screens/widgets/welcome_text.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        WelcomeText(),
        SizedBox(
          height: 14,
        ),
        SearchInput(),
        BannerWidget(),
        CategoryText(),
      ],
    );
  }
}
