import 'dart:io';
import 'package:url_launcher/url_launcher.dart';
import 'package:agenda_contatos/contact_helper/contat_helper.dart';
import 'package:flutter/material.dart';

class ContactList extends StatelessWidget {

  final Contact contact;
  final Function contactScreen;
  final Function deleteCb;

  ContactList(@required this.contact, this.deleteCb, {this.contactScreen}){
    print(this.contact);
    assert(this.contact != null);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: EdgeInsets.only(top: 10),
        child: Card(
          child: Row(
            children: <Widget>[
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: FileImage(File(contact.img))/*contact.img != null ? FileImage(File(contact.img)) :
                        Icon(Icons.person, color: Colors.black12,)*/
                    )
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(contact.name,
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(contact.email),
                    Text(contact.phone)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      onTap: () => _showModalScreen(context, contact),
    );
  }

  void _showModalScreen(BuildContext context, Contact contact){
    showModalBottomSheet(
      context: context,
      builder: (context){
        return BottomSheet(
          builder: (context){
            return Container(
              padding: EdgeInsets.all(15),
              child: Column(
                children: <Widget>[
                  FlatButton(
                    child: Text("Ligar"),
                    onPressed: (){
                      launch("tel:${contact.phone}");
                    },
                  ),
                  FlatButton(
                    child: Text("Editar"),
                    onPressed: (){
                      contactScreen(contact: contact);
                    },
                  ),
                  FlatButton(
                    child: Text("Excluir"),
                    onPressed: deleteCb,
                  )
                ],
              ),
            );
          },
          onClosing: () => Navigator.pop(context),
        );
      }
    );
  }
}
