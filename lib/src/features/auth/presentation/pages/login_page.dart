import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:utueji/src/app/app_entity.dart';

import '../../../../config/themes/app_colors.dart';
import '../../../../core/resources/icons/app_icons.dart';
import '../../../../core/utils/app_utils.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocConsumer<AuthCubit, AuthState>(listener: (context, state) {
          if (state is AuthLoading) {
            EasyLoading.show(status: "Autenticando...");
          } else if (state is AuthFailure) {
            EasyLoading.dismiss();
            AppUtils.errorToast(state.failure);
          } else if (state is Authenticated) {
            AppEntity.uid = state.user!.id;
            EasyLoading.dismiss();
            AppUtils.successToast("SUCESSO.");
          }
        }, builder: (context, state) {
          return Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'SOLIDARY',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Text(
                  //   "SEJA BEN-VINDO",
                  //   style: Theme.of(context).textTheme.titleLarge,
                  // ),
                  // const SizedBox(height: 16),
                  const Text(
                    'Suas ações importam. Junte-se a nós em nossa missão de criar um impacto positivo e elevar vidas.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 32),
                  // Row(
                  //   children: [
                  //     Flexible(
                  //       flex: 2,
                  //       // child: TextFormField(
                  //       //   decoration: InputDecoration(
                  //       //     prefixIcon: DropdownButton<String>(
                  //       //       value: '+91',
                  //       //       items: ['+91', '+244', '+1']
                  //       //           .map((code) => DropdownMenuItem(
                  //       //                 value: code,
                  //       //                 child: Text(code),
                  //       //               ))
                  //       //           .toList(),
                  //       //       onChanged: (value) {},
                  //       //       underline: Container(),
                  //       //     ),
                  //       //     border: const OutlineInputBorder(),
                  //       //     hintText: 'Digite o número de telefone',
                  //       //   ),
                  //       // ),
                  //       child: PhoneFormField(
                  //         decoration: const InputDecoration(
                  //           filled: true,
                  //           fillColor: Colors.white,
                  //         ),
                  //         initialValue: PhoneNumber.parse('+244'),
                  //         validator: PhoneValidator.compose([
                  //           PhoneValidator.required(context,
                  //               errorText: "Campo obrigatório"),
                  //           PhoneValidator.validMobile(context,
                  //               errorText: "Contacto inválido")
                  //         ]),
                  //         countrySelectorNavigator:
                  //             const CountrySelectorNavigator.page(),
                  //         onChanged: (phoneNumber) =>
                  //             print('changed into $phoneNumber'),
                  //         enabled: true,
                  //         isCountrySelectionEnabled: true,
                  //         isCountryButtonPersistent: true,
                  //         countryButtonStyle: const CountryButtonStyle(
                  //             showDialCode: true,
                  //             showIsoCode: true,
                  //             showFlag: true,
                  //             flagSize: 16),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  FormBuilderTextField(
                    name: "email",
                    decoration: InputDecoration(
                      hintText: "Email",
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(12),
                        child: SvgPicture.asset(
                          AppIcons.envelope,
                          width: 18,
                          color: AppColors.grey,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  FormBuilderTextField(
                    name: "password",
                    decoration: InputDecoration(
                      hintText: "Password",
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(12),
                        child: SvgPicture.asset(
                          AppIcons.key,
                          width: 18,
                          color: AppColors.grey,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: true,
                        onChanged: (bool? value) {},
                      ),
                      const Text('Enviar-me atualizações no WhatsApp')
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Row(
                    children: [
                      Expanded(child: Divider()),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text('Or'),
                      ),
                      Expanded(child: Divider()),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: IconButton(
                          icon: SvgPicture.asset(
                            AppIcons.gmail,
                            width: 35,
                          ),
                          onPressed: () {
                            // context.read<AuthCubit>().loginWithGoogle();
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: () {},
                    child: const Text(
                      'Já tem uma conta? Entrar',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        context
                            .read<AuthCubit>()
                            .login("lela.fieta@gmail.com", "123456");
                      },
                      // style: ElevatedButton.styleFrom(
                      //   primary: Colors.green,
                      //   shape: RoundedRectangleBorder(
                      //     borderRadius: BorderRadius.circular(8),
                      //   ),
                      //   padding: const EdgeInsets.symmetric(vertical: 16),
                      // ),

                      child: const Text(
                        'Continuar',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Ao continuar, você concorda com nossos Termos de Serviço e Política de Privacidade',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
