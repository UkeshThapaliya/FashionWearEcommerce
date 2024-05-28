import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashionwear_ecommerce/provider/product_provider.dart';
import 'package:fashionwear_ecommerce/vendor/screens/main_vendor_screen.dart';
import 'package:fashionwear_ecommerce/vendor/screens/upload_tap_screens/attributes_tab_screen.dart';
import 'package:fashionwear_ecommerce/vendor/screens/upload_tap_screens/general_screen.dart';
import 'package:fashionwear_ecommerce/vendor/screens/upload_tap_screens/images_tab_screen.dart';
import 'package:fashionwear_ecommerce/vendor/screens/upload_tap_screens/shipping_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class UploadScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final ProductProvider _productProvider =
        Provider.of<ProductProvider>(context);
    return DefaultTabController(
      length: 4,
      child: Form(
        key: _formKey,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.green,
            elevation: 0,
            bottom: TabBar(
              tabs: [
                Tab(
                  child: Text('General'),
                ),
                Tab(
                  child: Text('Shipping'),
                ),
                Tab(
                  child: Text('Attributes'),
                ),
                Tab(
                  child: Text('Images'),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              GeneralScreen(),
              ShippingScreen(),
              AttributesTabScreen(),
              ImagesTabScreen(),
            ],
          ),
          bottomSheet: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              onPressed: () async {
                EasyLoading.show(status: 'Please Wait');
                if (_formKey.currentState!.validate()) {
                  final productId = Uuid().v4();
                  await _firestore.collection('products').doc(productId).set({
                    'productId': productId,
                    'productName': _productProvider.productData['productName'],
                    'productPrice':
                        _productProvider.productData['productPrice'],
                    'quantity': _productProvider.productData['quantity'],
                    'category': _productProvider.productData['category'],
                    'description': _productProvider.productData['description'],
                    'imageUrl': _productProvider.productData['imageUrlList'],
                    'scheduleDate':
                        _productProvider.productData['scheduleDate'],
                    'chargeShipping':
                        _productProvider.productData['chargeShipping'],
                    'shippingCharge':
                        _productProvider.productData['shippingCharge'],
                    'brandName': _productProvider.productData['brandName'],
                    'sizeList': _productProvider.productData['sizeList'],
                    'vendorId': FirebaseAuth.instance.currentUser?.uid,
                    'approved': false,
                  }).whenComplete(() {
                    EasyLoading.showSuccess('Done');
                    _productProvider.clearData();
                    _formKey.currentState!.reset();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return MainvendorScreen();
                      }),
                    );
                  });
                } else {
                  EasyLoading.dismiss();
                }
              },
              child: Text('Save'),
            ),
          ),
        ),
      ),
    );
  }
}
