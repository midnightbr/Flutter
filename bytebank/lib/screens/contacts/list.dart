import 'package:bytebank/components/progress.dart';
import 'package:bytebank/database/dao/contact_dao.dart';
import 'package:bytebank/models/contacts.dart';
import 'package:bytebank/screens/contacts/alteration.dart';
import 'package:bytebank/screens/contacts/form.dart';
import 'package:bytebank/screens/transferencia/formulario.dart';
import 'package:flutter/material.dart';

const _tituloAppBar = 'Contacts';

class ContactList extends StatefulWidget {
  @override
  State<ContactList> createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  final ContactDao _dao = ContactDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _tituloAppBar,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: FutureBuilder<List<Contact>>(
        initialData: [],
        future: _dao.findAllContacts(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            /** Significa que o Future ainda não foi executado
           * Nesse caso é adicionado algum widget que quando acionado inicia
           * a Future para que saia desse estado
           */
            case ConnectionState.none:
              break;
            // Quando os dados ainda estão sendo carregados
            case ConnectionState.waiting:
              return Progress();
            /**
           * Esse estado significa que ele tem um dado disponivel, mais a Future
           * ainda não foi finalizada. Conhecida como strin
           */
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              // Recebendo os dados do bd
              final List<Contact> contacts = snapshot.data as List<Contact>;
              return ListView.builder(
                itemBuilder: (context, index) {
                  // Recebendo os itens dentro da lista
                  final Contact contact = contacts[index];
                  // Retornando os itens para a classe contactItem para a construção
                  return _ContactItem(
                    contact,
                    onClick: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => TransactionForm(contact),
                        ),
                      );
                    },
                  );
                },
                itemCount: contacts.length,
              );
          }
          /**
           * Caso nenhum dos casos do switch sejam executaveis (o que é
           * provavelmente bastante dificil de ocorrer), é sempre bom deixar
           * algo para não apresentar a tela vermelha de erro com o usuario.
           */
          return Text('Unknown error');
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(
                MaterialPageRoute(
                  builder: (context) => ContactForm(),
                ),
              )
              .then((value) => setState(() {}));
        },
        child: Icon(
          Icons.person_add_alt_1,
        ),
      ),
    );
  }
}

class _ContactItem extends StatelessWidget {
  final Contact contact;
  final Function onClick;
  final ContactDao _dao = ContactDao();

  // Recebendo o contato da lista
  _ContactItem(this.contact, {required this.onClick});

  @override
  Widget build(BuildContext context) {
    // Criando a listagem dos itens da lista recebido pelo construtor
    return Card(
      child: ListTile(
        // Colocando a funcionalidade de um botão (clique) no objeto
        onTap: () => onClick(),
        title: Text(
          contact.name,
          style: TextStyle(fontSize: 24.0),
        ),
        subtitle: Text(
          contact.accountNumber.toString(),
          style: TextStyle(fontSize: 16.0),
        ),
        trailing: SizedBox(
          height: 100,
          width: 100,
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AlterationContact(contact),
                    ),
                  );
                },
                icon: Icon(Icons.edit),
              ),
              IconButton(
                color: Colors.red,
                onPressed: () {
                  showDialog(context: context, builder: (deletecontext) => AlertDialog(
                    title: Text('Excluir Usuario'),
                    content: Text('Tem certeza?'),
                    actions: [
                      ElevatedButton(onPressed: () {
                        Navigator.of(context).pop();
                      }, child: Text('Não')),
                      ElevatedButton(onPressed: () {
                        _dao.deleteContact(contact.id);
                        Navigator.of(context).pop();
                      }, child: Text('Sim'))
                    ],
                  ));
                },
                icon: Icon(Icons.delete),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
