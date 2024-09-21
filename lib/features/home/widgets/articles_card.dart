// import 'package:flutter/material.dart';

// class Card extends StatelessWidget {
//   double height;
//   double width;
//   dynamic content;
//   // Заглушка для данных
//   Card({super.key,  
//     required this.height,
//     required this.width,
//     required this.content,
    
//   });

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: width,
//       height: height, // Высота ListView
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: content.length,
//         itemBuilder: (context, index) {
//           final article = content[index];
//           return Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: GestureDetector(
//               onTap: () {
//                 //TODO: Сделать переход на экран статьи
//               },
//               child: Card(
//                 elevation: 4,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 height: null,
//                 width: null,
//                 child: Stack(
//                   children: [
//                     // Фотография, полностью покрывающая контейнер
//                     ClipRRect(
//                       borderRadius: BorderRadius.circular(20),
//                       child: Image.asset(
//                         article['photoUrl']!,
//                         width: 260,
//                         height:
//                             240, // Устанавливаем высоту, чтобы изображение покрывало всю карточку
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                     // Текст поверх фотографии
//                     Container(
//                       width: width,//260,
//                       height: height,//240,
//                       decoration: BoxDecoration(
//                         color: Colors.black54,
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsetsDirectional.symmetric(
//                             horizontal: 12, vertical: 24),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               article['date']!,
//                               style: Theme.of(context)
//                                   .textTheme
//                                   .bodySmall!
//                                   .copyWith(
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.w300,
//                                       fontSize: 16),
//                             ),
//                             Text(
//                               article['title']!,
//                               style: Theme.of(context)
//                                   .textTheme
//                                   .bodyLarge!
//                                   .copyWith(color: Colors.white, fontSize: 16),
//                               overflow: TextOverflow.fade,
//                             ),
//                             const SizedBox(height: 2),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
