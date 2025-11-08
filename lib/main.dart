import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/Controllers/InterfacePageController.dart';
import 'package:news_app/HomePage.dart';

void main() {

   WidgetsFlutterBinding.ensureInitialized();
   Get.put(InterfacePageController(), permanent: true);
  
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    ),
  );

}
