import 'package:flutter/material.dart';
import 'package:my_shop_app/Screens/login/loginScreen.dart';
import 'package:my_shop_app/models/onbording_model.dart';
import 'package:my_shop_app/network/shared_preference/shared_preference.dart';
import 'package:my_shop_app/widget/navigator.dart';
import 'package:my_shop_app/widget/widget_onbording.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  bool isLast = false;

  void saveOnbordingAndNavigat(){
  SharedPreferenceCach.saveData(key: 'onbording', value: true).then((value) {
    if(value) {
      navigatorAndReplace(context, LoginScreen());
    }
  }).catchError((error){
    print(error.toString());
  });

  }

  @override
  Widget build(BuildContext context) {
    List<OnbordingModel> onbording = [
      OnbordingModel('assets/images/onbording_1.jpeg', 'title 1 on bording ',
          'body 1 on bording '),
      OnbordingModel('assets/images/onbording_2.jpeg', 'title 2 on bording ',
          'body 2 on bording '),
      OnbordingModel('assets/images/onbording_3.jpeg', 'title 3 on bording ',
          'body 3 on bording '),
    ];
    var controllerJumb = PageController();

    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
    saveOnbordingAndNavigat();
            },
            child: Text(
              'SKIP',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: const Color(0xFFD319C2)),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) =>
                    onbordingItem(onbording[index]),
                itemCount: onbording.length,
                controller: controllerJumb,
                onPageChanged: (int index) {
                  if (index == onbording.length - 1) {
                    setState(() {
                       isLast = true;
                    });
                    print('yes');
                     //   Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                  } else {
                    setState(() {
                      isLast = false;
                    });
                    print('no');
                  }
                },
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: controllerJumb,
                  count: onbording.length,
                  //axisDirection: Axis.vertical,
                  effect: const WormEffect(
                    spacing: 10.0,
                    //
                    // //   radius:  4.0,
                    dotWidth: 24.0,
                    dotHeight: 16.0,
                    paintStyle: PaintingStyle.stroke,
                    strokeWidth: 1.5,
                    dotColor: Colors.grey,
                    activeDotColor: Color(0xFFD319C2),
                  ),
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if(isLast == true) {
                      print('hi');
                     saveOnbordingAndNavigat();
                    } else {
                      print('hiiii');
                      controllerJumb.nextPage(
                          duration: const Duration(milliseconds: 750),
                          curve: Curves.decelerate);
                   //   navigatorAndReplace(context, LoginScreen());
                    }
                  },
                  child: const Icon(Icons.arrow_forward_ios),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
