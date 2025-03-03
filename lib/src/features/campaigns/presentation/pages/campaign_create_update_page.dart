import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../../../config/themes/app_colors.dart';
import '../../../../core/utils/app_values.dart';
import '../../domain/entities/campaign_entity.dart';

class CampaignCreateUpdatePage extends StatefulWidget {
  final CampaignEntity campaign;
  const CampaignCreateUpdatePage({super.key, required this.campaign});

  @override
  State<CampaignCreateUpdatePage> createState() =>
      _CampaignCreateUpdatePageState();
}

class _CampaignCreateUpdatePageState extends State<CampaignCreateUpdatePage> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Criar Actualização'),
        // actions: [
        //   IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
        // ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: FormBuilder(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Título da actualização",
                  style: TextStyle(color: Colors.black),
                ),
                const SizedBox(height: 5),
                FormBuilderTextField(
                  name: 'title',
                  decoration: const InputDecoration(
                    hintText: 'Título',
                    border: OutlineInputBorder(),
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                  ]),
                ),
                const SizedBox(height: 20),
                Text("Descrição da actualização",
                    style: TextStyle(color: Colors.black)),
                const SizedBox(height: 5),
                FormBuilderTextField(
                  name: 'description',
                  decoration: InputDecoration(
                    hintText: 'Descrição',
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.primaryColor),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.strokeColor),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  maxLines: 5,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                  ]),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          AppValues.s10,
                        ),
                      ),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.saveAndValidate()) {
                      print(_formKey.currentState!.value);
                    }
                  },
                  child: const Text('Atualizar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
