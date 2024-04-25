import 'dart:io';

import 'package:fashionwear_ecommerce/views/buyers/main_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: FirebaseOptions(
              apiKey: "AIzaSyDN_R7TovMvsysXZ1naGx69VC_NuDPjv4Y",
              appId: "1:245683165794:android:c5480e46049bf6b43a8f3b",
              messagingSenderId: "245683165794 ",
              projectId: "fashionwear-9e6ab",
              storageBucket: "gs://fashionwear-9e6ab.appspot.com"))
      : await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FashionWear Ecommerce',
      theme: ThemeData(primarySwatch: Colors.green, fontFamily: 'Brand-Bold'),
      home: MainScreen(),
    );
  }
}
