abstract class NewsStates {}

class NewsInitialState extends NewsStates {}

class NewsBottomNavState extends NewsStates {}

// Business

class NewsBusinessLoadingState extends NewsStates {}

class NewsBusinessSuccessState extends NewsStates {}

class NewsBusinessErrorState extends NewsStates {
  late final String error;

  NewsBusinessErrorState(this.error);
}

// Sports

class NewsSportsLoadingState extends NewsStates {}

class NewsSportsSuccessState extends NewsStates {}

class NewsSportsErrorState extends NewsStates {
  late final String error;

  NewsSportsErrorState(this.error);
}

// Science

class NewsScienceLoadingState extends NewsStates {}

class NewsScienceSuccessState extends NewsStates {}

class NewsScienceErrorState extends NewsStates {
  late final String error;

  NewsScienceErrorState(this.error);
}

// Color Mode

class NewsChangeColorModeStates extends NewsStates {}

// Search

class NewsSearchLoadingState extends NewsStates {}

class NewsSearchSuccessState extends NewsStates {}

class NewsSearchErrorState extends NewsStates {
  late final String error;

  NewsSearchErrorState(this.error);
}
