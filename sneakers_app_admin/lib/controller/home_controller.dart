import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sneakers_app/model/product/product.dart';

class HomeController extends GetxController {

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference productCollection;

  TextEditingController productNameController = TextEditingController();
  TextEditingController productDescriptionController = TextEditingController();
  TextEditingController productImageController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();

  String category = 'Sneakers';
  String brand = 'Nike';
  bool offer = false;

  List<Product> products = [];

  @override
  Future<void> onInit() async {
    productCollection = firestore.collection('products');
    await fetchProducts();
    super.onInit();
  }


  addProduct(){
    try {
      DocumentReference doc = productCollection.doc();
      Product product = Product(
        id: doc.id,
        name: productNameController.text,
        category: category,
        description: productDescriptionController.text,
        image: productImageController.text,
        price: double.parse(productPriceController.text),
        brand: brand,
        offer: offer
      );
      doc.set(product.toJson());
      Get.snackbar('Success', 'Product added successfully', colorText: Colors.white, backgroundColor: Colors.green);
      setValuesDefault();
    } on Exception catch (e) {
      // TODO
      Get.snackbar('Error', 'Failed to add product', colorText: Colors.white, backgroundColor: Colors.red);
    }
  }

  fetchProducts() async {
    try {
      QuerySnapshot productSnapshot = await productCollection.get();
      final List<Product> retrievedProducts = productSnapshot.docs.map((doc) => Product.fromJson(doc.data() as Map<String, dynamic>)).toList();
      products.clear();
      products.assignAll(retrievedProducts);
      Get.snackbar('Success', 'Products fetched successfully', colorText: Colors.white, backgroundColor: Colors.green);
    } on Exception catch (e) {
      // TODO
      Get.snackbar('Error', 'Failed to fetch products', colorText: Colors.white, backgroundColor: Colors.red);
    } finally {
      update();
    }
  }

  deleteProduct(String id) async {
  try {
    await  productCollection.doc(id).delete();
    fetchProducts();
    Get.snackbar('Success', 'Product deleted successfully', colorText: Colors.white, backgroundColor: Colors.green);
  } on Exception catch (e) {
    // TODO
    Get.snackbar('Error', 'Failed to delete product', colorText: Colors.white, backgroundColor: Colors.red);
  }
  }

  setValuesDefault(){
    productNameController.text = '';
    productDescriptionController.text = '';
    productImageController.text = '';
    productPriceController.text = '';
    category = 'Sneakers';
    brand = 'Nike';
    offer = false;
    update();
  }

}