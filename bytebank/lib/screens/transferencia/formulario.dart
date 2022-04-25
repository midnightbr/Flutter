import 'package:bytebank/http/webclients/transaction_webclient.dart';
import 'package:bytebank/models/contacts.dart';
import 'package:bytebank/models/transferencia.dart';
import 'package:flutter/material.dart';

// Atributos constantes
const _tituloAppBar = 'New Transfer';
const _rotuloValor = 'Value';

class TransactionForm extends StatefulWidget {
  final Contact contact;

  TransactionForm(this.contact);

  @override
  State<StatefulWidget> createState() => TransactionFormState();
}

class TransactionFormState extends State<TransactionForm> {
  final TransactionWebClient _webClient = TransactionWebClient();

  final TextEditingController _valueController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_tituloAppBar),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.contact.name,
                style: TextStyle(
                  fontSize: 24.00,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  widget.contact.accountNumber.toString(),
                  style: TextStyle(
                    fontSize: 32.00,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: _valueController,
                  style: TextStyle(
                    fontSize: 24.00,
                  ),
                  decoration: InputDecoration(
                    labelText: _rotuloValor,
                  ),
                  keyboardType: TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  width: double.maxFinite,
                  child: ElevatedButton(
                    onPressed: () {
                      final double? value = double.tryParse(
                        _valueController.text,
                      );
                      final transactionCreated = Transaction(
                        value!,
                        widget.contact,
                      );
                      _webClient.saveTransfer(transactionCreated).then((transaction) {
                        if(transaction != null) {
                          Navigator.pop(context);
                        }
                      });
                    },
                    child: Text('Transfer'),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
