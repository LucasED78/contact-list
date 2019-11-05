import 'dart:io';

import 'package:agenda_contatos/contact_helper/contat_helper.dart';
import 'package:flutter/material.dart';
import 'utils.dart';

class ContactScreen extends StatefulWidget {

  final Contact contact;

  ContactScreen({this.contact});

  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  bool _editingContact = false;
  Contact _editedContact;
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController phoneCtrl = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.contact == null){
      _editedContact = Contact();
    }
    else 
      _editedContact = Contact.fromMap(widget.contact.toMap());
      nameCtrl.text = _editedContact.name;
      emailCtrl.text = _editedContact.email;
      phoneCtrl.text = _editedContact.phone;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UtilsWidget.buildAppBar(_editedContact.name ?? 'Novo Contato'),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save, color: Colors.white,),
        onPressed: (){
          Navigator.pop(context, _editedContact);
        },
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: FileImage(File(_editedContact.img ?? 'a.jpg'))/*_editedContact.img != null ? FileImage(File(_editedContact.img)) :
                    Icon(Icons.person, color: Colors.black,)*/
                  ),
              ),
            ),
            UtilsWidget.buildTextField('Nome', nameCtrl, (text){
              _editingContact = true;            

              setState(() {
                _editedContact.name = text;  
              });
            }),
            UtilsWidget.buildTextField('E-mail', emailCtrl, (text){
              _editingContact = true;
              _editedContact.email = text;
            }, inputType: TextInputType.emailAddress),
            UtilsWidget.buildTextField('Phone', phoneCtrl, (text){
              _editingContact = true;
              _editedContact.phone = text;
            }, inputType: TextInputType.phone)
          ],
        ),
      ),
    );
  }
}