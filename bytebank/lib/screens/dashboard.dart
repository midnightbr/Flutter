import 'package:bytebank/screens/contacts/list.dart';
import 'package:bytebank/screens/transferencia/transactions_list.dart';
import 'package:flutter/material.dart';

class DashBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Dashboard',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        // Eixo horizontal (y)
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Espaço entre eles
        // Eixo vertical (x)
        crossAxisAlignment: CrossAxisAlignment.start, // Alinhar no começo
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'images/bytebank_logo.png',
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _FeatureItem(
                  'Contact',
                  Icons.people,
                  onClick: () {
                    _showContacts(context);
                  },
                ),
                _FeatureItem(
                  'Transaction Feed',
                  Icons.description,
                  onClick: () {
                    _showTransfersList(context);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showContacts(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ContactList(),
      ),
    );
  }

  void _showTransfersList(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TransactionsList(),
      ),
    );
  }
}

class _FeatureItem extends StatelessWidget {
  final String name;
  final IconData icon;
  final Function onClick;

  _FeatureItem(
    this.name,
    this.icon, {
    required this.onClick,
  })  : assert(icon != null),
        assert(onClick != null);
  // Com o assert, não sera mais aceito valores nulos

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      // Para adicionar propriedades de eventos que não são nativas do widget
      child: Material(
        color: Theme.of(context).primaryColor,
        child: InkWell(
          onTap: () => onClick(),
          child: Container(
            padding: EdgeInsets.all(8.0),
            height: 100,
            width: 120,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  icon,
                  color: Colors.white,
                  size: 24.00,
                ),
                Text(
                  name,
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
