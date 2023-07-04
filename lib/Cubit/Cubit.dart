import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp_flutter/CacheHelper.dart';
import 'package:newsapp_flutter/Cubit/States.dart';
import 'package:newsapp_flutter/modules/Business/Business.dart';
import 'package:newsapp_flutter/modules/Science/Science.dart';
import 'package:newsapp_flutter/modules/Setting/Settings.dart';
import 'package:newsapp_flutter/modules/Sports/Sports.dart';

import '../constants.dart';
import '../doi_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsINitialStates());
  static NewsCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;

  void changeAppTheme({bool? frontMode}) {
    if (frontMode != null) {
      isDark = frontMode;
      emit(AppChangeMode());
    } else {
      isDark = !isDark;
      CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
        emit(AppChangeMode());
      });
    }
  }

  List<BottomNavigationBarItem> buttomItems = [
    const BottomNavigationBarItem(
        icon: Icon(Icons.business), label: "Business"),
    const BottomNavigationBarItem(icon: Icon(Icons.sports), label: "Sports"),
    const BottomNavigationBarItem(icon: Icon(Icons.science), label: "Science"),
    const BottomNavigationBarItem(
        icon: Icon(Icons.settings), label: "Settings"),
  ];

  List<Widget> screens = [
    const BusinessScreen(),
    const SportScreen(),
    const ScienceScreen(),
    const SettingsScreen()
  ];

  void changeButtomNavBar(int index) {
    currentIndex = index;

    if (index == 1) getSports();
    if (index == 2) getScience();

    emit(NewsButtomNavBarStates());
  }

//https://newsapi.org/v2/top-headlines?country=de&category=business&apiKey=1a55a0211d16428f82e5062ce6e649c9
  List<dynamic> business = [];
  void getBusiness() {
    emit(NewsGetBusinessLoadingStates());
    if (business.length == 0) {
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'de',
        'category': 'business',
        'apiKey': '1a55a0211d16428f82e5062ce6e649c9'
      }).then((value) {
        //     print(value.data['articles'][0]['author']);
        business = value.data['articles'];
        print(business[0]['author']);
        emit(NewsGetBusinessSuccessStates());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetBusinessErrorStates(error.toString()));
      });
    } else {
      emit(NewsGetBusinessSuccessStates());
    }
  }

  List<dynamic> sports = [];
  void getSports() {
    emit(NewsGetSportsLoadingStates());
    if (sports.length == 0) {
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'us',
        'category': 'sports',
        'apiKey': '1a55a0211d16428f82e5062ce6e649c9'
      }).then((value) {
        //     print(value.data['articles'][0]['author']);
        sports = value.data['articles'];
        print(sports[0]['author']);
        emit(NewsGetSportsSuccessStates());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetSportsErrorStates(error.toString()));
      });
    } else {
      emit(NewsGetSportsSuccessStates());
    }
  }

  List<dynamic> Science = [];
  void getScience() {
    emit(NewsGetScienceLoadingStates());
    if (Science.length == 0) {
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'science',
        'apiKey': '1a55a0211d16428f82e5062ce6e649c9'
      }).then((value) {
        //     print(value.data['articles'][0]['author']);

        Science = value.data['articles'];
        print(Science[0]['author']);
        emit(NewsGetScienceSuccessStates());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetScienceErrorStates(error.toString()));
      });
    } else {
      emit(NewsGetScienceSuccessStates());
    }
  }

  List<dynamic> Search = [];
  void getSearch(String value) {
    emit(NewsGetSearchLoadingStates());
    Search = [];
    DioHelper.getData(url: 'v2/everything', query: {
      'q': '$value',
      'apiKey': '1a55a0211d16428f82e5062ce6e649c9'
    }).then((value) {
      //     print(value.data['articles'][0]['author']);
      Search = value.data['articles'];
      print(Search[0]['author']);
      emit(NewsGetSearchSuccessStates());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetSearchErrorStates(error.toString()));
    });
  }
}
