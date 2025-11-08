import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/Controllers/NavController.dart';

class HomePage extends StatelessWidget{

   final controller = Get.put(NavController());

   final List<String> titles = [
     'All News',
     'Bussiness',
     'Tech',
     'Sports'
  ];

  @override
  Widget build(BuildContext context) {

    final themeGradient = const LinearGradient(
      colors: [Color(0xFF4A00E0), Color(0xFF8E2DE2)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );


    return Obx(()=>
      Scaffold(
        extendBody: true,
         appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: themeGradient
              ),
            ),
            title: Text(titles[controller.index.value], style: GoogleFonts.poppins(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w600),), 
            centerTitle: true, 
            // backgroundColor: Colors.green,
          ),

         body: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: controller.pages[controller.index.value],
          ),

         bottomNavigationBar: Padding(
           padding: const EdgeInsets.symmetric(horizontal:20, vertical:12),
           child: ClipRRect(
             borderRadius: BorderRadius.circular(22),
             child: BackdropFilter(
               filter: ImageFilter.blur(sigmaX:8, sigmaY:8),
               child: Container(
                 decoration: BoxDecoration(
                     color: Colors.deepPurple.withOpacity(0.5),
                     borderRadius: BorderRadius.circular(19),
                     border: Border.all(color: Colors.deepPurple.withOpacity(0.6)),
                     boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius:15,
                      offset: const Offset(0,8),
                    ),
                  ],
                 ),
               
                 child: BottomNavigationBar(
                   type: BottomNavigationBarType.fixed,
                   selectedItemColor: Colors.white,
                   unselectedItemColor: Colors.white70,
                   currentIndex: controller.index.value,
                   backgroundColor: Colors.transparent,
                   elevation: 0,
                   items: const [
                     BottomNavigationBarItem(label:'All', icon:Icon(Icons.public, size:26,), backgroundColor: Colors.purple),
                     BottomNavigationBarItem(label:'Bussiness', icon:Icon(Icons.trending_up, size:26)),
                     BottomNavigationBarItem(label:'Tech', icon:Icon(Icons.memory, size:26,)),
                     BottomNavigationBarItem(label: 'Sports', icon:Icon(Icons.sports_soccer, size:26,)),
                   ],
                   onTap: (value){
                     controller.index.value = value;
                   },
                 ),
               ),
             ),
           ),
         ),
      ),
    );
  }
}
