import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:utueji/src/config/routes/app_routes.dart';

import '../../../../config/themes/app_colors.dart';

class SuccessRegisterOngPage extends StatelessWidget {
  final String successMessage;

  const SuccessRegisterOngPage({Key? key, required this.successMessage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sucesso'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.check_circle,
                color: AppColors.primaryColor,
                size: 80,
              ),
              const SizedBox(height: 20),
              Text(
                successMessage,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  // fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () {
                    Get.toNamed(AppRoutes.solidaryRoute);
                  },
                  child: Text("OK")),
            ],
          ),
        ),
      ),
    );
  }
}
