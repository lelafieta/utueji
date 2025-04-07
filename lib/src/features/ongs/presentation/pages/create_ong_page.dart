import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_file_picker/form_builder_file_picker.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';

import '../../../../core/resources/images/app_images.dart';

class CreateOngPage extends StatefulWidget {
  @override
  _CreateOngPageState createState() => _CreateOngPageState();
}

class _CreateOngPageState extends State<CreateOngPage> {
  final _formStepOneKey = GlobalKey<FormBuilderState>();
  final _formStepTwoKey = GlobalKey<FormBuilderState>();
  final _formStepThreeKey = GlobalKey<FormBuilderState>();
  final _formStepFourKey = GlobalKey<FormBuilderState>();

  int activeStep = 0;

  void _handleBack() {
    if (activeStep > 0) {
      setState(() {
        activeStep--;
      });
    } else {
      Navigator.pop(context);
    }
  }

  void _handleNext() {
    final currentFormKey = [
      _formStepOneKey,
      _formStepTwoKey,
      _formStepThreeKey,
      _formStepFourKey,
    ][activeStep];

    if (currentFormKey.currentState?.saveAndValidate() ?? false) {
      if (activeStep < 3) {
        setState(() => activeStep++);
      } else {
        // Submissão final
        final allData = {
          ..._formStepOneKey.currentState!.value,
          ..._formStepTwoKey.currentState!.value,
          ..._formStepThreeKey.currentState!.value,
          ..._formStepFourKey.currentState!.value,
        };
        print("Dados finais: $allData");
      }
    } else {
      print("Formulário inválido no passo $activeStep!");
    }
  }

  Widget getStepContent(int step) {
    switch (step) {
      case 0:
        return stepOne(context);
      case 1:
        return stepTwo(context);
      case 2:
        return stepThree(context);
      case 3:
        return stepFour(context);
      default:
        return stepOne(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro de ONG'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: _handleBack,
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: _handleNext,
                child:
                    Text(activeStep < 3 ? "Guardar & Continuar" : "Finalizar"),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          ListTile(
            leading: Image.asset(AppImages.ong, width: 45, height: 45),
            title: Text("Passo ${activeStep + 1}/4"),
            subtitle: Text(
              [
                "Informações básicas",
                "Contato e Verificação",
                "Imagens e Missão",
                "Sobre e Localização"
              ][activeStep],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(bottom: 80),
              child: getStepContent(activeStep),
            ),
          )
        ],
      ),
    );
  }

  Widget stepOne(BuildContext context) {
    return FormBuilder(
      key: _formStepOneKey,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context)
                      .style
                      .copyWith(color: Colors.black),
                  children: [
                    TextSpan(
                      text: "Objetivo de arrecadar fundos ",
                    ),
                    TextSpan(
                        text: "*",
                        style: TextStyle(color: Colors.red, fontSize: 16))
                  ],
                ),
              ),
            ),
            FormBuilderTextField(
              name: "name",
              decoration: InputDecoration(labelText: "Nome da ONG *"),
              validator: FormBuilderValidators.required(),
            ),
            FormBuilderTextField(
              name: "bio",
              decoration: InputDecoration(labelText: "Biografia *"),
              maxLines: 3,
              validator: FormBuilderValidators.required(),
            ),
            FormBuilderTextField(
              name: "about",
              decoration: InputDecoration(labelText: "Sobre *"),
              maxLines: 4,
              validator: FormBuilderValidators.required(),
            ),
          ],
        ),
      ),
    );
  }

  Widget stepTwo(BuildContext context) {
    return FormBuilder(
      key: _formStepTwoKey,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            FormBuilderTextField(
              name: "phone_number",
              decoration: InputDecoration(labelText: "Telefone *"),
              validator: FormBuilderValidators.required(),
              keyboardType: TextInputType.phone,
            ),
            FormBuilderDropdown(
              name: "status",
              decoration: InputDecoration(labelText: "Status *"),
              initialValue: "pending",
              items: ['pending', 'active', 'inactive', 'failed', 'canceled']
                  .map((status) => DropdownMenuItem(
                        value: status,
                        child: Text(status),
                      ))
                  .toList(),
              validator: FormBuilderValidators.required(),
            ),
            FormBuilderSwitch(
              name: "is_verified",
              title: Text("ONG verificada?"),
              initialValue: false,
            ),
          ],
        ),
      ),
    );
  }

  Widget stepThree(BuildContext context) {
    return FormBuilder(
      key: _formStepThreeKey,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            FormBuilderFilePicker(
              name: "profile_image_url",
              decoration: InputDecoration(labelText: "Imagem de Perfil"),
              maxFiles: 1,
              previewImages: true,
              allowedExtensions: ['jpg', 'jpeg', 'png'],
            ),
            FormBuilderFilePicker(
              name: "cover_image_url",
              decoration: InputDecoration(labelText: "Imagem de Capa"),
              maxFiles: 1,
              previewImages: true,
              allowedExtensions: ['jpg', 'jpeg', 'png'],
            ),
            FormBuilderTextField(
              name: "mission",
              decoration: InputDecoration(labelText: "Missão"),
              maxLines: 3,
            ),
            FormBuilderTextField(
              name: "vision",
              decoration: InputDecoration(labelText: "Visão"),
              maxLines: 3,
            ),
          ],
        ),
      ),
    );
  }

  Widget stepFour(BuildContext context) {
    return FormBuilder(
      key: _formStepFourKey,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            FormBuilderTextField(
              name: "services_number",
              decoration: InputDecoration(labelText: "Número de serviços"),
              keyboardType: TextInputType.number,
            ),
            FormBuilderTextField(
              name: "supports_number",
              decoration: InputDecoration(labelText: "Número de apoios"),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            FormBuilderTextField(
              name: "location",
              readOnly: true,
              decoration: InputDecoration(
                labelText: "Localização",
                suffixIcon: Icon(Icons.search),
              ),
              onTap: () {
                // Lógica de localização
              },
            ),
          ],
        ),
      ),
    );
  }
}
