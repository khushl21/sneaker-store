import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:sneakers_app_client/controller/login_controller.dart';
import 'package:sneakers_app_client/pages/login_page.dart';
import 'package:sneakers_app_client/widgets/otp_textfield.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(builder: (ctrl) {
      return Scaffold(
        body: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.blue,
                Colors.blueAccent,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Create Account',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                keyboardType: TextInputType.text,
                controller: ctrl.nameController,
                decoration: InputDecoration(
                  hintText: 'Full Name',
                  hintStyle: TextStyle(color: Colors.white),
                  prefixIcon: Icon(Icons.person, color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                style: TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 20),
              TextField(
                keyboardType: TextInputType.phone,
                controller: ctrl.phonenoController,
                decoration: InputDecoration(
                  hintText: 'Phone Number',
                  hintStyle: TextStyle(color: Colors.white),
                  prefixIcon: Icon(Icons.phone, color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                style: TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 20),
              OtpTextfield(
                otpController: ctrl.otpController,
                visible: ctrl.otpVisible,
                onComplete: (otp) {
                  ctrl.otpEntered = int.parse(otp ?? '0000');
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (ctrl.otpVisible) {
                    ctrl.addUser();
                    return;
                  }
                  ctrl.sendOtp();
                },
                child: Text(ctrl.buttonTitle),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Get.to(const LoginPage());
                },
                child: const Text('Login Now', style: TextStyle(color: Colors.white)),
              )
            ],
          ),
        ),
      );
    });
  }
}
