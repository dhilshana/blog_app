import 'package:blogapp/screens/loginScreen.dart';
import 'package:blogapp/services/apiServices.dart';
import 'package:blogapp/utils/constants.dart';
import 'package:blogapp/widgets/blogToWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emaailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController placeController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  ApiServices apiServices = ApiServices();
  bool isLoading = false;
  String? _errorText;
  bool isObscure = true;

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

  void registerUiHandler() async {
    setState(() {
      isLoading = true;
    });
    try {
      Map<String, dynamic> data = await apiServices.register(
          name: nameController.text,
          email: emaailController.text,
          password: passwordController.text,
          place: placeController.text,
          phone: phoneController.text);
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(data['message'])));
      print(data);
    } catch (e) {
      print(e);
    } finally {
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
              'Hello, \nSignup Now.',
              style: TextStyle(
                  fontSize: 30.sp,
                  fontWeight: FontWeight.w900,
                  color: kBlackColor),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Already have an account',
                  style: TextStyle(
                    color: kBlackColor,
                    fontSize: 16.sp,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
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
            SizedBox(height: 10.h,),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: 'Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                      borderSide: BorderSide(color: kBlackColor, width: 1.w,))),
            ),
            Text('It\'s unique id'),
            SizedBox(
              height: 10,
            ),
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
            TextField(
              controller: placeController,
              decoration: InputDecoration(
                hintText: 'Place',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                      borderSide: BorderSide(color: kBlackColor, width: 1.w,))),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: phoneController,
              decoration: InputDecoration(
                hintText: 'Phone',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                      borderSide: BorderSide(color: kBlackColor, width: 1.w,))),
            ),
            SizedBox(height: 10.h,),
            Center(
              child: ElevatedButton(
              
                onPressed: () {
                  bool validated = validation();
                  if(validated){
                    registerUiHandler();
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
                    isLoading ? CupertinoActivityIndicator(color: kwhiteColor,) : Text('Register'),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
