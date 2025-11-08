import 'package:get/get.dart';
import 'package:news_app/api/news_service.dart';

class InterfacePageController extends GetxController {
 
   RxInt carousalIndex = 0.obs;
   RxString source = 'al-jazeera-english'.obs;

  var topHeadlines = <Map<String, dynamic>>[].obs;
  var generalNews = <Map<String, dynamic>>[].obs;
  var bussinessNews = <Map<String,dynamic>>[].obs;
  var isLoading = true.obs;

  late final NewsService newsService;

  InterfacePageController() {
    newsService = NewsService(controller: this);
  }

  @override
  void onInit() {
    super.onInit();
    fetchNews();
  }

  void updateIndex(int indexValue) {
    carousalIndex.value = indexValue;
  }

  void updateSource(String newSource) {
    source.value = newSource;
  }

  Future<void> fetchNews() async {
    try {
      isLoading.value = true;
      generalNews.clear();
      topHeadlines.clear();

      List<String> sources = [
        'bbc-news',
        'al-jazeera-english',
        'the-washington-post',
        'bloomberg',
      ];

      // Collect all articles from all sources in parallel
     final allResponses = await Future.wait(
      sources.map((src) async {
        try {
          return await newsService.getTopHeadlines(src);
        } catch (e) {
          print("Failed to fetch from $src: $e");
          return [];
        }
      }),
    );


      // Combine all results into a single list
      final allArticles = allResponses.expand((list) => list).toList();

      
     // Remove duplicates based on the article title
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

      generalNews.assignAll(uniqueArticles);
      topHeadlines.assignAll(uniqueArticles.take(5).toList());

    } catch (e) {
      throw Exception("Error fetching news: $e");
    } finally {
      isLoading(false);
    }
  }



 }

