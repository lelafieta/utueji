import 'package:awesome_place_search/awesome_place_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
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
  final googleApiKey = dotenv.env["GOOGLE_API_KEY"];
  final _formStepOneKey = GlobalKey<FormBuilderState>();
  final _formStepTwoKey = GlobalKey<FormBuilderState>();
  final _formStepThreeKey = GlobalKey<FormBuilderState>();
  final _formStepFourKey = GlobalKey<FormBuilderState>();
  TextEditingController controllerLocation = TextEditingController();

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

  void _searchPlaces() {
    AwesomePlaceSearch(
      context: context,
      apiKey: googleApiKey!,
      countries: ["ao"],
      errorText: "Alguma coisa correu mal",
      hint: "Pesquisar uma localização",
      dividerItemColor: Colors.grey.withOpacity(.5),
      dividerItemWidth: .5,
      elevation: 5,
      indicatorColor: Colors.blue,
      modalBorderRadius: 50.0,
      onTap: (value) async {
        final result = await value;
        controllerLocation.text = result.description!;
        // setState(() {
        //   prediction = result;

        // });
      },
    ).show();
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
                "Carregar documentos",
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
                      text: "Nome da ONG",
                    ),
                    TextSpan(
                        text: "*",
                        style: TextStyle(color: Colors.red, fontSize: 16))
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: FormBuilderTextField(
                name: "name",
                decoration: InputDecoration(labelText: "Nome da ONG"),
                validator: FormBuilderValidators.required(
                  errorText: "Campo obrigatório",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context)
                      .style
                      .copyWith(color: Colors.black),
                  children: [
                    TextSpan(
                      text: "Biografia",
                    ),
                    TextSpan(
                        text: "*",
                        style: TextStyle(color: Colors.red, fontSize: 16))
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: FormBuilderTextField(
                name: "bio",
                decoration: InputDecoration(hintText: "Biografia"),
                maxLines: 3,
                validator: FormBuilderValidators.required(
                  errorText: "Campo obrigatório",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context)
                      .style
                      .copyWith(color: Colors.black),
                  children: [
                    TextSpan(
                      text: "Sobre a ONG",
                    ),
                    TextSpan(
                        text: "*",
                        style: TextStyle(color: Colors.red, fontSize: 16))
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: FormBuilderTextField(
                name: "about",
                decoration: InputDecoration(hintText: "Uma breve descrição"),
                maxLines: 4,
                validator: FormBuilderValidators.required(
                  errorText: "Campo obrigatório",
                ),
              ),
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
                      text: "Contacto da ONG",
                    ),
                    TextSpan(
                        text: "*",
                        style: TextStyle(color: Colors.red, fontSize: 16))
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: FormBuilderTextField(
                name: "phone_number",
                decoration: InputDecoration(labelText: "Telefone"),
                validator: FormBuilderValidators.required(
                  errorText: "Campo obrigatório",
                ),
                keyboardType: TextInputType.phone,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context)
                      .style
                      .copyWith(color: Colors.black),
                  children: [
                    TextSpan(
                      text: "Localização da ONG",
                    ),
                    TextSpan(
                        text: "*",
                        style: TextStyle(color: Colors.red, fontSize: 16))
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: FormBuilderTextField(
                name: "location",
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: FormBuilderValidators.required(
                  errorText: 'Campo Obrigatório',
                ),
                controller: controllerLocation,
                readOnly: true,
                onTap: () {
                  _searchPlaces();
                },
                decoration: InputDecoration(
                  hintText: "Localização",
                  suffixIcon: Icon(Icons.search),
                ),
              ),
            ),

            // FormBuilderDropdown(
            //   name: "status",
            //   decoration: InputDecoration(labelText: "Status *"),
            //   initialValue: "pending",
            //   items: ['pending', 'active', 'inactive', 'failed', 'canceled']
            //       .map((status) => DropdownMenuItem(
            //             value: status,
            //             child: Text(status),
            //           ))
            //       .toList(),
            //   validator: FormBuilderValidators.required(),
            // ),
            // FormBuilderSwitch(
            //   name: "is_verified",
            //   title: Text("ONG verificada?"),
            //   initialValue: false,
            // ),
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
                      text: "Contacto da ONG",
                    ),
                    TextSpan(
                        text: "*",
                        style: TextStyle(color: Colors.red, fontSize: 16))
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: FormBuilderFilePicker(
                name: "profile_image_url",
                decoration: InputDecoration(labelText: "Imagem de Perfil"),
                maxFiles: 1,
                previewImages: true,
                allowedExtensions: ['jpg', 'jpeg', 'png'],
                typeSelectors: [
                  TypeSelector(
                    type: FileType.custom,
                    selector: Row(
                      children: <Widget>[
                        Icon(Icons.add_circle),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text("Adicionar imagem"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: FormBuilderFilePicker(
                name: "cover_image_url",
                decoration: InputDecoration(labelText: "Imagem de Capa"),
                maxFiles: 1,
                previewImages: true,
                allowedExtensions: ['jpg', 'jpeg', 'png'],
                typeSelectors: [
                  TypeSelector(
                    type: FileType.custom,
                    selector: Row(
                      children: <Widget>[
                        Icon(Icons.add_circle),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text("Adicionar imagem"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context)
                      .style
                      .copyWith(color: Colors.black),
                  children: [
                    TextSpan(
                      text: "Detalhes da ONG",
                    ),
                    TextSpan(
                        text: "*",
                        style: TextStyle(color: Colors.red, fontSize: 16))
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: FormBuilderTextField(
                name: "mission",
                decoration: InputDecoration(hintText: "Nossa Missão"),
                maxLines: 3,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: FormBuilderTextField(
                name: "vision",
                decoration: InputDecoration(hintText: "Nossa Visão"),
                maxLines: 3,
              ),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildDocumentField(
              context,
              title: "Estatutos e Ato Constitutivo da ONG",
              fieldName: "statutes_constitutive_act",
            ),
            buildDocumentField(
              context,
              title: "Declaração de Idoneidade da ONG",
              fieldName: "declaration_good_standing",
            ),
            buildDocumentField(
              context,
              title: "Ata de Assembleia de Constituição",
              fieldName: "minutes_constitutive_assembly",
            ),
            buildDocumentField(
              context,
              title: "Escritura Pública de Constituição",
              fieldName: "public_deed",
            ),
            buildDocumentField(
              context,
              title: "Certificado de Registo da ONG (opcional)",
              fieldName: "registration_certificate",
              required: false,
            ),
            buildDocumentField(
              context,
              title: "Número de Identificação Fiscal (NIF)",
              fieldName: "nif",
            ),
            buildDocumentField(
              context,
              title: "Bilhete de Identidade do  Representante Legal",
              fieldName: "bi_representative",
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDocumentField(
    BuildContext context, {
    required String title,
    required String fieldName,
    bool required = true,
    List<String> allowedExtensions = const ['pdf'],
  }) {
    return Column(
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
                TextSpan(text: title),
                if (required)
                  TextSpan(
                    text: " *",
                    style: TextStyle(color: Colors.red, fontSize: 16),
                  ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: FormBuilderFilePicker(
            name: fieldName,
            decoration: InputDecoration(labelText: "Carregar arquivo"),
            maxFiles: 1,
            previewImages: true,
            allowedExtensions: allowedExtensions,
            typeSelectors: [
              TypeSelector(
                type: FileType.custom,
                selector: Row(
                  children: <Widget>[
                    Icon(Icons.add_circle),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text("Selecionar arquivo"),
                    ),
                  ],
                ),
              ),
            ],
            validator: required
                ? FormBuilderValidators.compose([
                    FormBuilderValidators.required(errorText: "Obrigatório"),
                  ])
                : null,
          ),
        ),
      ],
    );
  }
}
