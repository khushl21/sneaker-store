import 'package:flutter/material.dart';
import 'package:sneakers_app/controller/home_controller.dart';
import 'package:sneakers_app/pages/add_product.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (ctrl) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Footware Admin"),
        ),
        body: ListView.builder(
            itemCount: ctrl.products.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(ctrl.products[index].name ?? 'Product Name'),
                subtitle: Text(ctrl.products[index].price.toString()),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    ctrl.deleteProduct(ctrl.products[index].id ?? '');
                  },
                ),
              );
            }),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(AddProduct());
          },
          child: Icon(Icons.add),
        ),
      );
    });
  }
}
