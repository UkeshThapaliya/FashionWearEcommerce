import 'package:flutter/material.dart';

class CategoryText extends StatelessWidget {
  final List<String> _categorylabel = [
    'Top Wear ',
    'OutWear',
    'Formal Wear',
    'Bottom Wear',
    'FootWear'
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(9.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Categories',
            style: TextStyle(
              fontSize: 19,
            ),
          ),
          SizedBox(height: 8), // Add some spacing below the text
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (var category in _categorylabel)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ActionChip(
                      backgroundColor: Colors.green,
                      onPressed: () {},
                      label: Text(
                        category,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
