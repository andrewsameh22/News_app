// ignore_for_file: prefer_const_constructors, duplicate_ignore, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_application/bloc_observer.dart';
import 'package:news_application/cubit/cubit.dart';
import 'package:news_application/cubit/test_cubit.dart';
import 'package:news_application/cubit/test_states.dart';
import 'package:news_application/dio_helper.dart';
import 'package:news_application/home_layout.dart';
import 'package:news_application/network/local/cache_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //To Ensure that await functions go first before running my app
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  bool? isDark = CacheHelper.getData(key: 'isDark');

  runApp(NewsApp(isDark!));
}

class NewsApp extends StatelessWidget {
  final bool isDark;
  NewsApp(this.isDark);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NewsCubit()
            ..getBusiness()
            ..getSports()
            ..getScience(),
        ),
        BlocProvider(
          create: (context) => AppCubit()..changeAppMode(fromShared: isDark),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              scaffoldBackgroundColor: Colors.white,
              // brightness: Brightness.light,
              primarySwatch: Colors.deepOrange,
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: Colors.deepOrange,
              ),
              // ignore: prefer_const_constructors
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.deepOrange,
                unselectedItemColor: Colors.grey,
                elevation: 20.0,
                backgroundColor: Colors.white,
              ),
              appBarTheme: AppBarTheme(
                backwardsCompatibility: false,
                titleSpacing: 20.0,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  statusBarIconBrightness: Brightness.dark,
                ),
                backgroundColor: Colors.white,
                elevation: 0.0,
                iconTheme: IconThemeData(
                  color: Colors.deepOrange,
                ),
                titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              textTheme: TextTheme(
                bodyText1: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
            darkTheme: ThemeData(

              scaffoldBackgroundColor: Color(0xff333739),
              primarySwatch: Colors.deepOrange,
              fixTextFieldOutlineLabel:true ,
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: Colors.deepOrange,
              ),
              // ignore: prefer_const_constructors
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.deepOrange,
                unselectedItemColor: Colors.grey,
                elevation: 20.0,
                backgroundColor: Color(0xff333739),
              ),
              appBarTheme: AppBarTheme(
                backwardsCompatibility: false,
                titleSpacing: 20.0,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Color(0xff333739),
                  statusBarIconBrightness: Brightness.light,
                ),
                backgroundColor: Color(0xff333739),
                elevation: 0.0,
                iconTheme: IconThemeData(
                  color: Colors.deepOrange,
                ),
                titleTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              textTheme: TextTheme(
                bodyText1: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
            themeMode:
                AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home: HomeLayout(),
          );
        },
      ),
    );
  }
}
