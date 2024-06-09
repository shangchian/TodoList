import 'package:get_it/get_it.dart';
import 'package:todolist/viewmodels/global_viewmodel.dart';
import 'package:todolist/viewmodels/home_viewmodel.dart';
import 'package:todolist/viewmodels/task_detail_viewmodel.dart';
import 'package:todolist/views/home_view.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  try {
    locator.registerLazySingleton(() => GlobalViewModel());
    locator.registerFactory(() => HomeViewModel(locator<GlobalViewModel>()));
    locator.registerLazySingleton(() => TaskDetailViewModel());
  } catch (e) {
    print("Error in setupLocator: $e");
  }
}
