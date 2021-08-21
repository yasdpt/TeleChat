import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:telechat/core/utils/custom_toast.dart';
import 'package:telechat/features/contacts/presentation/widgets/contact_item.dart';

class ContactsPage extends StatefulWidget {
  static const String routeName = '/contactsPage';
  const ContactsPage({Key key}) : super(key: key);

  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  List<Contact> contacts = [];
  bool showLoading = true;

  @override
  void initState() {
    super.initState();
    getContacts();
  }

  Future<void> getContacts() async {
    if (await Permission.contacts.request().isGranted) {
      contacts = await FlutterContacts.getContacts(withProperties: true);
      setState(() {
        showLoading = false;
      });
    } else {
      Navigator.of(context).pop();
      kShowToast('Please give permission to access your contacts');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Contacts',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: showLoading
            ? CircularProgressIndicator()
            : contacts.isNotEmpty
                ? ListView.builder(
                    padding: const EdgeInsets.all(0),
                    itemCount: contacts.length,
                    itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ContactItem(
                          displayName: contacts[index].displayName,
                          lastSeen: 'Last seen recently',
                        )),
                  )
                : Text('No contacts available.'),
      ),
    );
  }
}
