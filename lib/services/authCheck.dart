import 'package:blogapp/screens/loginScreen.dart';
import 'package:blogapp/screens/rootScreen.dart';
import 'package:blogapp/services/apiServices.dart';
import 'package:blogapp/utils/constants.dart';
import 'package:flutter/cupertino.dart';

class AuthCheck extends StatefulWidget {
  const AuthCheck({super.key});

  @override
  State<AuthCheck> createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ApiServices().getToken(), 
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Center(child: CupertinoActivityIndicator(color: kBlackColor,),);
        }
        else if(snapshot.hasError){
          return Center(child: Text('${snapshot.error} occured'),);
        }
        else if(snapshot.hasData && snapshot.data != null && snapshot.data!.isNotEmpty){
          return const RootScreen();
        }
        else{
          return const LoginScreen();
        }
      },
      );
  }
}