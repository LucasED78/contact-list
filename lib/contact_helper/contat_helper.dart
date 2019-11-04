import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

class ContactHelper{

  //criando um construtor objeto dentro da própria classe usando
  //o construtor interno
  static final ContactHelper _instance = ContactHelper._internal();

  //criando um factory que retorna a instancia interna da classe
  factory ContactHelper() => _instance;

  //criando o construtor interno
  ContactHelper._internal();

  Database _db;

  Future<Database> get db async{
    if(_db != null) return _db;
    else return await initDb();
  }

  Future<Database> initDb() async{
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'contact.db');

    return await openDatabase(path, version: 1, onCreate:(Database db, int newerVersion) async{
      await db.execute("CREATE TABLE contacts(id INTEGER, name TEXT, email TEXT, phone TEXT, img TEXT)");
    });
  }

  Future<Contact> saveContact(Contact contact) async{
    Database dbContact = await db;

    contact.id = await dbContact.insert('contacts', contact.toMap());
    return contact;
  }

  Future<Contact> getContact(int id) async{
    Database dbContact = await db;

    List<Map> contacts = await dbContact.query('contacts',
      columns: ['id', 'name', 'email', 'phone', 'img'],
      where: 'id = ?',
      whereArgs: [id]
    );

    if (contacts.length > 0){
      return Contact.fromMap(contacts.first);
    }
    else return null;
  }

  Future<int> deleteContact(int id) async{
    Database dbContact = await db;

   return await dbContact.delete('contacts',
      where: 'id = ?',
      whereArgs: ['id']
    );
  }

  Future<List> getContacts() async{
    Database dbContact = await db;

    List<Map> list = await dbContact.rawQuery('SELECT * FROM contacts');
    List<Contact> contacts = List();

    for(Map m in list){
      contacts.add(Contact.fromMap(m));
    }

    return contacts;
  }

  updateContact(Contact contact) async{
    Database dbContact = await db;

    dbContact.update('contacts',
      contact.toMap(),
      where: 'id = ?',
      whereArgs: [contact.id]
    );
  }
}

class Contact{
  int id;
  String name;
  String email;
  String phone;
  String img;

  Contact();

  Contact.fromMap(Map map){
    id = map['id'];
    name = map['name'];
    email = map['email'];
    phone = map['phone'];
    img = map['img'];
  }

  Map toMap(){
    Map<String, dynamic> map = {
      'name': name,
      'email': email,
      'phone': phone,
      'img': img
    };

    if (id != null) map['id'] = id;

    return map;
  }

  @override
  String toString() {
    // TODO: implement toString
    super.toString();
    return "id: $id, name: $name, email: $email, phone: $phone, img: $img \n";
  }
}