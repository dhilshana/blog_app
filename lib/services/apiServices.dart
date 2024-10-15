import 'dart:convert';
import 'dart:io';

import 'package:blogapp/utils/apiConstants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiServices {
  String signupUrl = '$baseUrl/api/auth/register';
  String loginUrl = '$baseUrl/api/auth/login';
  String addBlogUrl = '$baseUrl/api/blogs/addblog';
  String viewBlogUrl = '$baseUrl/api/blogs/viewblog';

  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    print(token);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
    required String place,
    required String phone,
  }) async {
    try {
      final resposnse = await http.post(Uri.parse(signupUrl), body: {
        'email': email,
        'name': name,
        'password': password,
        'place': place,
        'phone': phone
      });
      if (resposnse.statusCode == 201) {
        print(resposnse.body);
        return jsonDecode(resposnse.body);
      } else {
        return jsonDecode(resposnse.body);
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(Uri.parse(loginUrl),
          body: {'email': email, 'password': password});
      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        final token = data['token'];
        saveToken(token);
        return data;
      } else {
        return jsonDecode(response.body);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> uploadBlog(
      {required File imageFile,
      required String title,
      required String content,
      required String author,
      required String timeStamp}) async {
    try {
      var uri = Uri.parse(addBlogUrl);

      var request = http.MultipartRequest('POST', uri);

      final token = await getToken();
      print('token : $token');

      // Add the authentication token to the headers
      request.headers['Authorization'] = 'Bearer $token';

      // Add the image as a multipart file
      var pic = await http.MultipartFile.fromPath("image", imageFile.path);

      request.files.add(pic);
      request.fields['title'] = title;
      request.fields['content'] = content;
      request.fields['author'] = author;
      request.fields['timestamp'] = timeStamp;

      // Send the request
      var response = await request.send();

      if (response.statusCode == 201) {
      
    
      } else {
        print('Image upload failed: ${response.statusCode}');
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }
  Future<dynamic> getBlog()async{
    try{
      final token = await getToken();
      final uri = Uri.parse(viewBlogUrl);
      final response = await http.get(uri,headers: {
        'Authorization': 'Bearer $token'
      });
      
      print(response.statusCode);

      if(response.statusCode == 200){
        final dataList = jsonDecode(response.body);
        print('------------$dataList----------');
        return dataList;
      }
      else{

        throw Exception();
      }
    }catch(e){
      rethrow;
    }
  }


}
