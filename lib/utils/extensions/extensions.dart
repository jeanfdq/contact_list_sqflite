import 'package:contact_list_sqflite/utils/widget_functions.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

enum snackBarType { error, success, basic }

extension ShowSnackbarMessage on StatelessWidget {
  void showSnack(BuildContext context, String text,
      {snackBarType type = snackBarType.basic}) {

final icon = type == snackBarType.basic ? null : type == snackBarType.error ? Icons.report_problem : Icons.done_all;
final iconColor = type == snackBarType.error ? Colors.yellow : Colors.white;
    final snack = SnackBar(
      duration: const Duration(seconds: 2),
      content: Row(
        children: [
          Icon(icon, color: iconColor,),
          addHorizontalSpace(5),
          Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ],
      ),
      backgroundColor: type == snackBarType.basic
          ? Colors.grey
          : type == snackBarType.error
              ? Colors.red
              : Colors.green,
    );
    ScaffoldMessenger.of(context).showSnackBar(snack);
  }
}

extension ShowSnackbarMessageStFull on StatefulWidget {
  void showSnack(BuildContext context, String text,
      {snackBarType type = snackBarType.basic}) {

final icon = type == snackBarType.basic ? null : type == snackBarType.error ? Icons.report_problem : Icons.done_all;
final iconColor = type == snackBarType.error ? Colors.yellow : Colors.white;
    final snack = SnackBar(
      duration: const Duration(seconds: 1),
      content: Row(
        children: [
          Icon(icon, color: iconColor,),
          addHorizontalSpace(5),
          Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ],
      ),
      backgroundColor: type == snackBarType.basic
          ? Colors.grey
          : type == snackBarType.error
              ? Colors.red
              : Colors.green,
    );
    ScaffoldMessenger.of(context).showSnackBar(snack);
  }
}

extension DateFormater on String {

  String dateFormatter(){
    initializeDateFormatting("pt_BR");
    DateTime parsedDate = DateTime.parse(this);
    return DateFormat.yMMMMd("pt_BR").format(parsedDate);
  }

}