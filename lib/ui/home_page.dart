import 'package:agenda_contatos/contact_helper/contat_helper.dart';
import 'package:agenda_contatos/ui/widgets/contact_list.dart';
import 'package:agenda_contatos/ui/widgets/contact_screen.dart';
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

    _getAllContacts();
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
        onPressed: _showContactScreen
      ),
      backgroundColor: Colors.white,
      body: ListView.builder(
        padding: EdgeInsets.only(left: 15, right: 15),
        itemCount: contacts.length,
        itemBuilder: (context, index){
          return ContactList(contacts[index], (){
            helper.deleteContact(contacts[index].id).then((value) => _getAllContacts());
            Navigator.pop(context);
          }, contactScreen: _showContactScreen);
        }
      ),
    );
  }

  void _showContactScreen({Contact contact}) async{
    Contact _recContact = await Navigator.push(context, 
      MaterialPageRoute(builder: (context) => ContactScreen(contact: contact,))
    );

    print("rec: $_recContact");

    if (_recContact != null){
      if (contact != null){
        helper.updateContact(_recContact);
      }else{
        helper.saveContact(_recContact);
      }

      _getAllContacts();
    }
  }

  void _getAllContacts() async{
    helper.getContacts().then((contacts){
      setState(() {
        this.contacts = contacts;
      });
    });
  }
}
