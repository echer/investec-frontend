// 1
import 'package:Investec/ui/pages/ativos/ativos-view-model.dart';
import 'package:Investec/ui/pages/carteira/carteira-view-model.dart';
import 'package:Investec/ui/pages/login/login-view-model.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt serviceLocator = GetIt.instance;

// 2
void setupServiceLocator() {
  serviceLocator.registerFactory<CarteiraViewModel>(() => CarteiraViewModel());
  serviceLocator.registerFactory<AtivosViewModel>(() => AtivosViewModel());
  serviceLocator.registerFactory<LoginViewModel>(() => LoginViewModel());
  serviceLocator.registerSingletonAsync<Dio>(() async {
    Dio dio = Dio();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    dio.options = BaseOptions(receiveTimeout: 5000, connectTimeout: 5000);
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (Options options) async {
      dio.interceptors.requestLock.lock();
      options.headers["Authorization"] = "Bearer $token";
      dio.interceptors.requestLock.unlock();
      return options;
    }));
    return dio;
  });
}
