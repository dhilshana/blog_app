import 'dart:io';

import 'package:blogapp/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class ImageWidget extends StatefulWidget {
  ImageWidget({super.key,required this.getImage});

  Function(File) getImage;
  

  @override
  State<ImageWidget> createState() => _ImageWidgetState();
}

class _ImageWidgetState extends State<ImageWidget> {
  File? image;
  final ImagePicker _picker = ImagePicker(); // Initialize the ImagePicker

  // Function to pick an image from the gallery
  void  _pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        image =
            File(pickedFile.path); 

            widget.getImage(image!);
            // Convert the picked file to a File object
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    
    return GestureDetector(
      onTap: () {

        _pickImage();
      },
      child: Container(
        width: double.infinity,
        height: 250.h,
        decoration: BoxDecoration(
          color: kGreyColor,
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: image != null
            ? Image(
                image: FileImage(image!),
                fit: BoxFit.fill,
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Upload Image'),
                  Icon(
                    Icons.file_upload_outlined,
                    size: 30,
                  )
                ],
              ),
      ),
    );
  }
}
