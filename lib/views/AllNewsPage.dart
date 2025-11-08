import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/Controllers/InterfacePageController.dart';
import 'package:news_app/views/NewsDetails.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:shimmer/shimmer.dart';
import 'package:intl/intl.dart';
import 'package:news_app/widgets/CarousalWidget.dart';

class AllNewsPage extends GetView<InterfacePageController>{
 
  @override
  Widget build(BuildContext context) {
     
     final getHelper = controller;
     final screenHeight = MediaQuery.of(context).size.height;
     final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      
      extendBody: true,
  
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal:12, vertical:10),
          child: Column(
            children: [
        
            // --- CarousalSlider Section ---
        
               Obx((){
              
                    if(getHelper.topHeadlines.isEmpty) {
                       return Text('No news available');
                    }

                    if(getHelper.isLoading.value) {
                        return SizedBox(
                          height: screenHeight*0.25,
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 4,
                              itemBuilder: (context,index){
                                return Padding(
                                  padding: const EdgeInsets.only(right: 5),
                                  child: Container(
                                    width: screenWidth*0.60,
                                    height: screenHeight*0.1,
                                    decoration: BoxDecoration(color: Colors.grey,borderRadius: BorderRadius.circular(15)),
                                  ),
                                ); 
                            },),
                          ),
                        );
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CarouselSlider.builder(
                          itemCount: getHelper.topHeadlines.length,
                          itemBuilder:(context, index, realIndex){
                              var apiData = getHelper.topHeadlines[index];
                            return CarousalWidget(
                                id: "Headlines$index",
                                title: apiData['title'] ?? "News not found",
                                content: apiData['content'] ?? "Content not avaible",
                                publishedAt: apiData['publishedAt'],
                                imageUrl: apiData['urlToImage']?? 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT_457JA8M9cwE6h95hXWo4V-OXKn-C1vhilw&s'
                              );
                            },
                          options: CarouselOptions(
                            scrollDirection: Axis.horizontal,
                            enlargeCenterPage: true,
                            aspectRatio: 16/9,
                            enableInfiniteScroll: true,
                            autoPlay: true,
                            onPageChanged: (index, reason) {
                                getHelper.updateIndex(index);
                            },
                          ),
                        ),             
                        SizedBox(height:12),
                        Obx(() =>
                            AnimatedSmoothIndicator(
                                activeIndex: getHelper.carousalIndex.value,
                                count: getHelper.topHeadlines.length,
                                effect: const ExpandingDotsEffect(
                                  dotHeight: 8,
                                  dotWidth: 8,
                                  activeDotColor: Colors.deepPurple
                                ),                         
                             ),
                         ),
                      ]);
                }),
        
        
              SizedBox(height: screenHeight*0.04),
        
            // News Articles Section
              Expanded(
                child: Obx((){
        
                      if(getHelper.generalNews.isEmpty){
                          return Center(child: CircularProgressIndicator(color:Colors.deepPurple,));
                       }
                      if(getHelper.isLoading.value){
                          return Shimmer.fromColors(
                             baseColor: Colors.grey[300]!,
                             highlightColor: Colors.grey[100]!,
                             child: ListView.builder(
                               itemCount: 6,
                               itemBuilder:(context,index){
                                 return Padding(
                                   padding: const EdgeInsets.symmetric(vertical: 5),
                                   child: Row(
                                     children: [
                                       Container(
                                         width: screenWidth*0.47,
                                         height: screenHeight*0.17,
                                         decoration: BoxDecoration(
                                            color: Colors.grey,
                                            border: Border.all(color: Colors.black),
                                            borderRadius: BorderRadius.circular(10),
                                          ),                                  
                                        ),
                                        SizedBox(width: screenWidth*0.02),
                                        Column(
                                          children: [
                                             Container(width: screenWidth*0.50,height: screenHeight*0.05,decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.grey,)),
                                             SizedBox(height: 5),
                                             Container(width: screenWidth*0.50,height: screenHeight*0.05,decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.grey,)),
                                             SizedBox(height: 5),
                                             Container(width: screenWidth*0.50,height: screenHeight*0.05,decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.grey,)),
                                          ],
                                        ),
                                     ],
                                   ),
                                 );
                                }
                              ),
                           );
                        }
                      return RefreshIndicator(
                        onRefresh: ()async{ return getHelper.fetchNews();}, 
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemCount: getHelper.generalNews.length,
                          itemBuilder: (context,index){
                           
                             var newsItems = getHelper.generalNews[index];
                             String formattedTime = DateFormat('dd MMM yyyy,  hh:mm a').format(DateTime.parse(newsItems['publishedAt']));                               
                          
                            return Card(
                              elevation:0,
                              margin: const EdgeInsets.symmetric(vertical: 8.0),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                              child:InkWell(
                                   borderRadius: BorderRadius.circular(14),
                                   onTap: (){ Get.to(()=> NewsDetails(
                                          id: 'GeneralNews$index', title: newsItems['title'], content: newsItems['content']??'No content available',
                                          publishedAt: newsItems['publishedAt'], 
                                          imageUrl: newsItems['urlToImage']??'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT_457JA8M9cwE6h95hXWo4V-OXKn-C1vhilw&s',));
                                    },
                                   child: Row(
                                     children: [
                                        ClipRRect(
                                          borderRadius: const BorderRadius.only(topLeft:Radius.circular(14), bottomRight:Radius.circular(14)),
                                          child: Hero(
                                            tag: 'GeneralNews$index',
                                            child: Image.network(
                                                newsItems['urlToImage']
                                                ??'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT_457JA8M9cwE6h95hXWo4V-OXKn-C1vhilw&s',
                                                  width:screenWidth*0.38, height:screenHeight*0.16, fit: BoxFit.cover, 
                                                  errorBuilder: (context,error,stackTrace){return Center(child:Icon(Icons.broken_image));},
                                             ),
                                          ),
                                        ),   
                                
                                    SizedBox(width: screenWidth*0.022),
                              
                                    SizedBox(
                                      width: screenWidth*0.45,
                                   //   height: screenHeight*0.16,
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(newsItems['title'],
                                                style:GoogleFonts.poppins(fontSize:14, fontWeight: FontWeight.w600), maxLines:3,
                                                  overflow:TextOverflow.ellipsis, softWrap:true
                                             ),
                                            const SizedBox(height:6),
                                          
                                            Text(formattedTime, style:GoogleFonts.poppins(color:Colors.grey.shade600, fontSize:12),),
                                            const SizedBox(height:4,),

                                            if(newsItems['source']!=null && newsItems['source']['name']!=null)
                                               Chip(
                                                   label: Text(newsItems['source']['name'], style:GoogleFonts.poppins(fontSize:11, fontWeight:FontWeight.w500, color:Colors.white)),
                                                   backgroundColor: Colors.deepPurpleAccent[100],
                                                   padding: const EdgeInsets.symmetric(horizontal:6, vertical:0),
                                                    shape: RoundedRectangleBorder(
                                                       borderRadius: BorderRadius.circular(8),
                                                     ),
                                                 ),                                          

                                          ],
                                        ),
                                      ),
                                    )
                                                        
                              ],
                          )));
                      
                        }),
                      );
                  }
                ),
            ),
        
        
        ])),
      )
    );
  }
}  
