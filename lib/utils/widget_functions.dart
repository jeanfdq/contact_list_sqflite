
import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/material.dart';

import '../theme/theme_constants.dart';

Widget addVerticalSpace(double height ) {
  return SizedBox(height: height);
}

Widget addHorizontalSpace(double width) {
  return SizedBox(width: width);
}

Widget addSeparetedRow(){
  return Container(color: Colors.grey, height: 0.3, width: DeviceSize.width,);
}

 class DeviceSize {
  static double height = MediaQuery.of(currentContext()).size.height;
  static double width = MediaQuery.of(currentContext()).size.width;
}

class NavigationService { 
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}

BuildContext currentContext(){
  return NavigationService.navigatorKey.currentContext!;
}

void showDialogAddContact(BuildContext context, TextEditingController nameController , TextEditingController phoneController, VoidCallback addContact, VoidCallback cancelAction) async {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            scrollable: false,
            elevation: 5,
            title: const Text("Adicionar contato."),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  autofocus: true,
                  controller: nameController,
                  textCapitalization: TextCapitalization.words,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    label: Text("Nome:"),
                    hintText: "ex: joão da Silva",
                  ),
                ),
                TextField(
                  controller: phoneController,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(
                    label: Text("Número:"),
                    hintText: "ex: +55 (11) 9 91234 5678",
                  ),
                  inputFormatters: [
                    TextInputMask(
                        mask: '\\+55 (99) 9 9999 9999', reverse: false),
                  ],
                ),
              ],
            ),
            actions: [
              ElevatedButton(
                onPressed: cancelAction,
                child: const Text("cancelar"),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    foregroundColor: MaterialStateProperty.all(kThemePrimary)),
              ),
              ElevatedButton(
                onPressed: addContact,
                child: Text( nameController.text.isEmpty ? "adicionar" : "alterar"),
              ),
            ],
          );
        });
  }