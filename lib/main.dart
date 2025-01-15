import 'package:bookly/Features/home/data/data_sources/home_local_data_source.dart';
import 'package:bookly/Features/home/data/data_sources/home_remote_data_source.dart';
import 'package:bookly/Features/home/data/repos/home_repo_impl.dart';
import 'package:bookly/Features/home/domain/entities/book_entity.dart';
import 'package:bookly/Features/home/domain/use_cases/fetch_best_seller_books_use_case.dart';
import 'package:bookly/Features/home/domain/use_cases/fetch_featured_books_use_case.dart';
import 'package:bookly/Features/home/presentation/manager/cubit/cubit/newest_books_cubit.dart';
import 'package:bookly/Features/home/presentation/manager/cubit/fetch_featured_books_cubit.dart';
import 'package:bookly/constants.dart';
import 'package:bookly/core/Service%20Locator/service_locator.dart';
import 'package:bookly/core/utils/api_service.dart';
import 'package:bookly/core/utils/app_router.dart';
import 'package:bookly/core/utils/bloc_observer.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import 'Features/Splash/presentation/views/splash_view.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(BookEntityAdapter());
  setupServiceLocator();
  await Hive.openBox(kFeaturedBox);
  await Hive.openBox(kNewesrBox);
  Bloc.observer = BlocObserverr();
  runApp(const Bookly());
}


class Bookly extends StatelessWidget {
  const Bookly({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) {
          return FetchFeaturedBooksCubit(
              FetchFeaturedBooksUseCase(homeRepo: getIt.get<HomeRepoImpl>()));
        }),
        BlocProvider(create: (context) {
          return NewestBooksCubit(
              FetchBestSellerBooksUseCase(homeRepo: getIt.get<HomeRepoImpl>()));
        }),
      ],
      child: MaterialApp.router(
        routerConfig: AppRouter.router,
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: kPrimaryColor,
          textTheme:
              GoogleFonts.montserratTextTheme(ThemeData.dark().textTheme),
        ),
      ),
    );
  }
}
