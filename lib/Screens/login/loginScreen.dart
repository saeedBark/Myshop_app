import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_shop_app/Screens/login/cubit/cubit.dart';
import 'package:my_shop_app/Screens/login/cubit/state.dart';
import 'package:my_shop_app/Screens/register/register_screen.dart';
import 'package:my_shop_app/componets/componets.dart';
import 'package:my_shop_app/layout/layout.dart';
import 'package:my_shop_app/network/shared_preference/shared_preference.dart';
import 'package:my_shop_app/style/color.dart';
import 'package:my_shop_app/widget/navigator.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    return BlocProvider(
      create: (context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginState>(
        listener: (context, state) {
          if (state is ShopLoginSuccessState) {
            if (state.mod.status!) {
              SharedPreferenceCach.saveData(
                      key: 'token', value: state.mod.data!.token)
                  .then((value) {
                token = state.mod.data!.token;

                toastShow(text: state.mod.message!, color: Colors.green);
                navigatorAndReplace(context, const LayoutScreen());
              }).catchError((error) {
                print(error.toString());
              });
            } else {
              // print(state.mod.message!);
              toastShow(text: state.mod.message!, color: Colors.red);
            }
          }
        },
        builder: (context, state) {
          var cubit = ShopLoginCubit.get(context);
          return SafeArea(
            child: Scaffold(
              // appBar: AppBar(),
              body: Stack(
                //  alignment: Alignment.center,
                //  crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Image(
                    image: NetworkImage(
                        'https://images.unsplash.com/photo-1679147207853-02d72c69043e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw2fHx8ZW58MHx8fHw%3D&auto=format&fit=crop&w=500&q=60'),
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: formkey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          defaultText(
                              text: 'LOGIN',
                              fontSize: 24,
                              fontWeidght: FontWeight.bold,
                              color: const Color(0xFFD319C2)),
                          const SizedBox(
                            height: 10,
                          ),
                          defaultText(
                              text: 'Please entre your email and password ',
                              fontSize: 20,
                              fontWeidght: FontWeight.bold,
                              color: Colors.grey),
                          const SizedBox(
                            height: 30,
                          ),
                          defaultFormFile(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please you must fill email here..';
                              }
                              return null;
                            },
                            lable: 'Email',
                            prefix: Icons.email,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          defaultFormFile(
                            controller: passwordController,
                            isPassword: cubit.isPassword,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please you must fill password here..';
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
                            height: 30,
                          ),
                          ConditionalBuilder(
                            condition: state is! ShopLoginLoadingState,
                            builder: (context) => defaultButton(
                              fanction: () {
                                if (formkey.currentState!.validate()) {
                                  cubit.userLogin(
                                      email: emailController.text,
                                      password: passwordController.text);
                                  //  print('saeed');
                                  // navigatorAndReplace(context, LayoutScreen());
                                }
                              },
                              text: 'LOgin',
                              isUpperCase: true,
                            ),
                            fallback: (context) =>
                                const Center(child: CircularProgressIndicator()),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              defaultText(
                                text: "Don't have alerdy email?",
                              ),
                              TextButton(
                                  onPressed: () {
                                    navigatorAndReplace(context, RegisterScreen());
                                  },
                                  child: defaultText(
                                      text: 'Register', color: defaultColor)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
