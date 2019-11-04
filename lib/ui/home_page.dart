import 'package:agenda_contatos/contact_helper/contat_helper.dart';
import 'package:agenda_contatos/ui/widgets/contact_list.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ContactHelper helper = ContactHelper();
  List<Contact> contacts = List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    helper.getContacts().then((contacts){
      setState(() {
        this.contacts = contacts;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contatos"),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, color: Colors.white,),
        backgroundColor: Colors.teal,
        onPressed: null,
      ),
      backgroundColor: Colors.white,
      body: ListView.builder(
        padding: EdgeInsets.only(left: 15, right: 15),
        itemCount: contacts.length,
        itemBuilder: (context, index){
          return ContactList(contacts[index]);
        }
      ),
    );
  }
}
