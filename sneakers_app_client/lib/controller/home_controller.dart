import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sneakers_app_client/models/category/category.dart';

import '../models/product/product.dart';

class HomeController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference productCollection;
  late CollectionReference categoryCollection;

  List<Product> products = [];
  List<Product> visibleProducts = [];
  List<Category> categories = [];

  @override
  Future<void> onInit() async {
    productCollection = firestore.collection('products');
    categoryCollection = firestore.collection('categories');
    await fetchCategory();
    await fetchProducts();
    super.onInit();
  }

  fetchProducts() async {
    try {
      QuerySnapshot productSnapshot = await productCollection.get();
      final List<Product> retrievedProducts = productSnapshot.docs
          .map((doc) => Product.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      products.clear();
      products.assignAll(retrievedProducts);
      visibleProducts.assignAll(products);
      Get.snackbar('Success', 'Products fetched successfully',
          colorText: Colors.white, backgroundColor: Colors.green);
    } on Exception catch (e) {
      // TODO
      Get.snackbar('Error', 'Failed to fetch products',
          colorText: Colors.white, backgroundColor: Colors.red);
    } finally {
      update();
    }
  }

  fetchCategory() async {
    try {
      QuerySnapshot categorySnapshot = await categoryCollection.get();
      final List<Category> retrievedCategories = categorySnapshot.docs
          .map((doc) => Category.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      categories.clear();
      categories.assignAll(retrievedCategories);
      //Get.snackbar('Success', 'Categories fetched successfully', colorText: Colors.white, backgroundColor: Colors.green);
    } on Exception catch (e) {
      // TODO
      Get.snackbar('Error', 'Failed to fetch categories',
          colorText: Colors.white, backgroundColor: Colors.red);
    } finally {
      update();
    }
  }

  filterByCategory(String category) {
    if(category == 'All') {
      visibleProducts.assignAll(products);
      update();
      return;
    }
    List<Product> filteredProducts;
    filteredProducts = visibleProducts.where((product) => product.category == category).toList();
    visibleProducts.clear();
    visibleProducts.assignAll(filteredProducts);
    update();
  }

  filterByBrand(List<String> brands) {
    if(brands.isEmpty) {
      visibleProducts.assignAll(products);
      update();
      return;
    }
    List<Product> filteredProducts;
    filteredProducts = visibleProducts.where((product) => brands.contains(product.brand)).toList();
    visibleProducts.clear();
    visibleProducts.assignAll(filteredProducts);
    update();
  }

  sortByPrice({required bool ascending}){
    List<Product> sortedProducts = visibleProducts;
    sortedProducts.sort((a, b) => ascending ? a.price!.compareTo(b.price!) : b.price!.compareTo(a.price!));
    visibleProducts.clear();
    visibleProducts.assignAll(sortedProducts);
    update();
  }

}
