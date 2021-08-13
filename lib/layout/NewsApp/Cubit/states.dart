abstract class NewsStates {}

class NewsInitialState extends NewsStates {}

class NewsNavBarChange extends NewsStates {}

class NewsGetBusinessLoadingState extends NewsStates {}

class NewsGetBusinessSucsessState extends NewsStates {}

class NewsGetBusinessErrorState extends NewsStates {
  final String error;

  NewsGetBusinessErrorState(this.error);
}

class NewsGetSportsLoadingState extends NewsStates {}

class NewsGetSportsSucsessState extends NewsStates {}

class NewsGetSportsErrorState extends NewsStates {
  final String error;

  NewsGetSportsErrorState(this.error);
}

class NewsGetScienceLoadingState extends NewsStates {}

class NewsGetScienceSucsessState extends NewsStates {}

class NewsGetScienceErrorState extends NewsStates {
  final String error;

  NewsGetScienceErrorState(this.error);
}

class NewsGetSearchLoadingState extends NewsStates {}

class NewsGetSearchSucsessState extends NewsStates {}

class NewsGetSearchErrorState extends NewsStates {
  final String error;

  NewsGetSearchErrorState(this.error);
}
