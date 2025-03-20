// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:awesome_place_search/awesome_place_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_file_picker/form_builder_file_picker.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';

import '../../../../config/themes/app_colors.dart';
import '../../../categories/domain/entities/category_entity.dart';
import '../../domain/entities/campaign_entity.dart';
import 'create_campaign_page.dart';

class EditMyCampaignPage extends StatefulWidget {
  final CampaignEntity campaign;
  EditMyCampaignPage({super.key, required this.campaign});

  @override
  State<EditMyCampaignPage> createState() => _EditMyCampaignPageState();
}

class _EditMyCampaignPageState extends State<EditMyCampaignPage> {
  final _formStepOneKey = GlobalKey<FormBuilderState>();
  final _formStepTwoKey = GlobalKey<FormBuilderState>();
  final _formStepThreeKey = GlobalKey<FormBuilderState>();

  // final googleApiKey = dotenv.env["GOOGLE_API_KEY"];
  PredictionModel? prediction;
  List<PlatformFile> selectedMidias = [];
  List<PlatformFile> selectedDocments = [];
  List<PlatformFile> selectedCoverImage = [];

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Editar Campanha'),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              "Salvar",
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: AppColors.primaryColor,
                    fontSize: 16,
                  ),
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 15),
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
                hintText: "Descrição",
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
}
