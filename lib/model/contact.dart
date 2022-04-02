
class Contact {
  late int id;
  late String name;
  late String phoneNumber;
  late String data;

  Contact(this.id, this.name, this.phoneNumber, this.data );

  Map<String, dynamic> toMap(){
    Map<String, dynamic> map = {
      "name":name,
      "phoneNumber": phoneNumber,
      "data": data,
    };

    if (id > 0) {
      map["id"] = id;
    }

    return map;
  }

  Contact.fromMap(Map<String, dynamic> map){
    id = map["id"];
    name = map["name"];
    phoneNumber = map["phoneNumber"];
    data = map["data"];
  }

}