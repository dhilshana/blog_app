import 'dart:io';

import 'package:blogapp/screens/homeScreen.dart';
import 'package:blogapp/screens/rootScreen.dart';
import 'package:blogapp/services/apiServices.dart';
import 'package:blogapp/utils/constants.dart';
import 'package:blogapp/widgets/imageWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddBlogScreen extends StatefulWidget {
  const AddBlogScreen({super.key});

  @override
  State<AddBlogScreen> createState() => _AddBlogScreenState();
}

class _AddBlogScreenState extends State<AddBlogScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  ApiServices apiServices = ApiServices();
  bool isLoading = false;

  File? selectedImage;

  Future<void> uploadBlog() async {
    setState(() {
      isLoading = true;
    });
    try {
      if(titleController.text.isEmpty){
        ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Title Required')));
          
  
      }
      else if(dateController.text.isEmpty){
        ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Date Required')));
          
      }
      else if(descController.text.isEmpty){
        ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Description Required')));
          
      }
      else if(selectedImage == null){
        ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Image Required')));
          
      }
      else {
        await apiServices.uploadBlog(
            imageFile: selectedImage!,
            title: titleController.text,
            content: descController.text,
            author: 'ffffff',
            timeStamp: dateController.text);
 ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Blog uploaded sudccessfully')));
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => RootScreen() ));

        setState(() {
          isLoading = false;
          
          
        });
      }
      
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

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              kHeightInAddPage,
              ImageWidget(
                getImage: (value) {
                  selectedImage = value;
                },
              ),
              kHeightInAddPage,
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                    labelText: 'Title',
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: kBlackColor, width: 1.5))),
              ),
              kHeightBWTextField,
              TextField(
                controller: dateController,
                decoration: const InputDecoration(
                    labelText: 'Date',
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: kBlackColor, width: 1.5))),
              ),
              kHeightBWTextField,
              TextField(
                controller: descController,
                maxLines: 2,
                decoration: const InputDecoration(
                    labelText: 'Description',
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: kBlackColor, width: 1.5))),
              ),
              kHeightBWTextField,
              ElevatedButton(
                onPressed: () {
                  uploadBlog();
                  
                },
                style: ButtonStyle(
                    backgroundColor: const WidgetStatePropertyAll(kBlueColor),
                    foregroundColor: const WidgetStatePropertyAll(kwhiteColor),
                    shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)))),
                child: isLoading ? const CupertinoActivityIndicator(color: kwhiteColor,) :const Text('Upload Post'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
