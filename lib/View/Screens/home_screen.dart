import '../../config/common_import.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Database database;
  final GlobalKey _scaffoldKey = GlobalKey();
  HomeController homeController = Get.find<HomeController>();

  @override
  void initState() {
    () async {
      database = await SqfliteService().initDb();
      var data = await database.query("user");
      homeController.userData.value = List<Map<String, dynamic>>.from(data);
    }();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          GestureDetector(
            onTap: () {
              Get.to(() => const AllData(), binding: ViewDataBinding());
            },
            child: const Text(
              "View Data",
              style: TextStyle(fontSize: 18),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(() {
          return Column(
            children: <Widget>[
              if (homeController.isSearch.value)
                Align(
                  alignment: Alignment.centerRight,
                  child: RawMaterialButton(
                    onPressed: () async {
                      var data = await database.query("user");
                      homeController.userData.value = List<Map<String, dynamic>>.from(data);
                      homeController.name.value.clear();
                      homeController.age.value.clear();
                      homeController.isSearch.value = false;
                    },
                    fillColor: Theme.of(context).colorScheme.inversePrimary,
                    child: const Text("Clear search"),
                  ),
                ),
              const SizedBox(
                height: 10,
              ),
              CommonTextField(hintText: "Name", controller: homeController.name.value),
              const SizedBox(
                height: 10,
              ),
              CommonTextField(hintText: "Age", controller: homeController.age.value),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        if (homeController.name.value.text.isEmpty || homeController.age.value.text.isEmpty) {
                          snackBar(context: context, message: "All fields are mandatory");
                        } else {
                          if (homeController.isUpdate.value) {
                            homeController.updateData(database, context);
                          } else {
                            homeController.addData(database, context);
                          }
                        }
                      },
                      child: CommonButton(isUpdate: homeController.isUpdate.value, height: 50, name: homeController.isUpdate.value ? " Update" : "Add"),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        // homeController.userData.value = await database.query("user", limit: 5, offset: 6);
                        if (homeController.name.value.text.isEmpty && homeController.age.value.text.isEmpty) {
                          snackBar(context: context, message: "Please fill at least one field");
                        } else {
                          homeController.searchData(database, context);
                        }
                      },
                      child: CommonButton(isUpdate: homeController.isUpdate.value, height: 50, name: "Search"),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              expand()
            ],
          );
        }),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget expand() {
    return Obx(() {
      return Expanded(
          child: ListView.builder(
        controller: homeController.scroll.value,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Card(
              child: ListTile(
                title: Text("Name: ${homeController.userData[index]['name'].toString()}"),
                subtitle: Text("Age: ${homeController.userData[index]['age']}"),
                trailing: SizedBox(
                  width: 80,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                          onTap: () async {
                            homeController.deleteData(database, context, index);
                          },
                          child: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          )),
                      GestureDetector(
                          onTap: () async {
                            homeController.name.value.text = homeController.userData[index]['name'];
                            homeController.age.value.text = homeController.userData[index]['age'];
                            homeController.upDateId.value = homeController.userData[index]['id'];
                            homeController.isUpdate.value = true;
                          },
                          child: const Icon(
                            Icons.update,
                            color: Colors.blue,
                          )),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        itemCount: homeController.userData.length,
      ));
    });
  }
}
