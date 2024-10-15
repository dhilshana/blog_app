import 'package:blogapp/screens/registerScreen.dart';
import 'package:blogapp/services/authCheck.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize:const Size(393, 806),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        
        debugShowCheckedModeBanner: false,
        home:const AuthCheck(),
        theme: ThemeData(
        
            fontFamily: 'Roboto',
           
          ),
      ),
    );
  }
}
