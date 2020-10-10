// 1
import 'package:Investec/data/service/service-locator.iconfig.dart';
import 'package:Investec/ui/pages/ativos/ativos-view-model.dart';
import 'package:Investec/ui/pages/carteira/carteira-view-model.dart';
import 'package:Investec/ui/pages/login/login-view-model.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:injectable/injectable.dart';

final GetIt getIt = GetIt.instance;

@injectableInit
Future<void> configureInjection() async {
  getIt.registerFactory<CarteiraViewModel>(() => CarteiraViewModel());
  getIt.registerFactory<AtivosViewModel>(() => AtivosViewModel());
  getIt.registerFactory<LoginViewModel>(() => LoginViewModel());
  getIt.registerSingletonAsync<SharedPreferences>(
      () async => await SharedPreferences.getInstance());
  getIt.registerSingletonAsync<Dio>(() async {
    Dio dio = Dio();
    dio.options = BaseOptions(receiveTimeout: 5000, connectTimeout: 5000);
    dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 5000));
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (Options options) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('token');
      dio.interceptors.requestLock.lock();
      options.headers["Authorization"] = "Bearer $token";
      dio.interceptors.requestLock.unlock();
      return options;
    }));
    return dio;
  }, dependsOn: [SharedPreferences]);
  $initGetIt(getIt);
}
