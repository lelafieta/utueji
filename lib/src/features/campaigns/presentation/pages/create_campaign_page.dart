import 'package:dropdown_search/dropdown_search.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';
import 'package:form_builder_file_picker/form_builder_file_picker.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:group_button/group_button.dart';
import 'package:utueji/src/core/resources/images/app_images.dart';

import '../../../../config/themes/app_colors.dart';

class CreateCampaignPage extends StatefulWidget {
  const CreateCampaignPage({super.key});

  @override
  State<CreateCampaignPage> createState() => _CreateCampaignPageState();
}

class _CreateCampaignPageState extends State<CreateCampaignPage> {
  int activeStep = 0;
  int activeStep2 = 0;
  int reachedStep = 0;
  int upperBound = 5;
  double progress = 0.2;
  final _formKey = GlobalKey<FormState>();
  String? _selectedOption;

  List<String> titles = [
    "Médico",
    "Educação",
    "Olfã",
    "Animal",
    "Idosos",
    "Desporto",
    "Desastre",
    "Outros",
  ];
  Set<int> reachedSteps = <int>{0, 2, 4, 5};
  final dashImages = [
    'assets/1.png',
    'assets/2.png',
    'assets/3.png',
    'assets/4.png',
    'assets/5.png',
  ];

  void increaseProgress() {
    if (progress < 1) {
      setState(() => progress += 0.2);
    } else {
      setState(() => progress = 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Criar Nova Campanha'),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: () {},
          child: Text("Guardar & Continuar"),
        ),
      ),
      body: Column(
        children: [
          Container(
            child: Column(
              children: [
                ListTile(
                  leading: Container(
                    width: 45,
                    height: 45,
                    child: Image.asset(
                      fit: BoxFit.cover,
                      AppImages.charity,
                    ),
                  ),
                  title: Text(
                    "Passo 1/3",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  subtitle: Text(
                    "Detalhes do Beneficiário",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                child: EasyStepper(
                  activeStep: activeStep,
                  activeStepTextColor: Colors.black87,
                  finishedStepTextColor: Colors.black87,
                  internalPadding: 0,
                  showLoadingAnimation: false,
                  stepRadius: 8,
                  showStepBorder: true,
                  steps: [
                    EasyStep(
                      customStep: CircleAvatar(
                        radius: 8,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 7,
                          backgroundColor:
                              activeStep >= 0 ? Colors.orange : Colors.white,
                        ),
                      ),
                      title: 'Waiting',
                    ),
                    EasyStep(
                      customStep: CircleAvatar(
                        radius: 8,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 7,
                          backgroundColor:
                              activeStep >= 1 ? Colors.orange : Colors.white,
                        ),
                      ),
                      title: 'Order Received',
                      topTitle: true,
                    ),
                    EasyStep(
                      customStep: CircleAvatar(
                        radius: 8,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 7,
                          backgroundColor:
                              activeStep >= 3 ? Colors.orange : Colors.white,
                        ),
                      ),
                      title: 'On Way',
                      topTitle: true,
                    ),
                  ],
                  onStepReached: (index) => setState(() => activeStep = index),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Column stepThree(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context)
                  .style
                  .copyWith(color: Colors.black),
              children: [
                TextSpan(
                  text: "Documento de identidade",
                ),
                TextSpan(
                    text: " *",
                    style: TextStyle(color: Colors.red, fontSize: 16))
              ],
            ),
          ),
        ),
        Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 20),
          child: Text("Carregue um documento que identifique o beneficiário"),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: FormBuilderFilePicker(
            name: "images",
            decoration: InputDecoration(labelText: "Imagem"),
            maxFiles: null,
            previewImages: true,
            onChanged: (val) => print(val),
            typeSelectors: [
              TypeSelector(
                type: FileType.any,
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
            onFileLoading: (val) {
              print(val);
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context)
                  .style
                  .copyWith(color: Colors.black),
              children: [
                TextSpan(
                  text: "Documentos",
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 20),
          child: RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context).style,
              children: [
                TextSpan(
                  text:
                      "Carregue os documentos de suporte para se conectar diretamente com os doadores",
                ),
                TextSpan(
                    text: " *",
                    style: TextStyle(color: Colors.red, fontSize: 16))
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: FormBuilderFilePicker(
            name: "images",
            decoration: InputDecoration(labelText: "Imagem"),
            maxFiles: null,
            previewImages: true,
            onChanged: (val) => print(val),
            typeSelectors: [
              TypeSelector(
                type: FileType.any,
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
            onFileLoading: (val) {
              print(val);
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context)
                  .style
                  .copyWith(color: Colors.black),
              children: [
                TextSpan(
                  text: "Mídia",
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 20),
          child: RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context).style,
              children: [
                TextSpan(
                  text: "Carregue vídeos de até 100mb e formato mp4",
                ),
                TextSpan(
                    text: " *",
                    style: TextStyle(color: Colors.red, fontSize: 16))
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: FormBuilderFilePicker(
            name: "images",
            decoration: InputDecoration(labelText: "Imagem"),
            maxFiles: null,
            previewImages: true,
            onChanged: (val) => print(val),
            typeSelectors: [
              TypeSelector(
                type: FileType.any,
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
            onFileLoading: (val) {
              print(val);
            },
          ),
        ),
      ],
    );
  }

  Column stepTwo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context)
                  .style
                  .copyWith(color: Colors.black),
              children: [
                TextSpan(
                  text: "Doença / condição médica",
                ),
                TextSpan(
                    text: "*",
                    style: TextStyle(color: Colors.red, fontSize: 16))
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: FormBuilderDropdown(
            name: 'member',
            isDense: false,
            decoration: InputDecoration(
              label: Text("Selecionar"),
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            ),
            validator: FormBuilderValidators.required(
              errorText: 'Selecione SITE',
            ),
            items: [
              'Dor de cabeça',
              'Gripe',
              'Resfriado',
              'Asma',
              'Diabetes',
              'Hipertensão',
              'Enxaqueca',
              'Artrite',
              'Bronquite',
              'Sinusite',
              'Alergia',
              'Infecção urinária',
              'Anemia',
              'Gastrite',
              'Úlcera',
              'Covid-19',
              'Depressão',
              'Ansiedade',
              'Insônia',
              'Dermatite',
              'Hipotireoidismo',
              'Hipertireoidismo',
              'Obesidade',
              'Osteoporose',
              'Otite',
              'Pneumonia',
              'Problemas cardíacos',
            ]
                .map(
                  (member) =>
                      DropdownMenuItem(value: member, child: Text("$member")),
                )
                .toList(),
          ),
        ),
        const SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context)
                  .style
                  .copyWith(color: Colors.black),
              children: [
                TextSpan(
                  text: "Doença / condição médica",
                ),
                TextSpan(
                    text: "*",
                    style: TextStyle(color: Colors.red, fontSize: 16))
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: FormBuilderDropdown(
                  name: 'member',
                  isDense: false,
                  decoration: InputDecoration(
                    label: Text("AOA"),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  ),
                  validator: FormBuilderValidators.required(
                    errorText: 'Selecione SITE',
                  ),
                  items: ['USD', 'EUR', 'GBP', 'JPY', 'AUD']
                      .map(
                        (member) => DropdownMenuItem(
                            value: member, child: Text("$member")),
                      )
                      .toList(),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    FormBuilderTextField(
                      name: "name",
                      decoration: InputDecoration(
                        label: Text("Entra com montante"),
                      ),
                    ),
                    Text("Deveria ser mínimo 1.000.000Kz")
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context)
                  .style
                  .copyWith(color: Colors.black),
              children: [
                TextSpan(
                  text: "Estado de hospitalização",
                ),
                TextSpan(
                    text: "*",
                    style: TextStyle(color: Colors.red, fontSize: 16))
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: FormBuilderDropdown(
            name: 'member',
            isDense: false,
            decoration: InputDecoration(
              label: Text("Selecione"),
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            ),
            validator: FormBuilderValidators.required(
              errorText: 'Selecione SITE',
            ),
            items: [
              'Internado',
              'Recebeu alta',
              'Em observação',
              'Não hospitalizado',
            ]
                .map(
                  (member) =>
                      DropdownMenuItem(value: member, child: Text("$member")),
                )
                .toList(),
          ),
        ),
        const SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context)
                  .style
                  .copyWith(color: Colors.black),
              children: [
                TextSpan(
                  text: "Hospitais",
                ),
                TextSpan(
                    text: "*",
                    style: TextStyle(color: Colors.red, fontSize: 16))
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: FormBuilderTextField(
            name: "name",
            decoration: InputDecoration(
              label: Text("Selecione hospital"),
              suffixIcon: Icon(Icons.search),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context)
                  .style
                  .copyWith(color: Colors.black),
              children: [
                TextSpan(
                  text: "Data do fim",
                ),
                TextSpan(
                    text: "*",
                    style: TextStyle(color: Colors.red, fontSize: 16))
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: FormBuilderDateTimePicker(
            name: "nascimento",
            decoration: InputDecoration(
              hintText: "DD-MM-YYYY",
              suffixIcon: Icon(Icons.calendar_month_rounded),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context)
                  .style
                  .copyWith(color: Colors.black),
              children: [
                TextSpan(
                  text: "Adicione um descrição",
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: FormBuilderTextField(
            name: "name",
            decoration: InputDecoration(
              // label: Text("Descrição"),
              hintMaxLines: 1,
            ),
            maxLines: 3,
          ),
        ),
        const SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Colaboração"),
              Icon(
                Icons.info,
                color: Colors.black26,
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Row(
            children: [
              Icon(
                Icons.add,
                color: AppColors.primaryColor,
              ),
              const SizedBox(width: 5),
              Text(
                "Adicionar Caridade",
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }

  Column stepOne(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 4,
            ),
            itemCount: titles.length,
            itemBuilder: (context, index) {
              bool isSelected = _selectedOption == titles[index];

              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedOption = titles[index];
                  });
                },
                child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primaryColor : Colors.white,
                    border: Border.all(
                      color: AppColors.primaryColor,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    titles[index],
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: isSelected ? Colors.white : Colors.black),
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context)
                  .style
                  .copyWith(color: Colors.black),
              children: [
                TextSpan(
                  text: "Para quem você arrecada fundos? ",
                ),
                TextSpan(
                    text: "*",
                    style: TextStyle(color: Colors.red, fontSize: 16))
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: FormBuilderDropdown(
            name: 'member',
            isDense: false,
            decoration: InputDecoration(
              label: Text("Pessoa"),
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            ),
            validator: FormBuilderValidators.required(
              errorText: 'Selecione SITE',
            ),
            items: [
              'Mãe',
              'Pai',
              'Irmão',
              'Filho',
              'Outros',
            ]
                .map(
                  (member) =>
                      DropdownMenuItem(value: member, child: Text("$member")),
                )
                .toList(),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context)
                  .style
                  .copyWith(color: Colors.black),
              children: [
                TextSpan(
                  text: "Entre com os respectivos dados a pessoa ",
                ),
                TextSpan(
                    text: "*",
                    style: TextStyle(color: Colors.red, fontSize: 16))
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: FormBuilderTextField(
            name: "name",
            decoration: InputDecoration(
              label: Text("Nome"),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: FormBuilderDateTimePicker(
            name: "nascimento",
            decoration: InputDecoration(
              hintText: "DD-MM-YYYY",
              suffixIcon: Icon(Icons.calendar_month_rounded),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: FormBuilderTextField(
            name: "name",
            decoration: InputDecoration(
              label: Text("Localização"),
              suffixIcon: Icon(Icons.search),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: FormBuilderTextField(
            name: "name",
            decoration: InputDecoration(
              label: Text("Telefone"),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context)
                  .style
                  .copyWith(color: Colors.black),
              children: [
                TextSpan(
                  text: "Carregar imagem de capa",
                ),
                TextSpan(
                  text: " (Opcional)",
                  style: TextStyle(
                    color: Colors.black45,
                    fontSize: 14,
                  ),
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: FormBuilderFilePicker(
            name: "images",
            decoration: InputDecoration(labelText: "Imagem"),
            maxFiles: null,
            previewImages: true,
            onChanged: (val) => print(val),
            typeSelectors: [
              TypeSelector(
                type: FileType.any,
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
            onFileLoading: (val) {
              print(val);
            },
          ),
        ),
      ],
    );
  }
}
