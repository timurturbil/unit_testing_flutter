import 'package:flutter/material.dart';
import 'package:testing/UI/widgets/CardItemWidget.dart';
import 'package:testing/core/models/product.dart';
import 'package:testing/core/providers/auth_provider.dart';
import 'package:testing/core/services/auth.dart';
import 'package:testing/core/services/api.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({this.onSignedOut});
  final VoidCallback onSignedOut;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> _signOut(BuildContext context) async {
    try {
      final Auth auth = AuthProvider.of(context).auth;
      await auth.signOut();
      widget.onSignedOut();
    } catch (e) {
      print(e);
    }
  }

  Product myProduct;
  @override
  void initState() {
    _fetchList();
    // TODO: implement initState
    super.initState();
  }

  _fetchList() async {
    final result = await API().getProducts(http.Client());
    setState(() {
      myProduct = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome'),
        actions: <Widget>[
          TextButton(
            child: Text('Logout',
                style: TextStyle(fontSize: 17.0, color: Colors.white)),
            onPressed: () => _signOut(context),
          ),
        ],
      ),
      body: myProduct != null
          ? CartItemCard(myProduct)
          : Center(child: CircularProgressIndicator()),
    );
  }
}
