import 'package:flutter/material.dart';
import 'package:my_shop_app/componets/componets.dart';

class SearchScreen extends StatelessWidget {
   SearchScreen({Key? key}) : super(key: key);
var searchController =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        defaultFormFile(
            controller: searchController,
            type: TextInputType.text,
            lable: 'Search',
            prefix: Icons.search,
            validator: (String value){
              if(value.isEmpty){
                return 'you must search product here...';
              }
              return null;
            }
        ),
      ],
    );
  }
}
