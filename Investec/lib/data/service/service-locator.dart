// 1
import 'package:Investec/data/repository/ativos-repository.dart';
import 'package:Investec/data/repository/carteira-repository.dart';
import 'package:Investec/data/repository/ordens-repository.dart';
import 'package:Investec/data/repository/remote/ativos-api.dart';
import 'package:Investec/data/repository/remote/carteira-api.dart';
import 'package:Investec/data/repository/remote/ordens-api.dart';
import 'package:Investec/data/repository/remote/usuario-api.dart';
import 'package:Investec/data/repository/usuario-repository.dart';
import 'package:Investec/data/service/service-locator.iconfig.dart';
import 'package:Investec/ui/pages/ativos/view-model.dart';
import 'package:Investec/ui/pages/carteira/view-model.dart';
import 'package:Investec/ui/pages/login/view-model.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:injectable/injectable.dart';

final GetIt getIt = GetIt.instance;

@injectableInit
Future<void> configureInjection() async {
  getIt.registerSingletonAsync<SharedPreferences>(
    () async {
      var prefs = await SharedPreferences.getInstance();
      return prefs;
    },
  );

  getIt.registerSingletonAsync<Dio>(
    () async {
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
        SharedPreferences prefs = getIt<SharedPreferences>();
        String token = prefs.getString('token');
        dio.interceptors.requestLock.lock();
        options.headers["Authorization"] = "Bearer $token";
        dio.interceptors.requestLock.unlock();
        return options;
      }));
      return dio;
    },
    dependsOn: [SharedPreferences],
  );

  getIt.registerSingletonAsync<AtivosAPI>(() async {
    return AtivosAPI(
      getIt<Dio>(),
    );
  }, dependsOn: [Dio]);

  getIt.registerSingletonAsync<CarteiraAPI>(() async {
    return CarteiraAPI(
      getIt<Dio>(),
    );
  }, dependsOn: [Dio]);
  getIt.registerSingletonAsync<OrdensAPI>(() async {
    return OrdensAPI(
      getIt<Dio>(),
    );
  }, dependsOn: [Dio]);
  getIt.registerSingletonAsync<UsuarioAPI>(() async {
    return UsuarioAPI(
      getIt<Dio>(),
    );
  }, dependsOn: [Dio]);

  getIt.registerSingletonAsync<AtivosRepository>(() async {
    return AtivosRepository(
      getIt<AtivosAPI>(),
    );
  }, dependsOn: [AtivosAPI]);
  getIt.registerSingletonAsync<CarteiraRepository>(() async {
    return CarteiraRepository(
      getIt<CarteiraAPI>(),
    );
  }, dependsOn: [CarteiraAPI]);
  getIt.registerSingletonAsync<OrdensRepository>(() async {
    return OrdensRepository(
      getIt<OrdensAPI>(),
    );
  }, dependsOn: [OrdensAPI]);
  getIt.registerSingletonAsync<UsuarioRepository>(() async {
    return UsuarioRepository(
      getIt<UsuarioAPI>(),
    );
  }, dependsOn: [UsuarioAPI]);

  getIt.registerSingletonAsync<CarteiraViewModel>(() async {
    return CarteiraViewModel(
      getIt<CarteiraRepository>(),
    );
  }, dependsOn: [CarteiraRepository]);
  getIt.registerSingletonAsync<AtivosViewModel>(() async {
    return AtivosViewModel(
      getIt<AtivosRepository>(),
    );
  }, dependsOn: [AtivosRepository]);
  getIt.registerSingletonAsync<LoginViewModel>(() async {
    return LoginViewModel(
      getIt<UsuarioRepository>(),
    );
  }, dependsOn: [UsuarioRepository]);

  $initGetIt(getIt);

  await getIt.allReady();
}
