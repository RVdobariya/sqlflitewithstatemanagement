import '../config/common_import.dart';

snackBar({BuildContext? context, String? message}) {
  return ScaffoldMessenger.of(context!)
    ..removeCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(message!)));
}
