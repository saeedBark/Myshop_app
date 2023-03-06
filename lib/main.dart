import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_shop_app/Screens/login/loginScreen.dart';
import 'package:my_shop_app/Screens/onbordingScreen/onbording_screen.dart';
import 'package:my_shop_app/layout/cubit/cubit.dart';
import 'package:my_shop_app/layout/layout.dart';
import 'package:my_shop_app/network/dio_api/dioApi.dart';
import 'package:my_shop_app/network/shared_preference/shared_preference.dart';
import 'package:my_shop_app/style/bloc_observ.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.inti();
  await SharedPreferenceCach.inti();


  bool onBording = SharedPreferenceCach.getData(key: 'onbording');
  String token = SharedPreferenceCach.getData(key: 'token');
  Widget widget;
  if (onBording != null) {
    if (token != null) {
      // LayoutScreen widget;
      widget = LayoutScreen();
    }
    else {
      widget = LoginScreen();
    }
  } else {
    widget = OnboardingScreen();
  }

  runApp(MyShopApp(widgets: widget,));
}


class MyShopApp extends StatelessWidget {
  // final bool onbording;
  // final bool token;
  final Widget? widgets;

  const MyShopApp({ required this.widgets});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MyshopCubit()..getDataHome()..getDataCategory(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,


        theme: ThemeData(
          appBarTheme: const AppBarTheme(
              backgroundColor: Colors.white,
              titleTextStyle: TextStyle(color: Colors.black, fontSize: 24),
              elevation: 0,
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                statusBarIconBrightness: Brightness.dark,
              ),
              iconTheme: IconThemeData(
                color: Colors.black,
              )),
          scaffoldBackgroundColor: Colors.white,
          primarySwatch: Colors.pink,
          textTheme: const TextTheme(
            titleLarge: TextStyle(color: Colors.black, fontSize: 20),
          ),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            type: BottomNavigationBarType.fixed,
            showUnselectedLabels: true,
            selectedItemColor: Colors.deepOrange,
            unselectedItemColor: Colors.grey,
            elevation: 0,
          ),
        ),

        home: widgets,
      ),
    );
  }
}
