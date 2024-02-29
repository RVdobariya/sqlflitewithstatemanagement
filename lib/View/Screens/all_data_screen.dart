import '../../config/common_import.dart';

class AllData extends StatefulWidget {
  const AllData({super.key});

  @override
  State<AllData> createState() => _AllDataState();
}

class _AllDataState extends State<AllData> {
  late Database database;

  AllDataController controller = Get.find<AllDataController>();

  @override
  void initState() {
    () async {
      database = await SqfliteService().initDb();
      List<Map<String, dynamic>> data = await database.query("user", limit: 10, offset: controller.offset.value);
      controller.userData.value = List<Map<String, dynamic>>.from(data);
      controller.scroll.value.addListener(() async {
        if (controller.scroll.value.position.pixels == controller.scroll.value.position.maxScrollExtent) {
          debugPrint("scroll full");
          List<Map<String, dynamic>> data = await database.query("user", limit: 10, offset: controller.offset.value + 10);
          List<Map<String, dynamic>> map = List<Map<String, dynamic>>.from(data);

          controller.userData.addAll(map);

          controller.offset.value = controller.offset.value + 10;
          debugPrint("offset === ${controller.offset.value}");
          setState(() {});
        }
      });
      setState(() {});
    }();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Data"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.separated(
          separatorBuilder: (context, index) {
            return const Divider();
          },
          controller: controller.scroll.value,
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
              child: ListTile(
                trailing: Text("${index + 1}"),
                style: ListTileStyle.list,
                contentPadding: const EdgeInsets.all(5),
                title: Text("Name : ${controller.userData[index]['name'].toString()}"),
                subtitle: Text("Age : ${controller.userData[index]['age'].toString()}"),
              ),
            );
          },
          itemCount: controller.userData.length,
        ),
      ),
    );
  }
}
