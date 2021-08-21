import 'package:flutter/material.dart';
import 'package:testing/UI/widgets/ProductImage.dart';
import 'package:testing/core/models/product.dart';

class CartItemCard extends StatelessWidget {
  const CartItemCard(this.product);

  final Product product;

  List<Widget> _getProductDetails(BuildContext context) {
    return [
      Text(product.name,
          maxLines: 2, style: Theme.of(context).textTheme.subtitle2),
      Text('\$${product.price.toString()}.00',
          style: Theme.of(context).textTheme.headline6),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: new EdgeInsets.symmetric(horizontal: 20.0, vertical: 6.0),
      child: Container(
        height: 150.0,
        decoration: BoxDecoration(color: Colors.white),
        child: ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _getProductDetails(context),
                  ),
                ),
              ),
              VerticalDivider(),
              Container(
                height: 140,
                width: 160,
                child: ProductImage(product.imageUrl),
              )
            ],
          ),
        ),
      ),
    );
  }
}
