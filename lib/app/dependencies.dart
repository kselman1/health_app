import 'package:get/get.dart';
import 'package:health_app/app/data/sources/shared_pref_source.dart';

Future<void> injectDependencies() async {
final prefsSource = SharedPreferencesSourceImpl();
  await prefsSource.init();
  Get.put<SharedPreferencesSource>(prefsSource);

}