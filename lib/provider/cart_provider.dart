import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashionwear_ecommerce/models/cart_attributes.dart';
import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  Map<String, CartAttr> _cartItems = {};
  Map<String, CartAttr> get getCartItem {
    return _cartItems;
  }

  double get totalPrice {
    var total = 0.0;
    _cartItems.forEach((key, value) {
      total += value.price * value.quantity;
    });
    return total;
  }

  void addProductToCart(
    String productName,
    String productId,
    List imageUrl,
    int quantity,
    int productQuantity,
    double price,
    String vendorId,
    String productSize,
    Timestamp scheduleDate,
  ) {
    if (_cartItems.containsKey(productId)) {
      _cartItems.update(
        productId,
        (existingCart) => CartAttr(
          productName: existingCart.productName,
          productId: existingCart.productId,
          imageUrl: existingCart.imageUrl,
          quantity: existingCart.quantity + 1,
          productQuantity: existingCart.productQuantity,
          price: existingCart.price,
          vendorId: existingCart.vendorId,
          productSize: existingCart.productSize,
          scheduleDate: existingCart.scheduleDate,
        ),
      );
    } else {
      _cartItems.putIfAbsent(
        productId,
        () => CartAttr(
          productName: productName,
          productId: productId,
          imageUrl: imageUrl,
          quantity: quantity,
          productQuantity: productQuantity,
          price: price,
          vendorId: vendorId,
          productSize: productSize,
          scheduleDate: scheduleDate,
        ),
      );
    }
    notifyListeners();
  }

  void increment(CartAttr cartAttr) {
    cartAttr.increase();
    notifyListeners();
  }

  void decrement(CartAttr cartAttr) {
    if (cartAttr.quantity > 1) {
      cartAttr.decrease();
    } else {
      _cartItems.remove(cartAttr.productId);
    }
    notifyListeners();
  }

  removeItem(productId) {
    _cartItems.remove(productId);
    notifyListeners();
  }

  removeAllItem() {
    _cartItems.clear();
    notifyListeners();
  }
}
