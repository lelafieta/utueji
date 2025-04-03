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
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  final _formStepOneKey = GlobalKey<FormBuilderState>();
  final _formStepTwoKey = GlobalKey<FormBuilderState>();
  final _formStepThreeKey = GlobalKey<FormBuilderState>();
  int activeStep = 0;
  int activeStep2 = 0;
  int reachedStep = 0;
  int upperBound = 5;
  double progress = 0.2;

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
        return stepOne(context);
      case 2:
        return stepOne(context);
      default:
        return stepOne(context);
    }
  }

  void _submitStepOneForm() {
    if (_formStepOneKey.currentState?.saveAndValidate() ?? false) {
      // formDataStepOne = _formStepOneKey.currentState!.value;

      // print(_formStepOneKey.currentState);

      // String titulo = formDataStepOne["title"];
      // String descricao = formDataStepOne["description"];
      // String moeda = formDataStepOne["currency"];
      // String objetivo = formDataStepOne["fundraising_goal"];
      // String dataInicio = formDataStepOne["start_date"].toString();
      // String dataFim = formDataStepOne["end_date"].toString();
      // String localizacao = formDataStepOne["location"];

      // print("Categoria: ${_selectedOptionCategory!.id}");
      // print("Título: $titulo");
      // print("Descrição: $descricao");
      // print("Moeda: $moeda");
      // print("Objetivo: $objetivo");
      // print("Data de Início: $dataInicio");
      // print("Data de Fim: $dataFim");
      // print("Localização: $localizacao");

      // Agora você pode enviar esses dados para o backend ou salvar no banco de dados
    } else {
      print("Formulário inválido!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro de ONG'),
        centerTitle: false,
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
                      // if (_selectedOptionCategory == null) {
                      //   final category = CategoryEntity(
                      //       id: "empty",
                      //       name: "Empty",
                      //       createdAt: DateTime.now());
                      //   setState(() {
                      //     _selectedOptionCategory = category;
                      //   });
                      // }
                      print(_formStepOneKey.currentState!.value);
                    }
                  } else if (activeStep == 1) {
                    if (_formStepTwoKey.currentState!.validate()) {
                      // _submitStepTwoForm();
                      setState(() {
                        activeStep++;
                      });
                    } else {
                      // print("else $_selectedOptionType");
                      // if (_selectedOptionType == null) {
                      //   setState(() {
                      //     _selectedOptionType = "empty";
                      //   });
                      // }
                    }
                  } else {
                    // setState(() {
                    //   activeStep++;
                    // });
                    // _submitStepThreeForm();
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
                      AppImages.ong,
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
              // controller: title,
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
              // controller: description,
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
                  // selectedCoverImage = List<PlatformFile>.from(val ?? []);
                });
              },
              decoration: InputDecoration(labelText: "Imagem"),
              maxFiles: 1,
              // initialValue: selectedCoverImage,
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
                    // initialValue: currency.text,
                    onChanged: (value) {
                      // currency.text = value!;
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
                        // controller: fundRaisingGoal,
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
              // controller: startDate,
              format: DateFormat("dd-MM-yyyy"),
              // initialValue: startDate.text.isNotEmpty
              //     ? DateFormat("dd-MM-yyyy").parse(startDate.text)
              //     : DateTime.now(), // Define a data inicial baseada no texto
              autovalidateMode: AutovalidateMode.onUserInteraction,
              onChanged: (value) {
                if (value != null) {
                  // startDate.text = DateFormat("dd-MM-yyyy").format(value);
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
              // controller: endDate,
              format: DateFormat("dd-MM-yyyy"),
              // initialValue: endDate.text.isNotEmpty
              //     ? DateFormat("dd-MM-yyyy").parse(endDate.text)
              //     : DateTime.now(), // Define a data inicial baseada no texto
              autovalidateMode: AutovalidateMode.onUserInteraction,
              onChanged: (value) {
                if (value != null) {
                  // endDate.text = DateFormat("dd-MM-yyyy").format(value);
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
              // controller: controllerLocation,
              readOnly: true,
              onTap: () {
                // _searchPlaces();
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
