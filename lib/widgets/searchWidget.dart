import 'package:blogapp/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key});

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: searchController,
      decoration: InputDecoration(
        hintText: 'Search by title',
        prefixIcon: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back)),
        fillColor: kGreyColor,
        filled: true,
        contentPadding: EdgeInsets.all(0),
        border: OutlineInputBorder(
          
          borderRadius: BorderRadius.circular(15.r),
           borderSide: BorderSide.none, // Removes the visible border
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: BorderSide.none, // Removes the visible border when enabled
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: BorderSide.none, // Removes the visible border when focused
        )
      ),
    );
  }
}