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
  String? _selectedOptionType;

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
  List<String> types = [
    "Um Individuo",
    "Uma Família",
    "Instituição ONG",
    "Comunitária(Coletiva)",
    "Projecto Específico",
    "Outro"
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

  Widget getStepContent(int step) {
    switch (step) {
      case 0:
        return stepOne(context);
      case 1:
        return stepTwo(context);
      case 2:
        return stepThree(context);
      default:
        return stepOne(context);
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (activeStep > 0)
              IconButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll(AppColors.primaryColor),
                ),
                onPressed: () {
                  setState(() {
                    activeStep--;
                  });
                },
                icon: Icon(Icons.arrow_back),
              ),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  if (activeStep < 2) {
                    setState(() {
                      activeStep++;
                    });
                  } else {
                    // Handle form submission
                  }
                },
                child:
                    Text(activeStep < 2 ? "Guardar & Continuar" : "Finalizar"),
              ),
            ),
          ],
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
                    "Passo ${activeStep + 1}/3",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  subtitle: Text(
                    activeStep == 0
                        ? "Informações da Campanha"
                        : activeStep == 1
                            ? "Beneficiário e Organização"
                            : "Mídias e Documentos",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              child: getStepContent(activeStep),
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
                  text: "Documentos relacionado a causa",
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
          child: Text(
              "Carregue os documentos de suporte para se conectar diretamente com os doadores"),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: FormBuilderFilePicker(
            name: "documentos",
            decoration: InputDecoration(labelText: "Documentos"),
            maxFiles: 4,
            allowedExtensions: ['pdf', 'doc', 'docx'],
            previewImages: true,
            onChanged: (val) => print(val),
            typeSelectors: [
              TypeSelector(
                type: FileType.custom,
                selector: Row(
                  children: <Widget>[
                    Icon(Icons.add_circle),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text("Adicionar documentos"),
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
                  text:
                      "Carregue imagens ou vídeos de até 100mb e formato mp4, jpg, jpeg, png",
                ),
                TextSpan(
                    text: " *",
                    style: TextStyle(color: Colors.red, fontSize: 16))
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: FormBuilderFilePicker(
            name: "images",
            decoration: InputDecoration(labelText: "Mídia"),
            previewImages: true,
            maxFiles: 8,
            allowedExtensions: ['pdf', 'doc', 'docx'],
            onChanged: (val) => print(val),
            typeSelectors: [
              TypeSelector(
                type: FileType.any,
                selector: Row(
                  children: <Widget>[
                    Icon(Icons.add_circle),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text("Adicionar Imagens/Videos"),
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
                  text: "Quem será beneficiado? ",
                ),
                TextSpan(
                    text: "*",
                    style: TextStyle(color: Colors.red, fontSize: 16))
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 4,
            ),
            itemCount: types.length,
            itemBuilder: (context, index) {
              bool isSelected = _selectedOptionType == types[index];

              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedOptionType = types[index];
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
                    types[index],
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
                  text: "Nome do beneficiário ",
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
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        //   child: FormBuilderDropdown(
        //     name: 'member',
        //     isDense: false,
        //     decoration: InputDecoration(
        //       label: Text("Selecione"),
        //       contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        //     ),
        //     validator: FormBuilderValidators.required(
        //       errorText: 'Selecione SITE',
        //     ),
        //     items: [
        //       'Internado',
        //       'Recebeu alta',
        //       'Em observação',
        //       'Não hospitalizado',
        //     ]
        //         .map(
        //           (member) =>
        //               DropdownMenuItem(value: member, child: Text("$member")),
        //         )
        //         .toList(),
        //   ),
        // ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context)
                  .style
                  .copyWith(color: Colors.black),
              children: [
                TextSpan(
                  text: "Data de nascimento ",
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
                  text: "Tem urgência?",
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
          child: GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 4,
            ),
            itemCount: 2,
            itemBuilder: (context, index) {
              bool isSelected = _selectedOptionType == types[index];

              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedOptionType = types[index];
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
                    ["SIM", "NÃO"][index],
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: isSelected ? Colors.white : Colors.black),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Column stepOne(BuildContext context) {
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
                  text: "Objetivo de arrecadar fundos ",
                ),
                TextSpan(
                    text: "*",
                    style: TextStyle(color: Colors.red, fontSize: 16))
              ],
            ),
          ),
        ),

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
                  text: "Informe o titulo da campanha ",
                ),
                TextSpan(
                    text: "*",
                    style: TextStyle(color: Colors.red, fontSize: 16))
              ],
            ),
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        //   child: FormBuilderDropdown(
        //     name: 'member',
        //     isDense: false,
        //     decoration: InputDecoration(
        //       label: Text("Pessoa"),
        //       contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        //     ),
        //     validator: FormBuilderValidators.required(
        //       errorText: 'Selecione SITE',
        //     ),
        //     items: [
        //       'Mãe',
        //       'Pai',
        //       'Irmão',
        //       'Filho',
        //       'Outros',
        //     ]
        //         .map(
        //           (member) =>
        //               DropdownMenuItem(value: member, child: Text("$member")),
        //         )
        //         .toList(),
        //   ),
        // ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: FormBuilderTextField(
            name: "title",
            decoration: InputDecoration(
              label: Text("Título"),
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context)
                  .style
                  .copyWith(color: Colors.black),
              children: [
                TextSpan(
                  text: "Meta de Arrecadação",
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

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context)
                  .style
                  .copyWith(color: Colors.black),
              children: [
                TextSpan(
                  text: "Data do início",
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
                  text: "Localização ",
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
              label: Text("Localização"),
              suffixIcon: Icon(Icons.search),
            ),
          ),
        ),
      ],
    );
  }
}
