import 'dart:io';

import 'package:agenda_contatos/contact_helper/contat_helper.dart';
import 'package:flutter/material.dart';

class ContactList extends StatelessWidget {

  final Contact contact;

  ContactList(@required this.contact){
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
                        image: contact.img != null ? FileImage(File(contact.img)) :
                        Icon(Icons.person, color: Colors.black12,)
                    )
                ),
              ),
              Column(
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
