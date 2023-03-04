import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future navigatorAndReplace(context , widget) =>  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (contex) => widget ), (route) => false);