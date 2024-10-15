

import 'package:blogapp/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SingleBlogScreen extends StatelessWidget {
  String title;
  String description;
  String image;
  SingleBlogScreen({super.key,required this.title,required this.description,required this.image});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        actions: const [
          CircleAvatar(
            backgroundColor: kGreyColor,
            radius: 25,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(title,style: const TextStyle(
              color: kBlackColor,
              fontWeight: FontWeight.w700,
              fontSize: 30
            ),),
            Container(
          width: double.infinity,
          height: 250.h,
          decoration: BoxDecoration(
            color: kGreyColor,
            borderRadius: BorderRadius.circular(15.r),
          ),
          child: Image(image: NetworkImage(image),fit: BoxFit.fill,),
         
        ),
            Container(
              padding: const EdgeInsets.all(10),
          width: double.infinity,
          height: 250.h,
          decoration: BoxDecoration(
            color: kGreyColor,
            borderRadius: BorderRadius.circular(15.r),
          ),
          child: Text(description,style: const TextStyle(
            color: kBlackColor,
            fontSize: 18,
            fontWeight: FontWeight.w500
          ),),
         
        ),
        
          ],
        ),
      ),
    ));
  }
}