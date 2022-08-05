import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_bytebank/dao/contact_dao.dart';
import 'package:new_bytebank/models/Contact.dart';
import 'package:new_bytebank/screens/contact_form.dart';
import 'package:new_bytebank/screens/transaction_form.dart';

import '../components/progress/circularProgress.dart';
import '../components/container.dart';

@immutable
abstract class ContactListState {
  const ContactListState();
}

@immutable
class InicialContactListState extends ContactListState {
  const InicialContactListState();
}

@immutable
class LoadingContactListState extends ContactListState {
  const LoadingContactListState();
}

@immutable
class LoadedContactListState extends ContactListState {
  final List<Contact> _contacts;
  const LoadedContactListState(this._contacts);
}

@immutable
class FatalErrorContactListState extends ContactListState {
  const FatalErrorContactListState();
}

class ContactListCubit extends Cubit<ContactListState> {
  ContactListCubit() : super(InicialContactListState());

  void reload(dao) async {
    emit(LoadingContactListState());
    dao.findAll().then((contacts) => emit(LoadedContactListState(contacts)));
  }
}

class ContactsListContainer extends BlocContainer {
  @override
  Widget build(BuildContext context) {
    final ContactDao dao = ContactDao();
    return BlocProvider<ContactListCubit>(
      create: (context) {
        final cubit = ContactListCubit();
        cubit.reload(dao);
        return cubit;
      },
      child: ContactList(dao),
    );
  }
}

class ContactList extends StatelessWidget {
  final ContactDao _dao;
  ContactList(this._dao);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact'),
      ),
      //FutureBuilder permite trabalhar com state, sem ser uma
      //class StatefulWidget, mas somente no widget encapsulado.
      body: BlocBuilder<ContactListCubit, ContactListState>(
        builder: (context, state) {
          if (state is InicialContactListState ||
              state is LoadingContactListState) {
            return CircularProgress();
          }
          if (state is LoadedContactListState) {
            final contacts = state._contacts;
            return ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                final contact = contacts[index];
                return _ContactItem(
                  contact,
                  onClick: () {
                    push(context, TransactionFormContainer(contact));
                  },
                );
              },
            );
          }
          return const Text('Unknown error');
        },
      ),
      floatingActionButton: buildAddContactButton(context),
    );
  }

  FloatingActionButton buildAddContactButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ContactForm(),
          ),
        );
        update(context);
      },
      child: Icon(Icons.add),
    );
  }

  void update(BuildContext context) {
    context.read<ContactListCubit>().reload(_dao);
  }
}

class _ContactItem extends StatelessWidget {
  final Contact contact;
  final Function onClick;

  _ContactItem(
    this.contact, {
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () => onClick(),
        title: Text(
          contact.name,
          style: const TextStyle(
            fontSize: 24,
          ),
        ),
        subtitle: Text(
          contact.accountNumber.toString(),
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
