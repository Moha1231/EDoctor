import '../../core/repositories/api_services.dart';
import 'package:get_it/get_it.dart';
import '../../core/viewmodel/chat_view_model.dart';

final locator = GetIt.instance;
setUpLocator() {
  locator.registerLazySingleton(() => ChatViewModel());
  locator.registerLazySingleton(() => GoogleGenerativeServices());
}
