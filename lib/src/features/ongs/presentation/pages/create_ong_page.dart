import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_file_picker/form_builder_file_picker.dart';
import 'package:form_builder_phone_field/form_builder_phone_field.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class CreateOngPage extends StatefulWidget {
  @override
  _CreateOngPageState createState() => _CreateOngPageState();
}

class _CreateOngPageState extends State<CreateOngPage> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro de ONG'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FormBuilder(
          key: _fbKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // **1. Documentos da ONG**
                Text('Documentos da ONG', style: TextStyle(fontSize: 20)),
                SizedBox(height: 16),
                FormBuilderFilePicker(
                  name: 'estatuto_social',
                  decoration: InputDecoration(
                      labelText: 'Estatuto Social (PDF ou Imagem)'),
                  validator: FormBuilderValidators.required(
                      errorText: "Campo obrigatório"),
                  allowMultiple: false,
                  onFileLoading: (val) =>
                      Center(child: CircularProgressIndicator()),
                ),
                SizedBox(height: 16),
                FormBuilderFilePicker(
                  name: 'certificado_registro',
                  decoration: InputDecoration(
                      labelText: 'Certificado de Registo da ONG'),
                  validator: FormBuilderValidators.required(
                      errorText: "Campo obrigatório"),
                  allowMultiple: false,
                  onFileLoading: (val) =>
                      Center(child: CircularProgressIndicator()),
                ),
                SizedBox(height: 16),
                FormBuilderFilePicker(
                  name: 'publicacao_diario_republica',
                  decoration: InputDecoration(
                      labelText: 'Publicação no Diário da República'),
                  validator: FormBuilderValidators.required(
                      errorText: "Campo obrigatório"),
                  allowMultiple: false,
                  onFileLoading: (val) =>
                      Center(child: CircularProgressIndicator()),
                ),
                SizedBox(height: 16),
                FormBuilderTextField(
                  name: 'nif',
                  decoration: InputDecoration(
                      labelText: 'Número de Identificação Fiscal (NIF)'),
                  validator: FormBuilderValidators.required(
                      errorText: "Campo obrigatório"),
                ),
                SizedBox(height: 16),

                // **2. Documentos do Representante Legal**
                Text('Documentos do Representante Legal',
                    style: TextStyle(fontSize: 20)),
                SizedBox(height: 16),
                FormBuilderTextField(
                  name: 'bilhete_identidade',
                  decoration: InputDecoration(
                      labelText: 'Bilhete de Identidade ou Passaporte'),
                  validator: FormBuilderValidators.required(
                      errorText: "Campo obrigatório"),
                ),
                SizedBox(height: 16),
                FormBuilderTextField(
                  name: 'procurao',
                  decoration:
                      InputDecoration(labelText: 'Procuração (se aplicável)'),
                ),
                SizedBox(height: 16),
                FormBuilderTextField(
                  name: 'comprovante_residencia',
                  decoration:
                      InputDecoration(labelText: 'Comprovante de Residência'),
                  validator: FormBuilderValidators.required(
                      errorText: "Campo obrigatório"),
                ),
                SizedBox(height: 16),

                // **3. Dados Bancários**
                Text('Dados Bancários (Opcional)',
                    style: TextStyle(fontSize: 20)),
                SizedBox(height: 16),
                FormBuilderTextField(
                  name: 'comprovante_conta_bancaria',
                  decoration: InputDecoration(
                      labelText: 'Comprovante de Conta Bancária da ONG'),
                ),
                SizedBox(height: 16),
                FormBuilderTextField(
                  name: 'comprovante_isencao_fiscal',
                  decoration: InputDecoration(
                      labelText:
                          'Comprovante de Isenção Fiscal (se aplicável)'),
                ),
                SizedBox(height: 16),

                // **4. Informações Adicionais da ONG**
                Text('Informações Adicionais', style: TextStyle(fontSize: 20)),
                SizedBox(height: 16),
                FormBuilderFilePicker(
                  name: 'logotipo',
                  decoration: InputDecoration(labelText: 'Logotipo da ONG'),
                  validator: FormBuilderValidators.required(
                      errorText: "Campo obrigatório"),
                  allowMultiple: false,
                  onFileLoading: (val) =>
                      Center(child: CircularProgressIndicator()),
                ),
                SizedBox(height: 16),
                FormBuilderTextField(
                  name: 'endereco_fisico',
                  decoration:
                      InputDecoration(labelText: 'Endereço Físico da ONG'),
                  validator: FormBuilderValidators.required(
                      errorText: "Campo obrigatório"),
                ),
                SizedBox(height: 16),
                FormBuilderTextField(
                  name: 'contatos',
                  decoration:
                      InputDecoration(labelText: 'Contatos (telefone, email)'),
                  validator: FormBuilderValidators.required(
                      errorText: "Campo obrigatório"),
                ),
                SizedBox(height: 16),
                FormBuilderTextField(
                  name: 'descricao',
                  decoration: InputDecoration(labelText: 'Descrição da ONG'),
                  validator: FormBuilderValidators.required(
                      errorText: "Campo obrigatório"),
                ),
                SizedBox(height: 16),

                // **5. Missão e Visão**
                Text('Missão e Visão', style: TextStyle(fontSize: 20)),
                SizedBox(height: 16),
                FormBuilderTextField(
                  name: 'missao',
                  decoration: InputDecoration(labelText: 'Missão da ONG'),
                  validator: FormBuilderValidators.required(
                      errorText: "Campo obrigatório"),
                ),
                SizedBox(height: 16),
                FormBuilderTextField(
                  name: 'visao',
                  decoration: InputDecoration(labelText: 'Visão da ONG'),
                  validator: FormBuilderValidators.required(
                      errorText: "Campo obrigatório"),
                ),
                SizedBox(height: 16),

                // **6. Slogan e Descrição**
                Text('Slogan e Descrição', style: TextStyle(fontSize: 20)),
                SizedBox(height: 16),
                FormBuilderTextField(
                  name: 'slogan',
                  decoration: InputDecoration(labelText: 'Slogan da ONG'),
                  validator: FormBuilderValidators.required(
                      errorText: "Campo obrigatório"),
                ),
                SizedBox(height: 16),
                FormBuilderTextField(
                  name: 'descricao_completa',
                  decoration:
                      InputDecoration(labelText: 'Descrição Completa da ONG'),
                  validator: FormBuilderValidators.required(
                      errorText: "Campo obrigatório"),
                ),
                SizedBox(height: 16),

                // **7. Extras**
                Text('Extras (opcional)', style: TextStyle(fontSize: 20)),
                SizedBox(height: 16),
                FormBuilderTextField(
                  name: 'termo_compromisso',
                  decoration: InputDecoration(
                      labelText: 'Termo de Compromisso e Política de Uso'),
                ),
                SizedBox(height: 16),
                FormBuilderTextField(
                  name: 'prova_projetos',
                  decoration: InputDecoration(
                      labelText: 'Prova de Projetos ou Impacto Social'),
                ),
                SizedBox(height: 16),

                // Botão de Enviar
                ElevatedButton(
                  onPressed: () {
                    if (_fbKey.currentState?.saveAndValidate() ?? false) {
                      print(_fbKey.currentState
                          ?.value); // Aqui você pode manipular os dados do formulário
                      // Enviar para o servidor ou fazer algo com os dados
                    } else {
                      print('Falha na validação do formulário');
                    }
                  },
                  child: Text('Registrar ONG'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
