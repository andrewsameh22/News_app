// ignore_for_file: prefer_const_constructors

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_application/cubit/states.dart';
import 'package:news_application/dio_helper.dart';
import 'package:news_application/modules/business/business_screen.dart';
import 'package:news_application/modules/science/science_screen.dart';
import 'package:news_application/modules/sports/sports_screen.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomItems = [
    // ignore: prefer_const_constructors
    BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: 'Business',
    ),
    // ignore: prefer_const_constructors
    BottomNavigationBarItem(
      // ignore: prefer_const_constructors
      icon: Icon(Icons.sports),
      label: 'Sports',
    ),
    // ignore: prefer_const_constructors, prefer_const_constructors
    BottomNavigationBarItem(
      // ignore: prefer_const_constructors
      icon: Icon(Icons.science),
      label: 'Science',
    ),
  ];

  List<Widget> screens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;
    // if (index == 0) getBusiness();
    // if (index == 1) getSports();
    // if (index == 2) getScience();
    emit(NewsBottomNavState());
  }

  List<dynamic> business = [];

  void getBusiness() async {
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'eg',
        'category': 'business',
        // 'apiKey': '1914aabca2f049488600e58dc99a93b2',
        'apiKey': '768cebfc65e247d99938836243b5d4b2',
      },
    ).then((value) {
      business = value.data['articles'];
      emit(NewsGetBusinessSuccessState());
      print(business[0]['title']);
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }

  List<dynamic> sports = [];

  void getSports() async {
    emit(NewsGetBusinessLoadingState());

    if (sports.length == 0) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'sports',
          // 'apiKey': '1914aabca2f049488600e58dc99a93b2',
          'apiKey': '768cebfc65e247d99938836243b5d4b2',
        },
      ).then((value) {
        sports = value.data['articles'];
        emit(NewsGetSportsSuccessState());
        print(sports[0]['title']);
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetSportsErrorState(error.toString()));
      });
    } else {
      emit(NewsGetSportsSuccessState());
    }
  }

  List<dynamic> science = [];

  void getScience() async {
    emit(NewsGetScienceLoadingState());

    if (science.length == 0) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'science',
          // 'apiKey': '1914aabca2f049488600e58dc99a93b2',
          'apiKey': '768cebfc65e247d99938836243b5d4b2',
        },
      ).then((value) {
        science = value.data['articles'];
        emit(NewsGetScienceSuccessState());
        print(science[0]['title']);
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetScienceErrorState(error.toString()));
      });
    } else {
      emit(NewsGetScienceSuccessState());
    }
  }

  List<dynamic> search = [];

  void getSearch(String value) async {
    emit(NewsGetSearchLoadingState());
    search = [];

    DioHelper.getData(
      url: 'v2/everything',
      query: {
        'q': '$value',
        // 'apiKey': '1914aabca2f049488600e58dc99a93b2',
        'apiKey': '768cebfc65e247d99938836243b5d4b2',
      },
    ).then((value) {
      search = value.data['articles'];
      emit(NewsGetSearchSuccessState());
      print(search[0]['title']);
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetSearchErrorState(error.toString()));
    });
  }
}
