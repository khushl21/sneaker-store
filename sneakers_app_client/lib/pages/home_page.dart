import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sneakers_app_client/controller/home_controller.dart';
import 'package:sneakers_app_client/pages/login_page.dart';
import 'package:sneakers_app_client/pages/product_description.dart';
import 'package:sneakers_app_client/widgets/dropdown.dart';
import 'package:sneakers_app_client/widgets/product_card.dart';

import '../widgets/multiselect_dropdown.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (ctrl) {
      return RefreshIndicator(
        onRefresh: () async {
          await ctrl.fetchProducts();
        },
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('Sneaker Store',
                style: TextStyle(fontWeight: FontWeight.bold)),
            actions: [
              IconButton(
                icon: Icon(Icons.logout),
                onPressed: () {
                  GetStorage box = GetStorage();
                  box.erase();
                  Get.offAll(LoginPage());
                  Navigator.pushReplacementNamed(context, '/login');
                },
              ),
            ],
          ),
          body: Column(
            children: [
              SizedBox(
                height: 50,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: ctrl.categories.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          ctrl.filterByCategory(ctrl.categories[index].name?? "Category");
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Chip(label: Text(ctrl.categories[index].name?? "Category")),
                        ),
                      );
                    }),
              ),
              Row(
                children: [
                  Flexible(
                    child: DropDownBtn(
                        items: ['Price: Low to High', 'Price: High to Low'],
                        selectedItemText: 'Sort Items',
                        onSelected: (selectedValue) {
                          ctrl.sortByPrice(ascending: selectedValue == 'Price: Low to High');
                        }),
                  ),
                  Flexible(
                      child: MultiSelectDropdown(
                        items: ['Nike', 'Adidas', 'Puma', 'Reebok', 'Vans', 'Converse', 'Under Armour', 'Skechers', 'FILA'],
                        onSelectionChanged: (selectedItems) {
                          ctrl.filterByBrand(selectedItems);
                        },
                      )),
                ],
              ),
              Expanded(
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.8,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8),
                    itemCount: ctrl.visibleProducts.length,
                    itemBuilder: (context, index) {
                      return ProductCard(
                        productName: ctrl.visibleProducts[index].name ?? "Product Name",
                        price: ctrl.visibleProducts[index].price ?? 0,
                        discount: 10,
                        imageUrl:
                        ctrl.visibleProducts[index].image ?? "Image Url",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDescription(),
                            ),
                          );
                        },
                      );
                    }),
              ),
            ],
          ),
        ),
      );
    });
  }
}
