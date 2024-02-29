import '../config/common_import.dart';

class CommonTextField extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  const CommonTextField({
    super.key,
    this.hintText,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText ?? "",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
          contentPadding: const EdgeInsets.only(left: 10, right: 10),
        ),
      ),
    );
  }
}
