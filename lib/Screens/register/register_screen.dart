import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_shop_app/Screens/register/cubit/cubit.dart';
import 'package:my_shop_app/Screens/register/cubit/state.dart';
import 'package:my_shop_app/componets/componets.dart';
import 'package:my_shop_app/layout/layout.dart';
import 'package:my_shop_app/network/shared_preference/shared_preference.dart';
import 'package:my_shop_app/widget/default_button.dart';
import 'package:my_shop_app/widget/default_text_form.dart';
import 'package:my_shop_app/widget/navigator.dart';
import 'package:my_shop_app/widget/text.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterState>(
        listener: (context, state) {
          if (state is ShopRegisterSuccessState) {
            if (state.mod.status!) {
              SharedPreferenceCach.saveData(
                      key: 'token', value: state.mod.data!.token)
                  .then((value) {
                token = state.mod.data!.token;

                toastShow(text: state.mod.message!, color: Colors.amber);
                navigatorAndReplace(context, const LayoutScreen());
              }).catchError((error) {
                print(error.toString());
              });
            } else {
              toastShow(text: state.mod.message!, color: Colors.red);
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: const RegisterForm(),
          );
        },
      ),
    );
  }
}

class RegisterForm extends StatelessWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = ShopRegisterCubit.get(context);
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: cubit.formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const DefaultText(
                    text: 'REGISTER',
                    fontSize: 24,
                    fontWeidght: FontWeight.bold,
                    color: Color(0xFFD319C2)),
                const SizedBox(
                  height: 30,
                ),
                DefaultTextForm(
                  controller: cubit.namedController,
                  type: TextInputType.name,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please you must fill your name here..';
                    }
                    return null;
                  },
                  lable: 'Name',
                  prefix: Icons.person,
                ),
                const SizedBox(
                  height: 10,
                ),
                DefaultTextForm(
                  controller: cubit.emailController,
                  type: TextInputType.emailAddress,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please you must fill your email here..';
                    }
                    return null;
                  },
                  lable: 'Email',
                  prefix: Icons.email,
                ),
                const SizedBox(
                  height: 10,
                ),
                DefaultTextForm(
                  controller: cubit.passwordController,
                  isPassword: cubit.isPassword,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please you must fill your password here..';
                    }
                    return null;
                  },
                  suffix: cubit.suffix,
                  onTap: () {
                    cubit.changPasswordShow();
                  },
                  lable: 'Password',
                  prefix: Icons.password,
                ),
                const SizedBox(
                  height: 10,
                ),
                DefaultTextForm(
                  controller: cubit.phoneController,
                  type: TextInputType.phone,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please you must fill your phone here..';
                    }
                    return null;
                  },
                  lable: 'Phone',
                  prefix: Icons.phone,
                ),
                const SizedBox(
                  height: 30,
                ),
                ConditionalBuilder(
                  condition: true,
                  // state is! ShopLoginLoadingState,
                  builder: (context) => DefaultButton(
                    function: () {
                      if (cubit.formkey.currentState!.validate()) {
                        cubit.userLogin(
                            email: cubit.emailController.text,
                            password: cubit.passwordController.text,
                            name: cubit.namedController.text,
                            phone: cubit.phoneController.text);
                      }
                    },
                    text: 'Register',
                    isUpperCase: true,
                  ),
                  fallback: (context) =>
                      const Center(child: CircularProgressIndicator()),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
