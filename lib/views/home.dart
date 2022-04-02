
import 'package:contact_list_sqflite/model/contact.dart';
import 'package:contact_list_sqflite/utils/extensions/extensions.dart';
import 'package:contact_list_sqflite/utils/widget_functions.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../components/container_dismissible.dart';
import '../components/progress_indicator_box.dart';
import '../utils/database_helper.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int idContact = 0;
  final db = DatabaseHelper();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Contatos",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: addContactForm,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      body: FutureBuilder<List<Contact>>(
        initialData: const [],
        future: _fetchAll(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const ProgressIndicatorBox();

            case ConnectionState.active:
              return Container();

            case ConnectionState.none:
              return Container();

            case ConnectionState.done:
              if (snapshot.hasData) {
                final listOfContacts = snapshot.data ?? [];

                return listOfContacts.isEmpty
                    ? const Center(
                        child: Text(
                          "Nenhum contato cadastrado!",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: listOfContacts.length,
                        itemBuilder: (context, index) {
                          Contact contact = listOfContacts[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Dismissible(
                              key: Key(const Uuid().v1()),
                              background: const ContainerDismissible(iconData: Icons.edit, background: Colors.blue, iconAxisAligment: MainAxisAlignment.start,),
                              secondaryBackground: const ContainerDismissible(iconData: Icons.delete, background: Colors.red, iconAxisAligment: MainAxisAlignment.end,),
                              child: Card(
                                elevation: 8,
                                shadowColor: Colors.black,
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8))),
                                child: SizedBox(
                                  height: 95,
                                  width: DeviceSize.width,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Row(
                                      children: [
                                        const CircleAvatar(
                                          radius: 30,
                                          backgroundImage:
                                              AssetImage("assets/avatar.jpeg"),
                                        ),
                                        addHorizontalSpace(5),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              contact.name,
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            addVerticalSpace(5),
                                            Text(
                                              contact.phoneNumber,
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            addVerticalSpace(3),
                                            Text(
                                              contact.data.dateFormatter(),
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              onDismissed: (direction){
                                if (direction == DismissDirection.startToEnd) {
                                  idContact = contact.id;
                                  _nameController.text = contact.name;
                                  _phoneController.text = contact.phoneNumber;
                                  showDialogAddContact(currentContext(), _nameController, _phoneController, _udpateContact, _popAction);
                                }

                                if (direction == DismissDirection.endToStart) {
                                  idContact = contact.id;
                                  _deleteContact();
                                }

                              },
                            ),
                          );
                        });
              } else {
                return const Center(
                  child: Text("Nenhum contato cadastrado!"),
                );
              }
          }
        },
      ),
    );
  }

  addContactForm() {
    _nameController.clear();
    _phoneController.clear();
    showDialogAddContact(currentContext(), _nameController, _phoneController, _addContact, _popAction);
  }

  _addContact() async {
    final name = _nameController.text.trim();
    final phoneNumber = _phoneController.text.trim();

    final result = await db
        .addContact(Contact(0, name, phoneNumber, DateTime.now().toString()));
    result > 0
        ? ShowSnackbarMessageStFull(widget).showSnack(
            currentContext(), "Contato adicionado com sucesso!",
            type: snackBarType.success)
        : ShowSnackbarMessageStFull(widget).showSnack(
            currentContext(), "Ops! Algo deu errado!",
            type: snackBarType.error);

    _nameController.clear();
    _phoneController.clear();

    _popAction();
  }

  _udpateContact() async {
   final _ = await db.updateContact(Contact(idContact, _nameController.text, _phoneController.text, DateTime.now().toString()));
   _popAction();
  }

  _deleteContact() async {
    final _ = await db.deleteContact(idContact);
    setState(() {});
  }

  Future<List<Contact>> _fetchAll() async {
    var contacts = await db.fetchAll();
    return contacts;
  }

  _popAction(){
    Navigator.of(currentContext()).pop();
    setState(() {});
  }

}