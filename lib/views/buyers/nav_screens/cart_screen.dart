import 'package:fashionwear_ecommerce/provider/cart_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CartProvider _cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.green,
          elevation: 0,
          title: Text(
            'Cart Item',
            style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),
          ),
          actions: [
            IconButton(
              onPressed: () {
                _cartProvider.removeAllItem();
              },
              icon: Icon(CupertinoIcons.delete),
            ),
          ]),
      body: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: _cartProvider.getCartItem.length,
        itemBuilder: (context, index) {
          final cartData = _cartProvider.getCartItem.values.toList()[index];
          return Card(
            child: SizedBox(
              height: 180, // Slightly increased height to prevent overflow
              child: Row(
                children: [
                  SizedBox(
                    height: 100,
                    width: 100,
                    child: Image.network(
                      cartData.imageUrl[0],
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0), // Reduced padding
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            cartData.productName,
                            style: TextStyle(
                              fontSize: 18, // Reduced font size
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                            ),
                          ),
                          Text(
                            '\$ ${cartData.price.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 18, // Reduced font size
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                              color: Colors.green,
                            ),
                          ),
                          OutlinedButton(
                            onPressed: null,
                            child: Text(
                              cartData.productSize,
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                height: 40,
                                width: 120, // Increased width
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(
                                      5), // Added border radius
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .center, // Centered buttons
                                  children: [
                                    IconButton(
                                      onPressed: cartData.quantity == 1
                                          ? null
                                          : () {
                                              _cartProvider.decrement(
                                                  cartData); // Decrement quantity logic here
                                            },
                                      icon: Icon(
                                        CupertinoIcons.minus,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      cartData.quantity.toString(),
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    IconButton(
                                      onPressed: cartData.productQuantity ==
                                              cartData.quantity
                                          ? null
                                          : () {
                                              _cartProvider.increment(
                                                  cartData); // Increment quantity logic here
                                            },
                                      icon: Icon(
                                        CupertinoIcons.plus,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  _cartProvider.removeItem(cartData.productId);
                                },
                                icon: Icon(
                                  CupertinoIcons.cart_badge_minus,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),

      // ListView.builder
      // Container

      // body: Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       Text(
      //         'Your Shopping Cart is Empty',
      //         style: TextStyle(
      //           fontSize: 22,
      //           fontWeight: FontWeight.bold,
      //           letterSpacing: 2,
      //         ),
      //       ),
      //       SizedBox(height: 20),
      //       Container(
      //         height: 50,
      //         width: MediaQuery.of(context).size.width,
      //         decoration: BoxDecoration(
      //           color: Colors.green,
      //           borderRadius: BorderRadius.circular(10),
      //         ),
      //         child: Center(
      //           child: Text(
      //             'CONTINUE SHOPPING',
      //             style: TextStyle(
      //               fontSize: 19,
      //               color: Colors.white,
      //             ),
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),

      bottomSheet: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              '\$' +
                  " " +
                  _cartProvider.totalPrice.toStringAsFixed(2) +
                  "    " 'CHECKOUT',
              style: TextStyle(
                color: Colors.white,
                letterSpacing: 1,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
//TextStyle
// Center
  }
}
