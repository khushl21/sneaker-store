import 'package:flutter/material.dart';

class ProductDescription extends StatelessWidget {
  const ProductDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Description', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                'https://imgs.search.brave.com/zri0ifM-OEdeUhF5_XpqKDnG0aTinRy6lnkJiYN5PHU/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9zdGF0/aWMubmlrZS5jb20v/YS9pbWFnZXMvd18x/OTIwLGNfbGltaXQv/OTdlNDM3OTgtYTE1/ZS00YzEwLThlZDAt/ZGY1YWQ1ODk5NDMw/L2pvcmRhbi1icmFu/ZC1sYXVuY2hlcy10/aGUtYWlyLWpvcmRh/bi14eHh2aWlpLmpw/Zw',
                height: 200,
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 30),
            Text('Product Name', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
            SizedBox(height: 10),
            Text('Product Description', style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
            Text('\u20B925,999', style: TextStyle(fontSize: 22)),
            SizedBox(height: 5),
            const Chip(
              label: Text('10% off', style: TextStyle(color: Colors.white)),
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
            SizedBox(height: 30),
            TextField(
              maxLines: 5,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                labelText: 'Enter your Billing Address',
              ),
            ),
            SizedBox(height: 30),
            SizedBox(
              width: double.maxFinite,
              child: ElevatedButton(
                onPressed: () {},
                child: Text('Buy Now', style: TextStyle(fontSize: 18, color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  backgroundColor: Colors.blue,
                ),
              ),
            ),
          ]
        ),
      ),
    );
  }
}
