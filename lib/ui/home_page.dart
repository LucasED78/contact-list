import 'package:agenda_contatos/contact_helper/contat_helper.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    ContactHelper helper = ContactHelper();

//    Contact c = Contact();
//    c.name = 'Lucas Eduardo';
//    c.email = 'lucased78@hotmail.com';
//    c.phone = '54654654';
//    c.img = 'imgTeste';
//
//    helper.saveContact(c);

    helper.getContacts().then((a){
      print("a $a");
    })
    .catchError(print);
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
    );
  }
}
