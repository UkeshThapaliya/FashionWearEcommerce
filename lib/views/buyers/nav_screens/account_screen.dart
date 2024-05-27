import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashionwear_ecommerce/views/buyers/auth/login_screen.dart';
import 'package:fashionwear_ecommerce/views/buyers/auth/register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
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
            body: Scaffold(
              appBar: AppBar(
                  elevation: 2,
                  backgroundColor: Colors.green,
                  title: Text(
                    'Profile',
                    style: TextStyle(
                      letterSpacing: 2,
                    ),
                  ),
                  centerTitle: true,
                  actions: [
                    Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Icon(Icons.star),
                    ),
                  ]),
              body: Column(
                children: [
                  Center(
                    child: CircleAvatar(
                      radius: 64,
                      backgroundColor: Colors.green,
                      backgroundImage: NetworkImage(data['profileImage']),
                    ),
                  ),
                  Text(
                    data['fullName'],
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      data['email'],
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Divider(
                      thickness: 2,
                      color: Colors.grey,
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('Setting'),
                  ),
                  ListTile(
                    leading: Icon(Icons.phone),
                    title: Text('Phone'),
                  ),
                  ListTile(
                    leading: Icon(CupertinoIcons.cart),
                    title: Text('Cart'),
                  ),
                  ListTile(
                    leading: Icon(Icons.shopping_cart),
                    title: Text('Orders'),
                  ),
                  ListTile(
                    onTap: () async {
                      await _auth.signOut().whenComplete(() {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return LoginScreen();
                        }));
                      });
                    },
                    leading: Icon(Icons.logout),
                    title: Text('Log Out'),
                  ),
                ],
              ),
            ),
          );
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
