import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:testing/UI/view/HomePage.dart';
import 'package:testing/core/providers/auth_provider.dart';
import 'package:testing/root_page.dart';

import 'core/services/auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AuthProvider(
      auth: Auth(),
          child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: RootPage(),
      ),
    );
  }
}



