import 'package:flutter/material.dart';
import 'package:utueji/src/core/resources/images/app_images.dart';

class CampaignCreatedSuccessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                AppImages.success,
                width: 100,
              ),
              SizedBox(height: 20.0),
              Text(
                'Todos os seus documentos foram enviados para verificação e você receberá uma atualização dentro de 24 horas úteis no seu celular ou e-mail registrado.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 40.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Concluído'),
                style: ElevatedButton.styleFrom(
                  // primary: Colors.green,
                  padding:
                      EdgeInsets.symmetric(horizontal: 50.0, vertical: 15.0),
                  textStyle: TextStyle(fontSize: 16.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
