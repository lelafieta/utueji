import 'package:awesome_place_search/awesome_place_search.dart';
import 'package:flutter/material.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_file_picker/form_builder_file_picker.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';

import '../../../../config/themes/app_colors.dart';
import '../../../../core/resources/images/app_images.dart';

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
  final googleApiKey = dotenv.env["GOOGLE_API_KEY"];
  PredictionModel? prediction;
  final _formKey = GlobalKey<FormBuilderState>();
  final _formStepOneKey = GlobalKey<FormBuilderState>();
  final _formStepTwoKey = GlobalKey<FormBuilderState>();
  final _formStepThreeKey = GlobalKey<FormBuilderState>();

  TextEditingController controllerLocation = TextEditingController();
  Category? _selectedOptionCategory;
  String? _selectedOptionType;

  List<Category> categories = [
    Category(
      id: "0279de80-27c5-4ddf-81ca-f4b5f12ec0dd",
      name: "Animal",
      description: null,
      createdAt: DateTime.parse("2025-02-17T18:59:13.474034Z"),
    ),
    Category(
      id: "278d5de0-7b6d-4aab-9453-b587c7911aef",
      name: "Desporto",
      description: null,
      createdAt: DateTime.parse("2025-02-17T18:59:13.474034Z"),
    ),
    Category(
      id: "a7408d26-8e08-49b2-b404-4855a00020b8",
      name: "Idosos",
      description: null,
      createdAt: DateTime.parse("2025-02-17T18:59:13.474034Z"),
    ),
    Category(
      id: "e3198b7-6be3-43b4-a8fe-ec0ac9c0fcc",
      name: "Médico",
      description: null,
      createdAt: DateTime.parse("2025-02-17T18:59:13.474034Z"),
    ),
    Category(
      id: "e949f3bd-5a94-44e0-bfd6-4728f0e9ea91",
      name: "Educação",
      description: null,
      createdAt: DateTime.parse("2025-02-17T18:59:13.474034Z"),
    ),
    Category(
      id: "ebe15c90-13d7-4ec9-8fa5-d5900cc6dc4c",
      name: "Olfá",
      description: null,
      createdAt: DateTime.parse("2025-02-17T18:59:13.474034Z"),
    ),
    Category(
      id: "f2b24c2a-9771-4162-aa5d-8fa8a05d3cd2",
      name: "Desastre",
      description: null,
      createdAt: DateTime.parse("2025-02-17T18:59:13.474034Z"),
    ),
    Category(
      id: "d822573c-14e5-4eca-99b4-52a35e5889b3",
      name: "Outros",
      description: null,
      createdAt: DateTime.parse("2025-02-17T18:59:13.474034Z"),
    ),
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

  void increaseProgress() {
    if (progress < 1) {
      setState(() => progress += 0.2);
    } else {
      setState(() => progress = 0);
    }
  }

  void _handleBack() {
    if (activeStep > 0) {
      setState(() {
        activeStep--;
      });
    } else {
      Navigator.pop(context);
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
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: _handleBack,
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  print("STEP $activeStep");
                  if (activeStep < 2) {
                    if (activeStep == 0) {
                      if (_formStepOneKey.currentState!.validate()) {
                        print(_formStepOneKey.currentState!.value);
                        setState(() {
                          activeStep++;
                        });
                      } else {
                        if (_selectedOptionCategory == null) {
                          final category = Category(
                              id: "empty",
                              name: "Empty",
                              createdAt: DateTime.now());
                          setState(() {
                            _selectedOptionCategory = category;
                          });
                        }
                        print(_formStepOneKey.currentState!.value);
                      }
                    }
                  } else {
                    // Handle form submission
                    if (_formKey.currentState!.validate()) {
                      print("Object Filds");
                      print(_formKey.currentState!.fields.keys);
                    }
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

  Widget stepThree(BuildContext context) {
    return FormBuilder(
      key: _formStepThreeKey,
      child: Column(
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
              name: "documents",
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
      ),
    );
  }

  Widget stepTwo(BuildContext context) {
    return FormBuilder(
      key: _formStepTwoKey,
      child: Column(
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
              name: "beneficiary_name",
              decoration: InputDecoration(
                label: Text("Nome do Beneficiário"),
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
              name: "birth",
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
      ),
    );
  }

  Widget stepOne(BuildContext context) {
    return FormBuilder(
      key: _formStepOneKey,
      child: Column(
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
              itemCount: categories.length,
              itemBuilder: (context, index) {
                bool isSelected = _selectedOptionCategory == categories[index];

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedOptionCategory = categories[index];
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.primaryColor : Colors.white,
                      border: Border.all(
                        color: ((_selectedOptionCategory != null) &&
                                _selectedOptionCategory!.id == "empty")
                            ? Colors.red
                            : AppColors.primaryColor,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      categories[index].name,
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: FormBuilderTextField(
              name: "title",
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: FormBuilderValidators.required(
                errorText: 'Título da campanha',
              ),
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
              name: "description",
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: FormBuilderValidators.required(
                errorText: 'Descrição da campanha',
              ),
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
              name: "image_cover_url",
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
                    name: 'currency',
                    isDense: false,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: FormBuilderValidators.required(
                      errorText: 'Selecione moeda',
                    ),
                    decoration: InputDecoration(
                      label: Text("AOA"),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 4),
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
                        name: "fundraising_goal",
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.number,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                          FormBuilderValidators.numeric(
                              errorText: 'Apenas números são permitidos'),
                          FormBuilderValidators.max(100000000,
                              errorText:
                                  'O valor deve ser no máximo 100.000.000'),
                        ]),
                        decoration: InputDecoration(
                          labelText: "Entra com montante",
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
              name: "start_date",
              inputType: InputType.date,
              format: DateFormat("dd-MM-yyyy"),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: FormBuilderValidators.required(
                errorText: 'Data de início',
              ),
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
              name: "end_date",
              inputType: InputType.date,
              format: DateFormat("dd-MM-yyyy"),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: FormBuilderValidators.required(
                errorText: 'Data do fim',
              ),
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
              name: "location",
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: FormBuilderValidators.required(
                errorText: 'Localização',
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
        ],
      ),
    );
  }
}

class Category {
  final String id;
  final String name;
  final String? description;
  final DateTime createdAt;

  Category({
    required this.id,
    required this.name,
    this.description,
    required this.createdAt,
  });

  Category copyWith({
    String? id,
    String? name,
    String? description,
    DateTime? createdAt,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
