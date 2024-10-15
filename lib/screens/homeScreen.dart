import 'package:blogapp/screens/singleBlogItemScreen.dart';
import 'package:blogapp/services/apiServices.dart';
import 'package:blogapp/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
          child: Column(
            children:[
              Row(children: [
                Container(
                  width: 70.w,
                  height: 40.h,
                  child: IconButton(onPressed: (){}, icon: Icon(Icons.menu,color: kBlackColor,)),
                  decoration: BoxDecoration(
                    color: kGreyColor,
                    borderRadius: BorderRadius.circular(10.r)
                    
          
                  ),
                ),
                Spacer(),
                CircleAvatar(
                  backgroundColor: kGreyColor,
                  radius: 25.r,
                )
              ],),
              kHeightInAddPage,
              FutureBuilder(
                future: ApiServices().getBlog(),
                builder: (context, snapshot) {
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return Center(child: CupertinoActivityIndicator(color: kBlackColor,),);
                  }
                  else if(snapshot.hasError){
                  
                    return Center(child: Text(snapshot.error.toString()),);
                  }
                  else{
                  final data = snapshot.data;
                  final dataList = data['data'];
                  return Expanded(
                  child: ListView.builder(
                    itemCount: dataList.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => SingleBlogScreen(
                                title: dataList[index]['title'],
                                description: dataList[index]['content'],
                                image: dataList[index]['image'],
                                )));
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(dataList[index]['title'],style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18
                                  ),),
                                  Text(dataList[index]['content'],style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18
                                  ),),
                                 
                                  
                                ],
                              ),
                              decoration: BoxDecoration(
                                color: kGreyColor,
                                borderRadius: BorderRadius.circular(10)
                              ),
                            ),
                          ),
                          kHeightBWTextField
                        ],
                      );
                      
                    },
                  ),
                );
                  }
                },
  
              )
            ]
          ),
        ),
      ),
    );
  }
}