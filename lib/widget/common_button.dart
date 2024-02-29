import '../config/common_import.dart';

class CommonButton extends StatelessWidget {
  final bool isUpdate;
  final double? height;
  final double? width;
  final String? name;
  const CommonButton({super.key, this.isUpdate = false, this.width, this.height, this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: height ?? 50,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Theme.of(context).colorScheme.inversePrimary,
      ),
      child: Text(
        name ?? "",
        style: const TextStyle(fontWeight: FontWeight.w700, color: Colors.black, fontSize: 25),
      ),
    );
  }
}
