import '../../config/common_import.dart';

class ViewDataBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllDataController>(() => AllDataController());
  }
}
