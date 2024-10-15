import 'package:blogapp/screens/registerScreen.dart';
import 'package:blogapp/screens/rootScreen.dart';
import 'package:blogapp/services/apiServices.dart';
import 'package:blogapp/utils/constants.dart';
import 'package:blogapp/widgets/blogToWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
 
  TextEditingController emaailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  String? _errorText;
  bool isObscure = true;

  ApiServices apiServices = ApiServices();

bool validation(){
  
    if(passwordController.text.length < 8){
      _errorText = 'Password must be atleast 8 characters';
      setState(() {
      
    });
      return false;

    } else{
      return true;
    }
    
  
  
}

Future<void> loginUiHandler()async{
  setState(() {
    isLoading = true;
    
  });
  try{
    Map<String,dynamic> data = await apiServices.login(email: emaailController.text, password: passwordController.text);
    setState(() {
      isLoading = false;
    });
    ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(data['message'])));
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => RootScreen()));
  }catch(e){
    print(e);

  }
  finally{
    setState(() {
      isLoading = false;
    });
  }
}

  

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlogToWidget(),
            Text(
              'Hello, \nSign In Now.',
              style: TextStyle(
                  fontSize: 30.sp,
                  fontWeight: FontWeight.w900,
                  color: kBlackColor),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'New User',
                  style: TextStyle(
                    color: kBlackColor,
                    fontSize: 16.sp,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>RegisterScreen()));
                  },
                  child: Container(
                    width: 80.w,
                    height: 35.h,
                    decoration: BoxDecoration(
                        border: Border.all(width: 1.w),
                        borderRadius: BorderRadius.circular(10.r)),
                    child: Center(
                      child: Text(
                        'Login',
                        style: TextStyle(
                            color: kBlackColor,
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 100,),
            
            TextField(
              controller: emaailController,
              decoration: InputDecoration(
                hintText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                      borderSide: BorderSide(color: kBlackColor, width: 1.w,))),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              obscureText: isObscure,
              controller: passwordController,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      isObscure = !isObscure;
                    });
                  },
                  icon: Icon(isObscure?Icons.visibility_off:Icons.visibility)),
                hintText: 'Password',
                errorText: _errorText,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                      borderSide: BorderSide(color: kBlackColor, width: 1.w,))),
            ),
            SizedBox(
              height: 10,
            ),
           
            
            Center(
              child: ElevatedButton(
              
                onPressed: () {
                  bool validated = validation();
                  if(validated){
                    loginUiHandler();
                  }
                 
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(kBlueColor),
                  foregroundColor: WidgetStatePropertyAll(kwhiteColor),
                  shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    
                    ),
                    
                    ),
                  
                ),
                child:
                    isLoading ? CupertinoActivityIndicator(color: kwhiteColor,) : Text('Login'),
              ),
            )
          ],
        ),
      ),
    ));
  }
}