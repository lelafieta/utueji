import 'package:awesome_place_search/awesome_place_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_file_picker/form_builder_file_picker.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:utueji/src/app/app_entity.dart';
import 'package:utueji/src/config/routes/app_routes.dart';
import 'package:utueji/src/features/campaigns/domain/entities/campaign_midia_entity.dart';

import '../../../../config/themes/app_colors.dart';
import '../../../../core/firebase/local_notification_services.dart';
import '../../../../core/resources/images/app_images.dart';
import '../../../categories/data/models/category_model.dart';
import '../../../categories/domain/entities/category_entity.dart';
import '../../domain/entities/campaign_document_entity.dart';
import '../../domain/entities/campaign_entity.dart';
import '../cubit/campaign_action_cubit/campaign_action_cubit.dart';

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
  List<PlatformFile> selectedMidias = [];
  List<PlatformFile> selectedDocments = [];
  List<PlatformFile> selectedCoverImage = [];
  final _formStepOneKey = GlobalKey<FormBuilderState>();
  final _formStepTwoKey = GlobalKey<FormBuilderState>();
  final _formStepThreeKey = GlobalKey<FormBuilderState>();

  TextEditingController controllerLocation = TextEditingController();
  CategoryEntity? _selectedOptionCategory;
  String? _selectedOptionType;
  bool? _selectedOptionUrgent = false;
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController currency = TextEditingController();
  TextEditingController fundRaisingGoal = TextEditingController();
  TextEditingController startDate = TextEditingController();
  TextEditingController endDate = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController birth = TextEditingController();
  TextEditingController beneficiaryName = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  Map<String, dynamic> formDataStepOne = {};
  Map<String, dynamic> formDataStepTwo = {};
  Map<String, dynamic> formDataStepThree = {};
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

  void _submitStepOneForm() {
    if (_formStepOneKey.currentState?.saveAndValidate() ?? false) {
      formDataStepOne = _formStepOneKey.currentState!.value;

      print(_formStepOneKey.currentState);

      String titulo = formDataStepOne["title"];
      String descricao = formDataStepOne["description"];
      String moeda = formDataStepOne["currency"];
      String objetivo = formDataStepOne["fundraising_goal"];
      String dataInicio = formDataStepOne["start_date"].toString();
      String dataFim = formDataStepOne["end_date"].toString();
      String localizacao = formDataStepOne["location"];

      print("Categoria: ${_selectedOptionCategory!.id}");
      print("Título: $titulo");
      print("Descrição: $descricao");
      print("Moeda: $moeda");
      print("Objetivo: $objetivo");
      print("Data de Início: $dataInicio");
      print("Data de Fim: $dataFim");
      print("Localização: $localizacao");

      // Agora você pode enviar esses dados para o backend ou salvar no banco de dados
    } else {
      print("Formulário inválido!");
    }
  }

  void _submitStepTwoForm() {
    if (_formStepTwoKey.currentState?.saveAndValidate() ?? false) {
      formDataStepTwo = _formStepTwoKey.currentState!.value;

      // Recuperando os valores específicos
      String beneficiaryName = formDataStepOne['beneficiary_name'] ?? '';
      String phoneNumber = formDataStepOne['phone_number'] ?? '';
      String birthDate = formDataStepOne['birth'] != null
          ? DateFormat("dd-MM-yyyy").format(formDataStepOne['birth'])
          : '';
      String? beneficiaryType = _selectedOptionType;
      bool? isUrgent = _selectedOptionUrgent;

      print("Nome do Beneficiário: $beneficiaryName");
      print("Data de Nascimento: $birthDate");
      print("Tipo de Beneficiário: $beneficiaryType");
      print("Urgente: $isUrgent");
      print("Urgente: $phoneNumber");

      // Aqui você pode salvar os dados, enviar para API, etc.
    } else {
      print("Formulário inválido");
    }
  }

  void _submitStepThreeForm() {
    if (_formStepThreeKey.currentState?.saveAndValidate() ?? false) {
      formDataStepThree = _formStepThreeKey.currentState!.value;

      // Recuperando os arquivos
      List<dynamic>? midias = formDataStepThree['midias'];
      List<dynamic>? documents = formDataStepThree['documents'];
      List<CampaignDocumentEntity> docs = [];
      List<CampaignMidiaEntity> mids = [];

      // Processando as imagens
      List<Map<String, dynamic>> uploadedImages = [];
      if (midias != null) {
        for (var file in midias) {
          if (file is PlatformFile) {
            final midia = CampaignMidiaEntity(
                midiaType: "midia", userId: AppEntity.uid, midiaUrl: file.path);
            mids.add(midia);
            // uploadedImages.add({
            //   'name': file.name,
            //   'bytes': file.bytes,
            //   'size': file.size,
            // });
          }
        }
      }

      // Processando os documentos
      List<Map<String, dynamic>> uploadedDocuments = [];
      if (documents != null) {
        for (var file in documents) {
          if (file is PlatformFile) {
            final doc = CampaignDocumentEntity(
                isApproved: false,
                userId: AppEntity.uid,
                documentPath: file.path);

            docs.add(doc);
            // uploadedDocuments.add({
            //   'name': file.name,
            //   'bytes': file.bytes,
            //   'size': file.size,
            // });
          }
        }
      }

      // Exibir os dados no console
      print("Imagens carregadas: $uploadedImages");
      print("Documentos carregados: $uploadedDocuments");
      print("CATEGORIA ID ${_selectedOptionCategory!.id}");

      // String categoriaSelecionada = _selectedOptionCategory?.name ?? "";
      String titulo = formDataStepOne["title"];
      String descricao = formDataStepOne["description"];
      String moeda = formDataStepOne["currency"];
      String objetivo = formDataStepOne["fundraising_goal"];
      String dataInicio = formDataStepOne["start_date"].toString();
      String dataFim = formDataStepOne["end_date"].toString();
      String localizacao = formDataStepOne["location"];

      // Recuperando os valores específicos
      String beneficiaryName = formDataStepTwo['beneficiary_name'] ?? '';
      String phoneNumber = formDataStepTwo['phone_number'] ?? '';
      String? beneficiaryType = _selectedOptionType;
      bool? isUrgent = _selectedOptionUrgent;
      String? birthDateString = (formDataStepTwo['birth'] == null)
          ? null
          : formDataStepTwo['birth'].toString();
      print("BIRTH");
      print(birthDateString);

      final campaign = CampaignEntity(
          title: titulo,
          description: descricao,
          fundraisingGoal: double.parse(objetivo),
          fundsRaised: 0.0,
          currency: moeda,
          imageCoverUrl:
              (selectedCoverImage.isEmpty) ? null : selectedCoverImage[0].path,
          categoryId: _selectedOptionCategory!.id,
          ongId: "32ca60fa-9c02-4d58-a5b8-8e8968141965",
          location: localizacao,
          userId: AppEntity.uid,
          campaignType: beneficiaryType,
          phoneNumber: phoneNumber,
          priority: 0,
          isUrgent: isUrgent,
          // isUrgent: true,
          isActivate: true,
          numberOfContributions: 0,
          beneficiaryName: beneficiaryName,
          birth: birthDateString != null
              ? DateFormat("dd-MM-yyyy").parse(birthDateString)
              : null,
          endDate: dataFim != null ? DateTime.parse(dataFim) : null,
          startDate: dataInicio != null ? DateTime.parse(dataInicio) : null,
          documents: docs,
          midias: mids);
      context.read<CampaignActionCubit>().create(campaign);
    } else {
      print("Formulário inválido");
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
                  if (activeStep == 0) {
                    if (_formStepOneKey.currentState!.validate()) {
                      _submitStepOneForm();
                      setState(() {
                        activeStep++;
                      });
                    } else {
                      if (_selectedOptionCategory == null) {
                        final category = CategoryEntity(
                            id: "empty",
                            name: "Empty",
                            createdAt: DateTime.now());
                        setState(() {
                          _selectedOptionCategory = category;
                        });
                      }
                      print(_formStepOneKey.currentState!.value);
                    }
                  } else if (activeStep == 1) {
                    if (_formStepTwoKey.currentState!.validate()) {
                      _submitStepTwoForm();
                      setState(() {
                        activeStep++;
                      });
                    } else {
                      print("else $_selectedOptionType");
                      if (_selectedOptionType == null) {
                        setState(() {
                          _selectedOptionType = "empty";
                        });
                      }
                    }
                  } else {
                    // setState(() {
                    //   activeStep++;
                    // });
                    _submitStepThreeForm();
                  }
                },
                child:
                    Text(activeStep < 2 ? "Guardar & Continuar" : "Finalizar"),
              ),
            ),
          ],
        ),
      ),
      body: BlocConsumer<CampaignActionCubit, CampaignActionState>(
        listener: (context, state) {
          EasyLoading.dismiss();
          if (state is CampaignActionLoading) {
            EasyLoading.show(
                status: "Criando uma campanha",
                maskType: EasyLoadingMaskType.black);
          } else if (state is CampaignActionError) {
            EasyLoading.showError(state.message);
          } else if (state is CampaignActionSuccess) {
            LocalNotificationServices.sendNotification(
              title: "Campanha Criada",
              body: "Sua campanha foi criada com sucesso",
            );
            Get.toNamed(AppRoutes.createCampaignSuccessRoute);
          } else {
            // Get.toNamed(AppRoutes.createCampaignSuccessRoute);
          }
        },
        builder: (context, state) {
          return Column(
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
          );
        },
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
                    text: "Mídia",
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
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 20),
            child: RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: [
                  TextSpan(
                    text:
                        "Carregue imagens ou vídeos de até 10mb e formato mp4, jpg, jpeg, png",
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: FormBuilderFilePicker(
              name: "midias",
              initialValue: selectedMidias,
              decoration: InputDecoration(labelText: "Mídia"),
              previewImages: true,
              maxFiles: 8,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              allowedExtensions: ['jpg', 'jpeg', 'png', 'mp4'],
              validator: (value) {
                String? result = null;
                selectedMidias.forEach((file) {
                  int fileSizeInMB = file.size ~/ (1024 * 1024);
                  print("SIZE: ${file.size}");
                  if (fileSizeInMB >= 20) {
                    result = "Cada mídia não pode exceder os 20MB";
                  }
                });
                return result;
              },
              onChanged: (val) {
                setState(() {
                  selectedMidias = List<PlatformFile>.from(val ?? []);
                });
              },
              typeSelectors: [
                TypeSelector(
                  type: FileType.custom,
                  selector: Row(
                    children: <Widget>[
                      Icon(Icons.add_circle),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text("Adicionar Imagens/Vídeos"),
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
                    text: "Documentos relacionado a causa",
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
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 20),
            child: Text(
                "Carregue os documentos de suporte para se conectar diretamente com os doadores até 5MB"),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: FormBuilderFilePicker(
              name: "documents",
              initialValue: selectedDocments,
              decoration: InputDecoration(labelText: "Documentos"),
              maxFiles: 4,
              allowedExtensions: ['pdf', 'doc', 'docx'],
              autovalidateMode: AutovalidateMode.onUserInteraction,
              previewImages: true,
              validator: (value) {
                String? result = null;
                selectedMidias.forEach((file) {
                  int fileSizeInMB = file.size ~/ (1024 * 1024);
                  print("SIZE: ${file.size}");
                  if (fileSizeInMB >= 20) {
                    result = "Cada mídia não pode exceder os 20MB";
                  }
                });
                return result;
              },
              onChanged: (val) {
                setState(() {
                  selectedDocments = List<PlatformFile>.from(val ?? []);
                });
              },
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
                        color: (_selectedOptionType == "empty")
                            ? Colors.red
                            : AppColors.primaryColor,
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
              controller: beneficiaryName,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: FormBuilderValidators.required(
                errorText: 'Nome do beneficiário',
              ),
              decoration: InputDecoration(
                label: Text("Nome do Beneficiário"),
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
                    text: "Contacto do beneficiário ",
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
              name: "phone_number",
              controller: phoneNumber,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: FormBuilderValidators.required(
                errorText: 'Número para entrar em contacto',
              ),
              decoration: InputDecoration(
                label: Text("Contacto"),
              ),
            ),
          ),
          (_selectedOptionType == "Um Individuo")
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 4),
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
                                style:
                                    TextStyle(color: Colors.red, fontSize: 16))
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: FormBuilderDateTimePicker(
                        name: "birth",
                        inputType: InputType.date,
                        controller: birth,
                        format: DateFormat("dd-MM-yyyy"),
                        initialValue: birth.text.isNotEmpty
                            ? DateFormat("dd-MM-yyyy").parse(birth.text)
                            : null, // Define a data inicial baseada no texto
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        onChanged: (value) {
                          if (value != null) {
                            birth.text = DateFormat("dd-MM-yyyy").format(value);
                          }
                        },
                        validator: (_selectedOptionType == "Um Individuo")
                            ? FormBuilderValidators.required(
                                errorText: 'Aniversário',
                              )
                            : null,
                        decoration: InputDecoration(
                          hintText: "DD-MM-YYYY",
                          suffixIcon: Icon(Icons.calendar_month_rounded),
                        ),
                      ),
                    ),
                  ],
                )
              : SizedBox.shrink(),
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
                // Lista de opções
                final List<String> options = ["NÃO", "SIM"];
                final bool isSelected =
                    (options[index] == "SIM") == _selectedOptionUrgent;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedOptionUrgent = options[index] == "SIM";
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
                      options[index],
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: isSelected ? Colors.white : Colors.black,
                          ),
                    ),
                  ),
                );
              },
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       RichText(
          //         text: TextSpan(
          //           style: DefaultTextStyle.of(context)
          //               .style
          //               .copyWith(color: Colors.black),
          //           children: [
          //             TextSpan(
          //               text: "Colaboração",
          //             ),
          //           ],
          //         ),
          //       ),
          //       Icon(Icons.info_outline_rounded)
          //     ],
          //   ),
          // ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          //   child: TextButton(
          //     onPressed: () {
          //       _bottomSheet();
          //     },
          //     child: Row(
          //       children: [
          //         Icon(Icons.add),
          //         const SizedBox(width: 10),
          //         Text("Adiciona Caridade"),
          //       ],
          //     ),
          //   ),
          // ),
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
                      categories[index].name!,
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
              controller: title,
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
              controller: description,
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
              onChanged: (val) {
                setState(() {
                  selectedCoverImage = List<PlatformFile>.from(val ?? []);
                });
              },
              decoration: InputDecoration(labelText: "Imagem"),
              maxFiles: 1,
              initialValue: selectedCoverImage,
              allowedExtensions: [
                'jpeg',
                "jpg",
              ],
              previewImages: true,
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
                    initialValue: currency.text,
                    onChanged: (value) {
                      currency.text = value!;
                    },
                    validator: FormBuilderValidators.required(
                      errorText: 'Selecione moeda',
                    ),
                    decoration: InputDecoration(
                      label: Text("Moeda"),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    ),
                    items: ['AOA', 'EUR', 'USD']
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
                        controller: fundRaisingGoal,
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
              controller: startDate,
              format: DateFormat("dd-MM-yyyy"),
              initialValue: startDate.text.isNotEmpty
                  ? DateFormat("dd-MM-yyyy").parse(startDate.text)
                  : DateTime.now(), // Define a data inicial baseada no texto
              autovalidateMode: AutovalidateMode.onUserInteraction,
              onChanged: (value) {
                if (value != null) {
                  startDate.text = DateFormat("dd-MM-yyyy").format(value);
                }
              },
              validator: FormBuilderValidators.required(
                errorText: 'Data do início',
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
              controller: endDate,
              format: DateFormat("dd-MM-yyyy"),
              initialValue: endDate.text.isNotEmpty
                  ? DateFormat("dd-MM-yyyy").parse(endDate.text)
                  : DateTime.now(), // Define a data inicial baseada no texto
              autovalidateMode: AutovalidateMode.onUserInteraction,
              onChanged: (value) {
                if (value != null) {
                  endDate.text = DateFormat("dd-MM-yyyy").format(value);
                }
              },
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

  void _bottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text("Esc"),
                SizedBox(
                  height: 40,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color: AppColors.blackColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Center(
                            child: Text(
                              "Utilizador",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color: AppColors.blackColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Center(
                            child: Text(
                              "Utilizador",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
