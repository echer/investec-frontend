// 1
import 'package:Investec/ui/pages/carteira/carteira-view-model.dart';
import 'package:get_it/get_it.dart';

GetIt serviceLocator = GetIt.instance;

// 2
void setupServiceLocator() {
  serviceLocator.registerFactory<CarteiraViewModel>(() => CarteiraViewModel());
}
