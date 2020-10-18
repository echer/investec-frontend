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
import 'package:Investec/ui/pages/ordem/view-model.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:injectable/injectable.dart';

final GetIt getIt = GetIt.instance;

@injectableInit
Future<void> configureInjection() async {
  getIt.registerSingletonAsync<SharedPreferences>(
    () => provideSharedPref(),
  );

  getIt.registerSingletonAsync<Dio>(
    () => provideDio(),
    dependsOn: [SharedPreferences],
  );

  getIt.registerSingletonAsync<AtivosAPI>(
    () => provideAtivoAPI(),
    dependsOn: [Dio],
  );
  getIt.registerSingletonAsync<CarteiraAPI>(
    () => provideCarteiraAPI(),
    dependsOn: [Dio],
  );
  getIt.registerSingletonAsync<OrdensAPI>(
    () => provideOrdemAPI(),
    dependsOn: [Dio],
  );
  getIt.registerSingletonAsync<UsuarioAPI>(
    () => provideUsuarioAPI(),
    dependsOn: [Dio],
  );

  getIt.registerSingletonAsync<AtivosRepository>(
    () => provideAtivoRepository(),
    dependsOn: [AtivosAPI],
  );
  getIt.registerSingletonAsync<CarteiraRepository>(
      () => provideCarteiraRepository(),
      dependsOn: [CarteiraAPI]);
  getIt.registerSingletonAsync<OrdensRepository>(
      () => provideOrdensRepository(),
      dependsOn: [OrdensAPI]);
  getIt.registerSingletonAsync<UsuarioRepository>(
      () => provideUsuarioRepository(),
      dependsOn: [UsuarioAPI]);

  getIt.registerFactory<CarteiraViewModel>(() {
    return CarteiraViewModel(
      getIt<CarteiraRepository>(),
    );
  });
  getIt.registerFactory<AtivosViewModel>(() {
    return AtivosViewModel(
      getIt<AtivosRepository>(),
    );
  });
  getIt.registerFactory<LoginViewModel>(() {
    return LoginViewModel(
      getIt<UsuarioRepository>(),
    );
  });
  getIt.registerFactory<OrdemViewModel>(() {
    return OrdemViewModel(
      getIt<OrdensRepository>(),
    );
  });

  $initGetIt(getIt);

  await getIt.allReady();
}

Future<SharedPreferences> provideSharedPref() async {
  return await SharedPreferences.getInstance();
}

Future<Dio> provideDio() async {
  Dio dio = Dio();
  dio.options = BaseOptions(receiveTimeout: 50000, connectTimeout: 50000);
  dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 5000));
  dio.interceptors.add(InterceptorsWrapper(onRequest: (Options options) async {
    SharedPreferences prefs = await provideSharedPref();
    String token = prefs.getString('token');
    dio.interceptors.requestLock.lock();
    options.headers["Authorization"] = "Bearer $token";
    dio.interceptors.requestLock.unlock();
    return options;
  }));
  return dio;
}

Future<AtivosAPI> provideAtivoAPI() async {
  return AtivosAPI(
    await provideDio(),
  );
}

Future<CarteiraAPI> provideCarteiraAPI() async {
  return CarteiraAPI(
    await provideDio(),
  );
}

Future<OrdensAPI> provideOrdemAPI() async {
  return OrdensAPI(
    await provideDio(),
  );
}

Future<UsuarioAPI> provideUsuarioAPI() async {
  return UsuarioAPI(
    await provideDio(),
  );
}

Future<AtivosRepository> provideAtivoRepository() async {
  return AtivosRepository(await provideAtivoAPI());
}

Future<CarteiraRepository> provideCarteiraRepository() async {
  return CarteiraRepository(await provideCarteiraAPI());
}

Future<OrdensRepository> provideOrdensRepository() async {
  return OrdensRepository(await provideOrdemAPI());
}

Future<UsuarioRepository> provideUsuarioRepository() async {
  return UsuarioRepository(await provideUsuarioAPI());
}
