import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashionwear_ecommerce/provider/cart_provider.dart';
import 'package:fashionwear_ecommerce/views/buyers/inner_screens/edit_profile.dart';
import 'package:fashionwear_ecommerce/views/buyers/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class CheckoutScreen extends StatefulWidget {
  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final CartProvider _cartProvider = Provider.of<CartProvider>(context);
    CollectionReference users = FirebaseFirestore.instance.collection('buyers');
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(FirebaseAuth.instance.currentUser!.uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.green,
              title: Text(
                'Checkout',
                style: TextStyle(
                    fontSize: 18,
                    letterSpacing: 1,
                    fontWeight: FontWeight.bold),
              ),
            ),
            body: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: _cartProvider.getCartItem.length,
              itemBuilder: (context, index) {
                final cartData =
                    _cartProvider.getCartItem.values.toList()[index];
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Card(
                    child: SizedBox(
                      height:
                          180, // Slightly increased height to prevent overflow
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
                              padding:
                                  const EdgeInsets.all(10.0), // Reduced padding
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            bottomSheet: data['address'] == ""
                ? TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return EditProfile(
                          userData: data,
                        );
                      })).whenComplete(() {
                        Navigator.pop(context);
                      });
                    },
                    child: Text('Enter Billing Address'))
                : Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: InkWell(
                      onTap: () {
                        EasyLoading.show(status: 'Placing Order');
                        //We want to able to place order
                        _cartProvider.getCartItem.forEach((key, item) {
                          final orderId = Uuid().v4();
                          _firestore.collection('orders').doc(orderId).set({
                            'orderId': orderId,
                            'vendorId': item.vendorId,
                            'email': data['email'],
                            'phone': data['phoneNumber'],
                            'address': data['address'],
                            'buyerId': data['buyerId'],
                            'fullName': data['fullName'],
                            'buyerPhoto': data['profilePhoto'],
                            'productName': item.productName,
                            'productPrice': item.price,
                            'productId': item.productId,
                            'productImage': item.imageUrl,
                            'quantity': item.productQuantity,
                            'scheduleDate': item.scheduleDate,
                            'productSize': item.productSize,
                          }).whenComplete(() {
                            _cartProvider.getCartItem.clear();
                          });
                          EasyLoading.dismiss();

                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                            return MainScreen();
                          }));
                        });
                      },
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            'PLACE ORDER',
                            style: TextStyle(
                                color: Colors.white,
                                letterSpacing: 1,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
          );
        }

        return Center(
            child: CircularProgressIndicator(
          color: Colors.green,
        ));
      },
    );
  }
}
