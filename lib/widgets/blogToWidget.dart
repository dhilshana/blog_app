import 'package:blogapp/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BlogToWidget extends StatelessWidget {
  const BlogToWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      height: 70.h,
      decoration: BoxDecoration(
        color: kRedColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 1)
      ),
      child: Center(
        child: Column(
          children: [
            Text('blog',style: TextStyle(
              color: kwhiteColor,
              fontSize: 20.sp,
              fontWeight: FontWeight.w700
            ),),
            Text('TO',style: TextStyle(
              color: kwhiteColor,
              fontSize: 23.sp,
              fontWeight: FontWeight.w700
            ))
          ],
        ),
      ),
    );
  }
}