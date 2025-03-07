import 'package:dropdown_search/dropdown_search.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:group_button/group_button.dart';

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
                    color: Colors.black12,
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
          Expanded(
            child: SingleChildScrollView(
              child: Column(
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
                              color: isSelected
                                  ? AppColors.primaryColor
                                  : Colors.white,
                              border: Border.all(
                                color: AppColors.primaryColor,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              titles[index],
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      color: isSelected
                                          ? Colors.white
                                          : Colors.black),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    child: RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    child: FormBuilderDropdown(
                      name: 'member',
                      isDense: false,
                      decoration: InputDecoration(
                        label: Text("Pessoa"),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 4),
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
                            (member) => DropdownMenuItem(
                                value: member, child: Text("$member")),
                          )
                          .toList(),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    child: RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: FormBuilderTextField(
                      name: "name",
                      decoration: InputDecoration(
                        label: Text("Nome"),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: FormBuilderDateTimePicker(
                      name: "nascimento",
                      decoration: InputDecoration(
                        hintText: "DD-MM-YYYY",
                        suffixIcon: Icon(Icons.calendar_month_rounded),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: FormBuilderTextField(
                      name: "name",
                      decoration: InputDecoration(
                        label: Text("Localização"),
                        suffixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: FormBuilderTextField(
                      name: "name",
                      decoration: InputDecoration(
                        label: Text("Telefone"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
