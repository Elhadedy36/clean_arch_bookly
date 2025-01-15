import 'package:bloc/bloc.dart';
import 'package:bookly/Features/home/domain/entities/book_entity.dart';
import 'package:bookly/Features/home/domain/use_cases/fetch_featured_books_use_case.dart';
import 'package:meta/meta.dart';

part 'fetch_featured_books_state.dart';

class FetchFeaturedBooksCubit extends Cubit<FetchFeaturedBooksState> {
  FetchFeaturedBooksCubit(this.fetchFeaturedBooksUseCase)
      : super(FetchFeaturedBooksInitial());
  final FetchFeaturedBooksUseCase fetchFeaturedBooksUseCase;

  Future<void> fetchFeaturedBooks() async {
    emit(FetchFeaturedBooksLoading());
    var result =
        await fetchFeaturedBooksUseCase.call(); //return either left or right
    result.fold((failure) {
      emit(FetchFeaturedBooksFailure(failure.message));
    }, (books) {
      emit(FetchFeaturedBooksSuccess(books));
    });
  }
}
