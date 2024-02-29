import '../config/common_import.dart';

class HomeController extends GetxController {
  Rx<TextEditingController> name = TextEditingController().obs;
  Rx<TextEditingController> age = TextEditingController().obs;
  Rx<ScrollController> scroll = ScrollController().obs;

  RxList<Map<String, dynamic>> userData = <Map<String, dynamic>>[].obs;
  RxInt upDateId = 0.obs;
  RxBool isUpdate = false.obs;
  RxBool isSearch = false.obs;

  Future<void> updateData(database, context) async {
    await database.update("user", {"name": name.value.text, "age": age.value.text}, where: "id = ${upDateId.value}");
    snackBar(context: context, message: "Data Update Successfully");
    name.value.clear();
    age.value.clear();
    upDateId.value = 0;
    isUpdate.value = false;
    userData.clear();
    List<Map<String, dynamic>> data = await database.query("user");
    userData.value = List<Map<String, dynamic>>.from(data);
  }

  Future<void> addData(database, context) async {
    await database.rawInsert("INSERT INTO user (name,age) VALUES ('${name.value.text}','${age.value.text}')");
    name.value.clear();
    age.value.clear();
    List<Map<String, dynamic>> data = await database.query("user");
    userData.value = List<Map<String, dynamic>>.from(data);
    snackBar(context: context, message: "Data Added Successfully");
  }

  Future<void> searchData(database, context) async {
    isSearch.value = true;
    debugPrint("print data");
    List<Map<String, dynamic>> data = await database.rawQuery("SELECT * FROM user WHERE name = '${name.value.text}' OR age = '${age.value.text}'");
    userData.value = List<Map<String, dynamic>>.from(data);
  }

  Future<void> deleteData(database, context, index) async {
    database.rawDelete("DELETE FROM user WHERE id = ${userData[index]['id']}");
    userData.value = await database.query("user");
  }
}
