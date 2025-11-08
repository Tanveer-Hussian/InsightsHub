import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewsDetails extends StatelessWidget{

  final id;
  final title;
  final content;
  final publishedAt;
  final imageUrl;

    const NewsDetails({
         required this.id, required this.title, required this.content, 
         required this.publishedAt, required this.imageUrl
      });

  @override
  Widget build(BuildContext context) {

       final formattedDate = DateFormat('MMM d, yyyy • hh:mm a').format(DateTime.parse(publishedAt));
    
     return Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 280,
              backgroundColor: Colors.transparent,
              elevation: 0,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Hero(
                   tag: id,
                   child: Stack(
                     fit: StackFit.expand,
                     children: [
                       Image.network(
                          imageUrl, 
                          fit: BoxFit.cover, 
                          errorBuilder: (context, _,_)=> Container(color: Colors.grey.shade300, child: Icon(Icons.broken_image, size:60),),
                        ),
                       Container(
                         decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.transparent, Colors.black54],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                           ),
                         ),
                       ),  
                     ],
                   ) 
                 ),
              ),
            ),

 
            SliverToBoxAdapter(
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal:18, vertical:16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Text(formattedDate, style: TextStyle(color:Colors.grey.shade600, fontSize:13),),
                        const SizedBox(height: 10),
                        Text(title,style: TextStyle(fontSize:22, fontWeight:FontWeight.bold, height:1.3)),
                        const SizedBox(height: 16),
                         Divider(color: Colors.grey.shade300, thickness: 1),
                        Text(
                            content.isNotEmpty ?  content.replaceAll(RegExp(r'\[.*\]'), '') : 'Full article not available. Please check the source for more details.',
                            style: const TextStyle(fontSize: 16, height: 1.6,color: Colors.black87),
                        ),
                  
                        const SizedBox(height: 20),
                        Center(
                          child: ElevatedButton.icon(
                             onPressed: (){}, 
                             icon: const Icon(Icons.open_in_new, size: 18),
                             label: const Text('Read Full Article'),
                             style: ElevatedButton.styleFrom(
                               backgroundColor: Colors.blueAccent,
                               foregroundColor: Colors.white,
                               padding: const EdgeInsets.symmetric(horizontal:20, vertical:12),
                               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))
                             ),                            
                          ),
                        ),

                        const SizedBox(height:30), 
                    ],
                  ),
               ),
            )


          ],
        ),
     );
  }
}
