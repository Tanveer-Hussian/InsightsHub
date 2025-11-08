import 'package:get/get.dart';
import 'package:news_app/views/AllNewsPage.dart';
import 'package:news_app/views/BussinessNewsPage.dart';
import 'package:news_app/views/SportsNewsPage.dart';
import 'package:news_app/views/TechNewsPage.dart';

class NavController extends GetxController{
   
    RxInt index = 0.obs;
  
    final pages = [
       AllNewsPage(),
       BusinessNewsPage(),
       TechNewsPage(),
       SportsNewsPage(),
    ]; 

}
