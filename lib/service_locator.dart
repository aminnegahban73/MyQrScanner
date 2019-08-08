import 'package:get_it/get_it.dart';

import 'services/button_messagebu.dart';

GetIt locator = GetIt();
void setupLocator() {
  locator.registerSingleton(ButtonMessagebus());
}