import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

class ServicesLocator {
  Future<void> init() async {
    /// Cubit

    /// Use Cases

    /// Repository

    /// DATA SOURCE


    ///todo shared Preferences
    final sharedPreferences = await SharedPreferences.getInstance();
    sl.registerLazySingleton<SharedPreferences>(
      () {
        return sharedPreferences;
      },
    );
  }
}
