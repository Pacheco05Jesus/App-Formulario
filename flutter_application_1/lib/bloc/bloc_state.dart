abstract class BlocState {}

class Initial extends BlocState {}

class LoadingView  extends BlocState {}

class Success extends BlocState {}

class ErrorView extends BlocState {
  final String error;
  ErrorView(this.error);
}
