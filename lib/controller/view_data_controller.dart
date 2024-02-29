import '../config/common_import.dart';

class AllDataController extends GetxController {
  Rx<ScrollController> scroll = ScrollController().obs;

  RxList<Map<String, dynamic>> userData = <Map<String, dynamic>>[].obs;
  RxInt upDateId = 0.obs;
  RxInt offset = 0.obs;
  RxBool isUpdate = false.obs;
}
