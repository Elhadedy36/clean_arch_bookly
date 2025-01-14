import 'package:bookly/Features/home/data/models/books_model/books_model.dart';
import 'package:bookly/Features/home/domain/entities/book_entity.dart';
import 'package:bookly/constants.dart';
import 'package:bookly/core/utils/api_service.dart';
import 'package:bookly/core/utils/function/save_books.dart';
import 'package:hive/hive.dart';

abstract class  HomeRemoteDataSource 
{
  
  Future< List<BookEntity>> fetchFeaturedBooks();
  Future< List<BookEntity>> fetchBestSellerBooks();

}

class HomeRemoteDataSourceImpl extends HomeRemoteDataSource 
{
  final ApiService apiService; 

  HomeRemoteDataSourceImpl({required this.apiService});
  
  @override
  Future<List<BookEntity>> fetchFeaturedBooks() async{
   
  var data = await apiService.get(endPoint: 'volumes?Filtering=free-ebooks&q=programming');//data is the whole json of the req
  List<BookEntity> books = getBookList(data);
  saveBooksData(books,kFeaturedBox);
  return books;
  }
  

  
  
  @override
  Future<List<BookEntity>> fetchBestSellerBooks()async {
    var data = await apiService.get(endPoint: 'volumes?Filtering=free-ebooks&Sorting=newest &q=programming');//data is the whole json of the req
  List<BookEntity> books = getBookList(data);
  saveBooksData(books, kNewesrBox);
  return books;
  }
  


  
  List<BookEntity> getBookList(Map<String, dynamic> data) {//keep single responsibility principle
     List<BookEntity> books = [];
    
    for(var item in data['items']){
      books.add(BooksModel.fromJson(item));//i used the model not entity cuz i already send the entitiy data on it in super constructor and the extend i did make the model is the same as entity
    }
    return books;
  }
  
}