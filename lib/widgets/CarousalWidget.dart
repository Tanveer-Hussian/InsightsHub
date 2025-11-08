import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';
import 'package:news_app/views/NewsDetails.dart';

class CarousalWidget extends StatelessWidget {
  final String id;
  final String title;
  final String content;
  final String publishedAt;
  final String imageUrl;

  const CarousalWidget({
    Key? key,
    required this.id,
    required this.title,
    required this.content,
    required this.publishedAt,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: InkWell(
        onTap: () {
          Get.to(() => NewsDetails(
                id: id,
                title: title,
                content: content,
                publishedAt: publishedAt,
                imageUrl: imageUrl,
              ));
        },
        child: Container(
          height: MediaQuery.of(context).size.height * 0.3,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: [
              Expanded(
                flex: 75,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                  child: Hero(
                    tag: id,
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Expanded(
                flex: 25,
                child: ReadMoreText(
                  title,
                  style: const TextStyle(decoration: TextDecoration.underline),
                  lessStyle:
                      const TextStyle(fontWeight: FontWeight.bold),
                  moreStyle: const TextStyle(
                      fontWeight: FontWeight.normal, fontSize: 6),
                  trimLines: 2,
                  trimLength: 70,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
