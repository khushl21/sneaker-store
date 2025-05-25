import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:sneakers_app/controller/home_controller.dart';
import 'package:sneakers_app/widgets/dropdown.dart';

class AddProduct extends StatelessWidget {
  const AddProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (ctrl) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Add Product'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            width: double.maxFinite,
            margin: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Add New Product',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent),
                ),
                SizedBox(
                  height: 40,
                ),
                TextField(
                  controller: ctrl.productNameController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      label: Text('Product Name'),
                      hintText: 'Enter your Product Name'),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: ctrl.productDescriptionController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      label: Text('Description'),
                      hintText: 'Enter your Product Description'),
                  maxLines: 4,
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: ctrl.productImageController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      label: Text('Image URL'),
                      hintText: 'Enter your Product Image'),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: ctrl.productPriceController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      label: Text('Product Price'),
                      hintText: 'Enter your Product Price'),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Flexible(
                        child: Container(
                            height: 60,
                            child: DropDownBtn(
                              items: ['Sneakers', 'Running', 'Slides', 'Basketball', 'Football', 'Casual'],
                              selectedItemText: ctrl.category,
                              onSelected: (selectedValue) {
                                ctrl.category = selectedValue!;
                                ctrl.update();
                              },
                            ))),
                    Flexible(
                        child: Container(
                            height: 60,
                            child: DropDownBtn(
                              items: ['Nike', 'Adidas', 'Puma', 'Reebok', 'Vans', 'Converse', 'Under Armour', 'Skechers', 'FILA'],
                              selectedItemText: ctrl.brand,
                              onSelected: (selectedValue) {
                                ctrl.brand = selectedValue!;
                                ctrl.update();
                              },
                            ))),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text('Offer Product?'),
                DropDownBtn(
                  items: ['true', 'false'],
                  selectedItemText: ctrl.offer ? 'true' : 'false',
                  onSelected: (selectedValue) {
                    ctrl.offer = selectedValue == 'true' ? true : false;
                    ctrl.update();
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigoAccent,
                        foregroundColor: Colors.white),
                    onPressed: () {
                      ctrl.addProduct();
                    },
                    child: Text('Add Product'))
              ],
            ),
          ),
        ),
      );
    });
  }
}
