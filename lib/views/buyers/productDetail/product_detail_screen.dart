import 'package:fashionwear_ecommerce/provider/cart_provider.dart';
import 'package:fashionwear_ecommerce/utils/show_snackBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatefulWidget {
  final dynamic productData;
  const ProductDetailScreen({super.key, required this.productData});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  String formatedDate(date) {
    final outPutdateFormate = DateFormat('dd/MM/yyyy');

    final outPutDate = outPutdateFormate.format(date);
    return outPutDate;
  }

  int _imageIndex = 0;
  String? _selectedSize;
  @override
  Widget build(BuildContext context) {
    final CartProvider _cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          widget.productData['productName'],
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 300,
                  width: double.infinity,
                  child: PhotoView(
                    imageProvider: NetworkImage(
                      widget.productData['imageUrl'][_imageIndex],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.productData['imageUrl'].length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                _imageIndex = index;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.green,
                                  ),
                                ),
                                height: 60,
                                width: 60,
                                child: Image.network(
                                    widget.productData['imageUrl'][index]),
                              ),
                            ),
                          );
                        }),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(13.0),
              child: Text(
                '\$' +
                    " " +
                    widget.productData['productPrice'].toStringAsFixed(2),
                style: TextStyle(
                    fontSize: 22,
                    letterSpacing: 2,
                    fontWeight: FontWeight.bold,
                    color: Colors.green),
              ),
            ),
            Text(
              widget.productData['productName'],
              style: TextStyle(
                  fontSize: 22, letterSpacing: 2, fontWeight: FontWeight.bold),
            ),
            ExpansionTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Product Sescription',
                    style: TextStyle(color: Colors.green),
                  ),
                  Text(
                    "View More",
                    style: TextStyle(color: Colors.green),
                  ),
                ],
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.productData['description'],
                    style: TextStyle(
                      fontSize: 17,
                      letterSpacing: 1,
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'This product will be shipping on ',
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    formatedDate(
                      widget.productData['scheduleDate'].toDate(),
                    ),
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            ExpansionTile(
              title: Text('Available size'),
              children: [
                Container(
                  height: 50,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.productData['sizeList'].length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            color: _selectedSize ==
                                    widget.productData['sizeList'][index]
                                ? Colors.green
                                : null,
                            child: OutlinedButton(
                              onPressed: () {
                                setState(() {
                                  _selectedSize =
                                      widget.productData['sizeList'][index];
                                });
                                print(_selectedSize);
                              },
                              child: Text(
                                widget.productData['sizeList'][index],
                              ),
                            ),
                          ),
                        );
                      }),
                )
              ],
            )
          ],
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(10.0),
        child: InkWell(
          onTap: _cartProvider.getCartItem
                  .containsKey(widget.productData['productId'])
              ? null
              : () {
                  if (_selectedSize == null) {
                    return showSnack(context, 'Please select a size');
                  } else {
                    _cartProvider.addProductToCart(
                      widget.productData['productName'],
                      widget.productData['productId'],
                      widget.productData['imageUrl'],
                      1,
                      widget.productData['quantity'],
                      // widget.productData['quantity'],
                      widget.productData['productPrice'],
                      widget.productData['vendorId'],
                      _selectedSize!,
                      widget.productData['scheduleDate'],
                    );
                    return showSnack(context,
                        'You Added ${widget.productData['productName']} To Your Cart');
                  }
                },
          child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: _cartProvider.getCartItem
                      .containsKey(widget.productData['productId'])
                  ? Colors.green.shade100
                  : Colors.green,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  CupertinoIcons.cart,
                  color: Colors.white,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _cartProvider.getCartItem
                          .containsKey(widget.productData['productId'])
                      ? Text(
                          'IN CART',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            letterSpacing: 1,
                          ),
                        )
                      : Text('ADD TO CART',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            letterSpacing: 1,
                          )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
