import '../config/common_import.dart';

class HiveHomePage extends StatefulWidget {
  const HiveHomePage({super.key});

  @override
  State<HiveHomePage> createState() => _HiveHomePageState();
}

class _HiveHomePageState extends State<HiveHomePage> {
  Box? box;
  @override
  void initState() {
    () async {
      box = await Hive.openBox('testBox');

      /*   var person = Person(
        name: 'Dave',
        age: 22,
        friends: ['Linda', 'Marc', 'Anne'],
      );
*/
      await box!.put("key", {
        "jhds": {
          "hello": ["dsdf", "sdfsdf"]
        }
      });
      await box!.put("value", ["key", "key", "key"]);

      debugPrint("box print === ${box!.get('key')}");
    }();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var data = box!.get("key");
    return Scaffold(
        body: Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("${data["jhds"].runtimeType}"),
          Text("${box!.get('value', defaultValue: {})}"),
        ],
      ),
    ));
  }
}
