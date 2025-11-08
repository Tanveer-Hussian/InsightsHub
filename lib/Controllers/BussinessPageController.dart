import 'package:get/get.dart';
import 'package:news_app/Controllers/InterfacePageController.dart';
import 'package:news_app/api/news_service.dart';

class BussinessPageController extends GetxController {
  
   final newsService = NewsService(controller: Get.find<InterfacePageController>());

    var businessNewsList = <Map<String,dynamic>>[].obs;
    var isLoading = true.obs;
  

  @override
  void onInit() {
    super.onInit();
    fetchBusinessNews();
  }

 Future<void> fetchBusinessNews() async {
  try {
    isLoading.value = true;
    businessNewsList.clear();

    List<String> sources = [
      'bloomberg',
      'business-insider',
      'bbc-news',
      'financial-times',
      'fortune',
    ];

    final allResponses = await Future.wait(
      sources.map((src) async {
        try {
          return await newsService.getTopHeadlines(src);
        } catch (e) {
          print(' Failed to load from $src: $e');
          return [];
        }
      }),
    );

    final allArticles = allResponses.expand((list) => list).toList();

    final seenTitles = <String>{};
    final uniqueArticles = <Map<String, dynamic>>[];

    for (var article in allArticles) {
      final title = article['title'] ?? '';
      if (title.isNotEmpty && !seenTitles.contains(title)) {
        seenTitles.add(title);
        uniqueArticles.add(Map<String, dynamic>.from(article));
      }
    }

    uniqueArticles.shuffle();
    businessNewsList.assignAll(uniqueArticles);
  } catch (e) {
    throw Exception("Error fetching business news: $e");
  } finally {
    isLoading(false);
  }
 }


 }
