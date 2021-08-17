import 'package:bloc/bloc.dart';

class AppThemeCubit extends Cubit<bool> {
  AppThemeCubit() : super(false);

  void toggleTheme() {
    emit(!state);
  }

  void toggleLanguage() {
    emit(!state);
  }
}
