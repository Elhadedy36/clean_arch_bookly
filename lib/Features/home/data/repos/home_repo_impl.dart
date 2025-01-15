import 'package:bookly/Features/home/data/data_sources/home_local_data_source.dart';
import 'package:bookly/Features/home/data/data_sources/home_remote_data_source.dart';
import 'package:bookly/Features/home/domain/entities/book_entity.dart';
import 'package:bookly/Features/home/domain/repos/home_repo.dart';
import 'package:bookly/core/Errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class HomeRepoImpl extends HomeRepo {
  final HomeRemoteDataSource homeRemoteDataSource;
  final HomeLocalDataSource homeLocalDataSource;

  HomeRepoImpl(
      {required this.homeRemoteDataSource, required this.homeLocalDataSource});

  @override
  Future<Either<Failure, List<BookEntity>>> fetchFeaturedBooks() async {
    try {
      List<BookEntity> books;

      books = await homeLocalDataSource.fetchFeaturedBooks();
      if (books.isNotEmpty) {
        return right(books);
      }

      books = await homeRemoteDataSource.fetchFeaturedBooks();
      return right(books);
    } on Exception catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<BookEntity>>> fetchBestSellerBooks() async {
    try {
      List<BookEntity> books;

      books = await homeLocalDataSource.fetchBestSellerBooks();
      if (books.isNotEmpty) {
        return right(books);
      }

      books = await homeRemoteDataSource.fetchBestSellerBooks();
      return right(books);
    } on Exception catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(message: e.toString()));
    }
  }
}
