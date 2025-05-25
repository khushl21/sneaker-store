import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProductCard extends StatelessWidget {

  final String productName;
  final double price;
  final int discount;
  final String imageUrl;
  final value = new NumberFormat("#,##0.00", "en_US");
  final Function onTap;


  ProductCard({super.key, required this.productName, required this.price, required this.discount, required this.imageUrl, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Card(
        elevation: 2,
        child: Column(
          children: [
            Image.network(
              imageUrl,
              height: 150,
              width: double.maxFinite,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(productName, style: TextStyle(fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis),
                  Text('\u20B9${value.format(price)}'),
                  SizedBox(height: 5),
                  Chip(
                    label: Text('$discount% off', style: TextStyle(color: Colors.white)),
                    backgroundColor: Colors.green,
                    //reduce the height of the chip
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    //reduce the padding of the chip
                    padding: EdgeInsets.zero,
                    //make the chip smaller
                    visualDensity: VisualDensity.compact,
                    //add a border of 2 pixels around the chip
                    side: BorderSide(color: Colors.green, width: 0),

                  ),

                ],
              ),
            ),
          ],
        )
      ),
    );
  }
}
