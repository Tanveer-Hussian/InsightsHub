import 'package:get/get.dart';
import 'package:news_app/Controllers/InterfacePageController.dart';
import 'package:news_app/api/news_service.dart';

class TechPageController extends GetxController {
  final newsService = NewsService(controller: Get.find<InterfacePageController>());

  var techNewsList = <Map<String, dynamic>>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchTechNews();
  }

  Future<void> fetchTechNews() async {
    try {
      isLoading.value = true;
      techNewsList.clear();

      List<String> sources = [
        'techcrunch',
        'the-verge',
        'wired',
        'ars-technica',
        'engadget',
      ];

      // Fetch safely (even if one source fails)
      final allResponses = await Future.wait(
        sources.map((src) async {
          try {
            return await newsService.getTopHeadlines(src);
          } catch (_) {
            return []; // ignore failed source
          }
        }),
      );

      // Combine all fetched results
      final allArticles = allResponses.expand((list) => list).toList();

      // Remove duplicate articles based on title
      final seenTitles = <String>{};
      final uniqueArticles = <Map<String, dynamic>>[];

      for (var article in allArticles) {
        final title = article['title'] ?? '';
        if (title.isNotEmpty && !seenTitles.contains(title)) {
          seenTitles.add(title);
          uniqueArticles.add(Map<String, dynamic>.from(article));
        }
      }

      // Randomize order for variety
      uniqueArticles.shuffle();

      techNewsList.assignAll(uniqueArticles);
    } catch (e) {
      throw Exception("Error fetching technology news: $e");
    } finally {
      isLoading(false);
    }
  }
}
