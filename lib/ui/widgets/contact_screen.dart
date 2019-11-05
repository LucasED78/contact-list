import 'dart:io';
import 'package:image_picker/image_picker.dart';
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
          Navigator.pop(context, _editedContact);
        },
      ),
      body: WillPopScope(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              GestureDetector(
                child: Container(
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
                onTap: () {
                  UtilsWidget.buildAlert(context, title: 'Escolha de onde deseja obter a imagem', actions: [
                    FlatButton(
                      child: Text("Câmera", style: TextStyle(fontSize: 20),),
                      onPressed: () => _getImage(context, 'camera'),
                    ),
                    FlatButton(
                      child: Text("Galeria", style: TextStyle(fontSize: 20)),
                      onPressed: () => _getImage(context, 'gallery'),
                    )
                  ]);
                },
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
        onWillPop: _requestPop,
      ),
    );
  }

  Future<bool> _requestPop(){
    if (_editingContact){

      showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text("Desfazer alterações"),
            content: Text("Se sair, as alterações serão perdidas"),
            actions: <Widget>[
              FlatButton(
                child: Text("cancelar"),
                onPressed: () => Navigator.pop(context),
              ),
              FlatButton(
                child: Text("sair"),
                onPressed: (){
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
              )
            ],
          );
        }
      );

      return Future.value(false);
    }
    else return Future.value(true);
  }

  void _getImage(BuildContext context, String selectedSource) async{
    ImageSource source = selectedSource == 'camera' ? ImageSource.camera : ImageSource.gallery;

    File image = await ImagePicker.pickImage(source: source);
    
    setState(() {
      _editedContact.img = image.path;
    });

    Navigator.pop(context);
  }
}