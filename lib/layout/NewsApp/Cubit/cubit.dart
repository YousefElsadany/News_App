import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/NewsApp/Cubit/states.dart';
import 'package:news_app/module/BusinessPage/business.dart';
import 'package:news_app/module/SciencePage/science.dart';
import 'package:news_app/module/SportsPage/sports.dart';
import 'package:news_app/shared/network/remote/DioHelper.dart';


class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());
  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(icon: Icon(Icons.business), label: 'Business'),
    BottomNavigationBarItem(icon: Icon(Icons.sports), label: 'Sports'),
    BottomNavigationBarItem(icon: Icon(Icons.science), label: 'Science'),
  ];

  List<Widget> screens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];

  List<String> appBarTitels = [
    'News App',
    'Sports App',
    'Science App',
  ];

  void changeIndex(index) {
    currentIndex = index;
    /* if (index == 1) {
      getSports();
    }
    if (index == 2) {
      getScience();
    } */
    emit(NewsNavBarChange());
  }

  List<dynamic> business = [];
  //Map<String,dynamic>? addApi=BuildApi.businessNewsData;

  void getBusiness() {
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(url: 'v2/top-headlines', query: {
      'country': 'eg',
      'category': 'business',
      'apiKey': 'f5ebb0d3a2cd44b5be37e58d9d234732',
    }).then((value) {
      //print(value.data['articles'][1]['description']);
      business = value.data['articles'];
      //print(business[2]['description']);
      emit(NewsGetBusinessSucsessState());
    }).catchError((error) {
      print('ERROR******' + error.toString());
      emit(NewsGetBusinessErrorState(error.toString()));
    });
    //addApi = BuildApi.businessNewsData;
    emit(NewsGetBusinessSucsessState());
  }

  List<dynamic> sports = [];

  void getSports() {
    emit(NewsGetSportsLoadingState());
    DioHelper.getData(url: 'v2/top-headlines', query: {
      'country': 'eg',
      'category': 'sports',
      'apiKey': 'f5ebb0d3a2cd44b5be37e58d9d234732',
    }).then((value) {
      //print(value.data['articles'][1]['description']);
      sports = value.data['articles'];
      //print(business[2]['description']);
      emit(NewsGetSportsSucsessState());
    }).catchError((error) {
      print('ERROR******' + error.toString());
      emit(NewsGetSportsErrorState(error.toString()));
    });
  }

  List<dynamic> science = [];

  void getScience() {
    emit(NewsGetScienceLoadingState());
    DioHelper.getData(url: 'v2/top-headlines', query: {
      'country': 'eg',
      'category': 'science',
      'apiKey': 'f5ebb0d3a2cd44b5be37e58d9d234732',
    }).then((value) {
      //print(value.data['articles'][1]['description']);
      science = value.data['articles'];
      //print(business[2]['description']);
      emit(NewsGetScienceSucsessState());
    }).catchError((error) {
      print('ERROR******' + error.toString());
      emit(NewsGetScienceErrorState(error.toString()));
    });
  }

  List<dynamic> search = [];

  void getSearch(String value) {
    emit(NewsGetSearchLoadingState());
    DioHelper.getData(url: 'v2/everything', query: {
      'q': '$value',
      'apiKey': 'f5ebb0d3a2cd44b5be37e58d9d234732',
    }).then((value) {
      //print(value.data['articles'][1]['description']);
      search = value.data['articles'];
      //print(business[2]['description']);
      emit(NewsGetSearchSucsessState());
    }).catchError((error) {
      print('SEARCH ERROR******' + error.toString());
      emit(NewsGetSearchErrorState(error.toString()));
    });
  }
}
