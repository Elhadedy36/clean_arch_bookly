import 'package:bloc/bloc.dart';
import 'package:bookly/Features/home/domain/entities/book_entity.dart';
import 'package:bookly/Features/home/domain/use_cases/fetch_best_seller_books_use_case.dart';
import 'package:meta/meta.dart';

part 'newest_books_state.dart';

class NewestBooksCubit extends Cubit<NewestBooksState> {
  NewestBooksCubit(this.fetchNewestBooksUseCase) : super(NewestBooksInitial());
final FetchBestSellerBooksUseCase fetchNewestBooksUseCase;
  Future<void> fetchNewestBooks() async 
  {
emit(NewestBooksLoading());
var result =
      await fetchNewestBooksUseCase.call(); //return either left or right
  result.fold((failure) {
    emit(NewestBooksFailure(failure.message));
  }, (books) {
    emit(NewestBooksSuccess(books));
  });
  }
}
