import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:otp_text_field_v2/otp_field_v2.dart';
import 'package:sneakers_app_client/pages/home_page.dart';

import '../models/user/user.dart';

class LoginController extends GetxController {

  GetStorage box = GetStorage();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference users;

  TextEditingController nameController = TextEditingController();
  TextEditingController phonenoController = TextEditingController();

  TextEditingController loginController = TextEditingController();

  OtpFieldControllerV2 otpController = OtpFieldControllerV2();
  bool otpVisible = false;
  String buttonTitle = 'Send OTP';
  int? otpSent;
  int? otpEntered;

  User? loginUser;

  @override
  void onReady() {
    Map<String, dynamic>? user = box.read('loginUser');
    if (user != null) {
      loginUser = User.fromJson(user);
      Get.to(const HomePage());
    }
    super.onReady();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    users = firestore.collection('users');
    super.onInit();
  }

  addUser() {
    try {
      if (otpEntered != otpSent) {
        Get.snackbar('Error', 'Invalid OTP',
            colorText: Colors.white, backgroundColor: Colors.red);
        return;
      }
      DocumentReference doc = users.doc();
      User user = User(
        id: doc.id,
        name: nameController.text,
        phoneno: int.parse(phonenoController.text),
      );
      doc.set(user.toJson());
      Get.snackbar('Success', 'User added successfully',
          colorText: Colors.white, backgroundColor: Colors.green);
      nameController.clear();
      phonenoController.clear();
      otpController.clear();
      otpVisible = false;
      buttonTitle = 'Send OTP';
      update();
    } on Exception catch (e) {
      // TODO
      Get.snackbar('Error', 'Failed to add user',
          colorText: Colors.white, backgroundColor: Colors.red);
    }
  }

  sendOtp() {
    if (nameController.text.isEmpty || phonenoController.text.isEmpty) {
      Get.snackbar('Error', 'Please fill all fields',
          colorText: Colors.white, backgroundColor: Colors.red);
      return;
    }
    final random = Random();
    int otp = 1000 + random.nextInt(9000);
    print(otp);
    // check if otp sent successfully
    if (otp != null) {
      otpSent = otp;
      otpVisible = true;
      buttonTitle = 'Register Now';
      update();
      Get.snackbar('Success', 'OTP sent successfully',
          colorText: Colors.white, backgroundColor: Colors.green);
    } else {
      Get.snackbar('Error', 'Failed to send OTP',
          colorText: Colors.white, backgroundColor: Colors.red);
    }
  }

  Future<void> loginWithPhone() async {
    try{
      String phoneNumber = loginController.text;
      if (phoneNumber.isNotEmpty){
        var querySnapshot = await users.where('phoneno', isEqualTo: int.parse(phoneNumber)).limit(1).get();
        if (querySnapshot.docs.isNotEmpty) {
          var userDoc = querySnapshot.docs.first;
          var userData = userDoc.data() as Map<String, dynamic>;
          box.write('loginUser', userData);
          loginController.clear();
          Get.to(const HomePage());
          Get.snackbar('Success', 'Login Successful', colorText: Colors.white,
              backgroundColor: Colors.green);
        }
        else{
          Get.snackbar('Error', 'User not found. please register first', colorText: Colors.white, backgroundColor: Colors.red);
        }
      }
    }
    catch(e){
      print(e);
    }
  }

}


