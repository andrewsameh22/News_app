abstract class NewsStates {}

class NewsInitialState extends NewsStates {}

class NewsGetBusinessLoadingState extends NewsStates {}

class NewsBottomNavState extends NewsStates {}

class NewsGetBusinessSuccessState extends NewsStates {}

class NewsGetBusinessErrorState extends NewsStates {
  NewsGetBusinessErrorState(this.error);
  final String error;
}

class NewsGetSportsLoadingState extends NewsStates {}

class NewsGetSportsSuccessState extends NewsStates {}

class NewsGetSportsErrorState extends NewsStates {
  NewsGetSportsErrorState(this.error);
  final String error;
}

class NewsGetScienceLoadingState extends NewsStates {}

class NewsGetScienceSuccessState extends NewsStates {}

class NewsGetScienceErrorState extends NewsStates {
  NewsGetScienceErrorState(this.error);
  final String error;
}

class NewsGetSearchLoadingState extends NewsStates {}

class NewsGetSearchSuccessState extends NewsStates {}

class NewsGetSearchErrorState extends NewsStates {
  NewsGetSearchErrorState(this.error);
  final String error;
}
