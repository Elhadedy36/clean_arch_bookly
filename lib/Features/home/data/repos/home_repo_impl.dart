import 'package:bookly/Features/home/data/data_sources/home_local_data_source.dart';
import 'package:bookly/Features/home/data/data_sources/home_remote_data_source.dart';
import 'package:bookly/Features/home/domain/entities/book_entity.dart';
import 'package:bookly/Features/home/domain/repos/home_repo.dart';
import 'package:bookly/core/Errors/failure.dart';
import 'package:dartz/dartz.dart';

class HomeRepoImpl extends HomeRepo  {
  final HomeRemoteDataSource homeRemoteDataSource;
  final HomeLocalDataSource homeLocalDataSource;

  HomeRepoImpl({required this.homeRemoteDataSource,required this.homeLocalDataSource});

  @override
  Future<Either<Failure, List<BookEntity>>> fetchFeaturedBooks()async {
    try {
      var bookslist = await homeLocalDataSource.fetchFeaturedBooks();
      if (bookslist.isNotEmpty) {

        return right(bookslist);

        }

  var books = await homeRemoteDataSource.fetchFeaturedBooks();
  return right(books);
} on Exception catch (e) {

return left(Failure());

}
  }
  
  @override
  Future<Either<Failure, List<BookEntity>>> fetchBestSellerBooks()async {
  try {
      var bookslist = await homeLocalDataSource.fetchBestSellerBooks();
      if (bookslist.isNotEmpty) {

        return right(bookslist);
        
        }

  var books = await homeRemoteDataSource.fetchBestSellerBooks();
  return right(books);
} on Exception catch (e) {

return left(Failure());

}
  }
}