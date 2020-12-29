import 'package:counter/components/counter/icounter_repository.dart';
import 'package:counter/repository/counter_inmemory_repository.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

void setupLocator() {
  // getIt.registerFactory(() => InfoService());
  getIt.registerSingleton<ICounterRepository>(CounterInMemoryRepository());
  // getIt.registerLazySingleton(() => OtherService());
}
