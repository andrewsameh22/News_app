import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_application/cubit/test_states.dart';
import 'package:news_application/network/local/cache_helper.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  bool isDark = false;

  // ThemeMode appMode = ThemeMode.light;

  void changeAppMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(AppChangeModeState());
    } else {
      isDark = !isDark;
      CacheHelper.putData(key: 'isDark', value: isDark)!.then((value) {
        emit(AppChangeModeState());
      });
    }
  }
}
