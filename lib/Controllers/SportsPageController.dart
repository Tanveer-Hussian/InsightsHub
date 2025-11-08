import 'package:get/get.dart';
import 'package:news_app/Controllers/InterfacePageController.dart';
import 'package:news_app/api/news_service.dart';

class SportsPageController extends GetxController {
  final newsService = NewsService(controller: Get.find<InterfacePageController>());

  var sportsNewsList = <Map<String, dynamic>>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchSportsNews();
  }

  Future<void> fetchSportsNews() async {
    try {
      isLoading.value = true;
      sportsNewsList.clear();

      List<String> sources = [
        'bbc-sport',
        'espn',
        'talksport',
      ];

      final allResponses = await Future.wait(
        sources.map((src) async {
          try {
            return await newsService.getTopHeadlines(src);
          } catch (e) {
            print('Failed to load from $src: $e');
            return [];
          }
        }),
      );

      // Combine and filter duplicates
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
      sportsNewsList.assignAll(uniqueArticles);
    } catch (e) {
      print('Error fetching sports news: $e');
    } finally {
      isLoading(false);
    }
  }
}
