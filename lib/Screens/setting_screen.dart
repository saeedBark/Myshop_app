import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_shop_app/Screens/login/loginScreen.dart';
import 'package:my_shop_app/componets/componets.dart';
import 'package:my_shop_app/layout/cubit/cubit.dart';
import 'package:my_shop_app/layout/cubit/state.dart';
import 'package:my_shop_app/network/shared_preference/shared_preference.dart';
import 'package:my_shop_app/widget/navigator.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({Key? key}) : super(key: key);
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MyshopCubit, MyshopState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = MyshopCubit.get(context).update!.data!;

        nameController.text = cubit.name;
        emailController.text = cubit.email;
        phoneController.text = cubit.phone;

        return Form(
          key: formkey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ConditionalBuilder(
              condition: cubit != null,
              builder:(context) => ListView(
                children: [
                  if(state is MyshopSuccessUpdateUserState)
                  const LinearProgressIndicator(),
                  const SizedBox(height: 10,),
                  defaultFormFile(
                      controller: nameController,
                      lable: 'User Name',
                      prefix: Icons.person,
                      type: TextInputType.name,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Please you must  entre name here....';
                        }
                        return null;
                      }
                  ),
                  const SizedBox(height: 10,),
                  defaultFormFile(
                      controller: emailController,
                      lable: 'Email',
                      prefix: Icons.email,
                      type: TextInputType.emailAddress,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Please you must entre email here....';
                        }
                        return null;
                      }
                  ),
                  const SizedBox(height: 10,),
                  defaultFormFile(
                      controller: phoneController,
                      lable: 'Phone',
                      prefix: Icons.phone,
                      type: TextInputType.phone,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Please you must entre name here....';
                        }
                        return null;
                      }
                  ),
                  const SizedBox(height: 20,),
                  defaultButton(fanction: (){
                    if(formkey.currentState!.validate()){
                      MyshopCubit.get(context).updateUser(
                          name: nameController.text,
                          email: emailController.text,
                          phone: phoneController.text
                      );
                    }
                  }, text: 'Update'),
                  const SizedBox(height: 20,),
                  defaultButton(fanction: (){
                    SharedPreferenceCach.logout(key: 'token').then((value) {
                      navigatorAndReplace(context, LoginScreen());
                    });
                  }, text: 'Logout'),
                ],
              ),
              fallback: (context) => const Center(child: CircularProgressIndicator()),
            ),
          ),
        );
      },
    );
  }
}
