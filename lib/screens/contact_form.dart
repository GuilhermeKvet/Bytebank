import 'package:flutter/material.dart';
import 'package:new_bytebank/components/editor.dart';
import 'package:new_bytebank/models/Contact.dart';

import '../dao/contact_dao.dart';

class ContactForm extends StatefulWidget {
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerAccountNumber =
      TextEditingController();
  @override
  State<StatefulWidget> createState() {
    return _contactFormState();
  }
}

class _contactFormState extends State<ContactForm> {
  final ContactDao _dao = ContactDao();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Contact'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Editor(
                controller: widget._controllerName,
                label: 'Full name',
                insets: const EdgeInsets.all(0),
              ),
              Editor(
                controller: widget._controllerAccountNumber,
                label: 'Account number',
                type: TextInputType.number,
                insets: const EdgeInsets.only(top: 8.0),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: SizedBox(
                  width: double.maxFinite,
                  child: ElevatedButton(
                    child: const Text('Create'),
                    onPressed: () => _addUser(context),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _addUser(BuildContext context) {
    final String name = widget._controllerName.text;
    final int? accountNumber =
        int.tryParse(widget._controllerAccountNumber.text);

    if (accountNumber != null) {
      final Contact newUser = Contact(0, name, accountNumber);
      _dao.save(newUser).then((id) => Navigator.pop(context));
    }
  }
}
