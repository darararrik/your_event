import 'package:flutter/material.dart';
import 'package:yourevent/features/home/data/models/models.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({
    super.key,
    required this.article,
    required this.width,
    required this.height,
  });
  final double width;
  final double height;
  final ArticleModel article;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //TODO Сделать переход на статью
      },
      child: Stack(
        children: [
          // Фотография, полностью покрывающая контейнер
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              article.photoURL,
              width: width,
              height:
                  height, // Устанавливаем высоту, чтобы изображение покрывало всю карточку
              fit: BoxFit.cover,
            ),
          ),
          // Текст поверх фотографии
          Container(
            width: width, //260,
            height: height, //240,
            decoration: BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsetsDirectional.symmetric(
                  horizontal: 12, vertical: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.time.toString(),
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                        fontSize: 16),
                  ),
                  Text(
                    article.title,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: Colors.white, fontSize: 16),
                    overflow: TextOverflow.fade,
                  ),
                  const SizedBox(height: 2),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
