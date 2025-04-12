import 'package:awesome_place_search/awesome_place_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_file_picker/form_builder_file_picker.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:utueji/src/config/routes/app_routes.dart';
import 'package:utueji/src/features/ongs/domain/entities/ong_entity.dart';
import 'package:utueji/src/features/ongs/presentation/cubit/ong_action_cubit/ong_action_cubit.dart';

import '../../../../core/firebase/local_notification_services.dart';
import '../../../../core/resources/images/app_images.dart';
import '../../domain/entities/ong_document_entity.dart';

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
  TextEditingController controllerPhone = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerWebsite = TextEditingController();
  TextEditingController controllerBio = TextEditingController();
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerAbout = TextEditingController();
  TextEditingController controllerMission = TextEditingController();
  TextEditingController controllerVision = TextEditingController();
  TextEditingController controllerStatutes = TextEditingController();
  TextEditingController controllerDeclaration = TextEditingController();
  TextEditingController controllerAssembly = TextEditingController();
  TextEditingController controllerPublicDeed = TextEditingController();
  TextEditingController controllerRegistration = TextEditingController();
  TextEditingController controllerNif = TextEditingController();
  TextEditingController controllerBi = TextEditingController();
  List<PlatformFile>? _selectedProfileFiles;
  List<PlatformFile>? _selectedCoverFiles;

  List<PlatformFile>? _selectedStatutesFiles;
  List<PlatformFile>? _selectedDeclarationFiles;
  List<PlatformFile>? _selectedAssemblyFiles;
  List<PlatformFile>? _selectedPublicDeedFiles;
  List<PlatformFile>? _selectedRegistrationFiles;
  List<PlatformFile>? _selectedNifFiles;
  List<PlatformFile>? _selectedBiFiles;

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
        final ongData = {
          // Informações gerais
          "name": controllerName.text.trim().isNotEmpty
              ? controllerName.text.trim()
              : null,
          "bio": controllerBio.text.trim().isNotEmpty
              ? controllerBio.text.trim()
              : null,
          "about": controllerAbout.text.trim().isNotEmpty
              ? controllerAbout.text.trim()
              : null,
          "mission": controllerMission.text.trim().isNotEmpty
              ? controllerMission.text.trim()
              : null,
          "vision": controllerVision.text.trim().isNotEmpty
              ? controllerVision.text.trim()
              : null,

          // Contato
          "phone_number": controllerPhone.text.trim().isNotEmpty
              ? controllerPhone.text.trim()
              : null,
          "email": controllerEmail.text.trim().isNotEmpty
              ? controllerEmail.text.trim()
              : null,
          "website": controllerWebsite.text.trim().isNotEmpty
              ? controllerWebsite.text.trim()
              : null,

          // Localização
          "location": controllerLocation.text.trim().isNotEmpty
              ? controllerLocation.text.trim()
              : null,
          // "latitude": selectedPlace?.latLng.latitude,
          // "longitude": selectedPlace?.latLng.longitude,

          // Imagens
          "profile_image": _selectedProfileFiles?.isNotEmpty == true
              ? _selectedProfileFiles?.first.path
              : null,
          "cover_image": _selectedCoverFiles?.isNotEmpty == true
              ? _selectedCoverFiles?.first.path
              : null,

          // Documentos obrigatórios
          "statutes": _selectedStatutesFiles?.isNotEmpty == true
              ? _selectedStatutesFiles?.first.path
              : null,
          "declaration": _selectedDeclarationFiles?.isNotEmpty == true
              ? _selectedDeclarationFiles?.first.path
              : null,
          "assembly": _selectedAssemblyFiles?.isNotEmpty == true
              ? _selectedAssemblyFiles?.first.path
              : null,
          "public_deed": _selectedPublicDeedFiles?.isNotEmpty == true
              ? _selectedPublicDeedFiles?.first.path
              : null,
          "registration": _selectedRegistrationFiles?.isNotEmpty == true
              ? _selectedRegistrationFiles?.first.path
              : null,
          "nif": _selectedNifFiles?.isNotEmpty == true
              ? _selectedNifFiles?.first.path
              : null,
          "bi": _selectedBiFiles?.isNotEmpty == true
              ? _selectedBiFiles?.first.path
              : null,
          "created_at": DateTime.now().toIso8601String(),
        };

        final ongEntity = OngEntity(
          name: ongData["name"],
          bio: ongData["bio"],
          about: ongData["about"],
          mission: ongData["mission"],
          vision: ongData["vision"],
          phoneNumber: ongData["phone_number"],
          email: ongData["email"],
          website: ongData["website"],
          profileImageUrl: ongData["profile_image"],
          coverImageUrl: ongData["cover_image"],
          createdAt: DateTime.tryParse(ongData["created_at"]!),
          ongDocument: OngDocumentEntity(
            statutesConstitutiveAct: ongData["statutes"],
            declarationGoodStanding: ongData["declaration"],
            minutesConstitutiveAssembly: ongData["assembly"],
            publicDeed: ongData["public_deed"],
            registrationCertificate: ongData["registration"],
            nif: ongData["nif"],
            biRepresentative: ongData["bi"],
            createdAt: DateTime.tryParse(ongData["created_at"]!),
            status: "pending", // ou outro status padrão
          ),
        );

        context.read<OngActionCubit>().createOng(ongEntity);
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
        print(value);
        final result = await value;
        controllerLocation.text = result.description!;
      },
    ).show();
    // showModalBottomSheet(
    //   context: context,
    //   builder: (context) {
    //     return Container(
    //       padding: EdgeInsets.all(16),
    //       decoration: BoxDecoration(
    //         color: Colors.white,
    //         borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    //       ),
    //     );
    //   },
    // );
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
        centerTitle: false,
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
                // onPressed: () {
                //   final ongData = {
                //     // Informações gerais
                //     "name": "Associação Esperança Viva5",
                //     "bio":
                //         "ONG voltada para o desenvolvimento comunitário e inclusão social.",
                //     "about":
                //         "Desde 2015, atuamos em comunidades carentes promovendo acesso à educação, saúde e cultura.",
                //     "mission":
                //         "Transformar vidas através do engajamento social.",
                //     "vision":
                //         "Ser referência em transformação social em Angola.",

                //     // Contato
                //     "phone_number": "+244931000000",
                //     "email": "contato@esperancaviva.org",
                //     "website": "https://www.esperancaviva.org",

                //     // Localização
                //     "location": "Luanda, Angola",

                //     // Imagens (simulando path de imagens salvas no cache ou assets)
                //     "profile_image":
                //         "/data/user/0/com.example.utueji/cache/file_picker/GRS WEB ATA.pdf",
                //     "cover_image":
                //         "/data/user/0/com.example.utueji/cache/file_picker/GRS WEB ATA.pdf",

                //     // Documentos obrigatórios (simulando paths de arquivos)
                //     "statutes":
                //         "/data/user/0/com.example.utueji/cache/file_picker/GRS WEB ATA.pdf",
                //     "declaration":
                //         "/data/user/0/com.example.utueji/cache/file_picker/GRS WEB ATA.pdf",
                //     "assembly":
                //         "/data/user/0/com.example.utueji/cache/file_picker/GRS WEB ATA.pdf",
                //     "public_deed":
                //         "/data/user/0/com.example.utueji/cache/file_picker/GRS WEB ATA.pdf",
                //     "registration":
                //         "/data/user/0/com.example.utueji/cache/file_picker/GRS WEB ATA.pdf",
                //     "nif":
                //         "/data/user/0/com.example.utueji/cache/file_picker/GRS WEB ATA.pdf",
                //     "bi":
                //         "/data/user/0/com.example.utueji/cache/file_picker/GRS WEB ATA.pdf",

                //     "created_at": DateTime.now().toIso8601String(),
                //   };
                //   final ongEntity = OngEntity(
                //     name: ongData["name"],
                //     bio: ongData["bio"],
                //     about: ongData["about"],
                //     mission: ongData["mission"],
                //     vision: ongData["vision"],
                //     phoneNumber: ongData["phone_number"],
                //     email: ongData["email"],
                //     website: ongData["website"],
                //     profileImageUrl: ongData["profile_image"],
                //     coverImageUrl: ongData["cover_image"],
                //     createdAt: DateTime.tryParse(ongData["created_at"]!),
                //     ongDocument: OngDocumentEntity(
                //       statutesConstitutiveAct: ongData["statutes"],
                //       declarationGoodStanding: ongData["declaration"],
                //       minutesConstitutiveAssembly: ongData["assembly"],
                //       publicDeed: ongData["public_deed"],
                //       registrationCertificate: ongData["registration"],
                //       nif: ongData["nif"],
                //       biRepresentative: ongData["bi"],
                //       createdAt: DateTime.tryParse(ongData["created_at"]!),
                //       status: "pending",
                //     ),
                //   );

                //   context.read<OngActionCubit>().createOng(ongEntity);
                // },
                child:
                    Text(activeStep < 3 ? "Guardar & Continuar" : "Finalizar"),
              ),
            ),
          ],
        ),
      ),
      body: BlocListener<OngActionCubit, OngActionState>(
        listener: (context, state) {
          print(state);
          EasyLoading.dismiss();
          if (state is OngActionLoading) {
            EasyLoading.show(
                status: "Loading", maskType: EasyLoadingMaskType.black);
          } else if (state is OngActionSuccess) {
            LocalNotificationServices.sendNotification(
              title: "ONG Registada",
              body: "Aguarde a aprovação para começar as campanhas.",
            );
            Get.toNamed(AppRoutes.successRegisterOng,
                arguments:
                    "A sua organização em pendente, aguarde a aprovação ou rejeição. Vamos analizar os seus documentos.");
            // EasyLoading.showInfo(
            //     );
          }
        },
        child: Column(
          children: [
            ListTile(
              leading: Image.asset(AppImages.ong, width: 45, height: 45),
              title: Text("Passo ${activeStep + 1}/4"),
              subtitle: Text(
                [
                  "Informações básicas",
                  "Contato e Verificação",
                  "Imagens e Missão",
                  "Documentos da ONG",
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
                controller: controllerName,
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
                controller: controllerBio,
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
                controller: controllerAbout,
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
                controller: controllerPhone,
                decoration: InputDecoration(labelText: "Telefone"),
                validator: FormBuilderValidators.compose(
                  [
                    FormBuilderValidators.required(
                      errorText: "Campo obrigatório",
                    ),
                    FormBuilderValidators.numeric(
                      errorText: "Número inválido",
                    ),
                    FormBuilderValidators.minLength(
                      9,
                      errorText: "Número inválido",
                    ),
                  ],
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
                      text: "E-mail da ONG",
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
                name: "email",
                controller: controllerEmail,
                decoration: InputDecoration(labelText: "E-mail"),
                keyboardType: TextInputType.emailAddress,
                validator: FormBuilderValidators.compose(
                  [
                    FormBuilderValidators.required(
                      errorText: "Campo obrigatório",
                    ),
                    FormBuilderValidators.email(
                      errorText: "E-mail inválido",
                    ),
                  ],
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
                      text: "Website",
                    ),
                    TextSpan(
                        text: " (Opcional)", style: TextStyle(fontSize: 12))
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: FormBuilderTextField(
                name: "website",
                controller: controllerWebsite,
                decoration: InputDecoration(labelText: "www.helpe-me.com"),
                keyboardType: TextInputType.emailAddress,
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
                readOnly: false,
                onTap: () {},
                decoration: InputDecoration(
                  hintText: "Localização",
                  suffixIcon: Icon(Icons.search),
                ),
              ),
            ),

            // Padding(
            //   padding: const EdgeInsets.symmetric(vertical: 8),
            //   child: FormBuilderTextField(
            //     name: "location",
            //     autovalidateMode: AutovalidateMode.onUserInteraction,
            //     validator: FormBuilderValidators.required(
            //       errorText: 'Campo Obrigatório',
            //     ),
            //     controller: controllerLocation,
            //     readOnly: true,
            //     onTap: () {
            //       _searchPlaces();
            //     },
            //     decoration: InputDecoration(
            //       hintText: "Localização",
            //       suffixIcon: Icon(Icons.search),
            //     ),
            //   ),
            // ),

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
                      text: "Imagens da ONG",
                    ),
                    TextSpan(
                        text: "*",
                        style: TextStyle(color: Colors.red, fontSize: 16))
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: FormBuilderFilePicker(
                name: "profile_image_url",
                decoration: InputDecoration(labelText: "Imagem de Perfil"),
                maxFiles: 1,
                previewImages: true,
                initialValue: _selectedProfileFiles,
                allowedExtensions: ['jpg', 'jpeg', 'png'],
                validator: FormBuilderValidators.required(
                  errorText: "Campo obrigatório",
                ),
                onChanged: (val) {
                  setState(() {
                    _selectedProfileFiles = val;
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
                initialValue: _selectedCoverFiles,
                allowedExtensions: ['jpg', 'jpeg', 'png'],
                validator: FormBuilderValidators.required(
                  errorText: "Campo obrigatório",
                ),
                onChanged: (val) {
                  setState(() {
                    _selectedCoverFiles = val;
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
                controller: controllerMission,
                decoration: InputDecoration(hintText: "Nossa Missão"),
                maxLines: 3,
                validator: FormBuilderValidators.required(
                  errorText: "Campo obrigatório",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: FormBuilderTextField(
                name: "vision",
                controller: controllerVision,
                decoration: InputDecoration(hintText: "Nossa Visão"),
                maxLines: 3,
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
              initialValue: _selectedStatutesFiles,
              onChanged: (val) {
                setState(() {
                  _selectedStatutesFiles = val;
                });
              },
            ),
            buildDocumentField(
              context,
              title: "Declaração de Idoneidade da ONG",
              fieldName: "declaration_good_standing",
              initialValue: _selectedDeclarationFiles,
              onChanged: (val) {
                setState(() {
                  _selectedDeclarationFiles = val;
                });
              },
            ),
            buildDocumentField(
              context,
              title: "Ata de Assembleia de Constituição",
              fieldName: "minutes_constitutive_assembly",
              initialValue: _selectedAssemblyFiles,
              onChanged: (val) {
                setState(() {
                  _selectedAssemblyFiles = val;
                });
              },
            ),
            buildDocumentField(
              context,
              title: "Escritura Pública de Constituição",
              fieldName: "public_deed",
              initialValue: _selectedPublicDeedFiles,
              onChanged: (val) {
                setState(() {
                  _selectedPublicDeedFiles = val;
                });
              },
            ),
            buildDocumentField(
              context,
              title: "Certificado de Registo da ONG (opcional)",
              fieldName: "registration_certificate",
              initialValue: _selectedRegistrationFiles,
              required: false,
              onChanged: (val) {
                setState(() {
                  _selectedRegistrationFiles = val;
                });
              },
            ),
            buildDocumentField(
              context,
              title: "Número de Identificação Fiscal (NIF)",
              fieldName: "nif",
              initialValue: _selectedNifFiles,
              onChanged: (val) {
                setState(() {
                  _selectedNifFiles = val;
                });
              },
            ),
            buildDocumentField(
              context,
              title: "Bilhete de Identidade do  Representante Legal",
              fieldName: "bi_representative",
              initialValue: _selectedBiFiles,
              onChanged: (val) {
                setState(() {
                  _selectedBiFiles = val;
                });
              },
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
    Function(List<PlatformFile>?)? onChanged,
    List<PlatformFile>? initialValue,
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
            onChanged: onChanged,
            initialValue: initialValue,
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
