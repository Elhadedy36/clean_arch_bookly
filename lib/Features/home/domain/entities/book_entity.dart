import 'package:hive/hive.dart';

part 'book_entity.g.dart';

@HiveType(typeId: 0)
class BookEntity {
  @HiveField(0)
  final String image;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String authorName; 
  final int pageCount;
  @HiveField(4)
  final String publishedDate;

  BookEntity(
      {required this.image,
      required this.title,
      required this.authorName,
      required this.pageCount,
      required this.publishedDate});
}
