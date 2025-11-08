import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/Controllers/InterfacePageController.dart';

class NewsService {

    final InterfacePageController controller;

    NewsService({required this.controller});


    Future<List<dynamic>> getTopHeadlines (String s)async{
      
        final response = await http.get(
            Uri.parse('https://newsapi.org/v2/top-headlines?sources=${s}&apiKey=yourApiKey')
         ).timeout(const Duration(seconds:30));
     
        try{         
          if(response.statusCode==200){ 
              var data = jsonDecode(response.body.toString());  

              List<dynamic> articles = data['articles']; 
              articles.sort((a, b) => DateTime.parse(b['publishedAt'])
                            .compareTo(DateTime.parse(a['publishedAt']))); 
              return articles; 
           }else{
              throw Exception('failed to load headlines');
           }      
        }catch(e){
           throw Exception(e.toString());
        } 
    }


    Future<List<dynamic>> getGeneralNews()async{

        final response = await http.get(
             Uri.parse('https://newsapi.org/v2/top-headlines?category=general&apiKey=yourApiKey')
         ).timeout(const Duration(seconds:30));
       
      try{ 
       if(response.statusCode==200){
           var data = jsonDecode(response.body.toString());

           List<dynamic> articles = data['articles'];
           articles.sort((a,b)=>DateTime.parse(b['publishedAt'])
                     .compareTo(DateTime.parse(a['publishedAt'])));

           return articles;
        }else{
          throw Exception('Error in loading articles');
        }
      }catch(e){
         throw Exception(e.toString());
      } 
   }

    
  Future<List<dynamic>> getBusinessNews() async {
    final response = await http
        .get(Uri.parse(
            'https://newsapi.org/v2/top-headlines?category=business&apiKey=yourApiKey'))
        .timeout(const Duration(seconds: 30));

    try {
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        List<dynamic> articles = data['articles'];

        // Sort latest first
        articles.sort((a, b) => DateTime.parse(b['publishedAt'])
            .compareTo(DateTime.parse(a['publishedAt'])));

        // Remove duplicate titles
        final seenTitles = <String>{};
        articles = articles
            .where((article) => seenTitles.add(article['title'] ?? ''))
            .toList();

        return articles;
      } else {
        throw Exception('Error loading business articles');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }


   Future<List<dynamic>> getSportsNews() async {
    final response = await http
        .get(Uri.parse(
            'https://newsapi.org/v2/top-headlines?category=sports&apiKey=yourApiKey'))
        .timeout(const Duration(seconds: 30));

    try {
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        List<dynamic> articles = data['articles'];

        // Sort latest first
        articles.sort((a, b) => DateTime.parse(b['publishedAt'])
            .compareTo(DateTime.parse(a['publishedAt'])));

        // Remove duplicate titles
        final seenTitles = <String>{};
        articles = articles
            .where((article) => seenTitles.add(article['title'] ?? ''))
            .toList();

        return articles;
      } else {
        throw Exception('Error loading business articles');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

 
   Future<List<dynamic>> getTechNews() async {
    final response = await http
        .get(Uri.parse(
            'https://newsapi.org/v2/top-headlines?category=technology&apiKey=yourApiKey'))
        .timeout(const Duration(seconds: 30));

    try {
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        List<dynamic> articles = data['articles'];

        // Sort latest first
        articles.sort((a, b) => DateTime.parse(b['publishedAt'])
            .compareTo(DateTime.parse(a['publishedAt'])));

        // Remove duplicate titles
        final seenTitles = <String>{};
        articles = articles
            .where((article) => seenTitles.add(article['title'] ?? ''))
            .toList();

        return articles;
      } else {
        throw Exception('Error loading business articles');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
 

 
 }
   
