import 'dart:async';

import 'package:bytebank/components/response_dialog.dart';
import 'package:bytebank/components/transaction_auth_dialog.dart';
import 'package:bytebank/http/webclients/transaction_webclient.dart';
import 'package:bytebank/models/contacts.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';


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
  final String transactionId = Uuid().v4();

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
                        transactionId,
                        value,
                        widget.contact,
                      );
                      showDialog(
                          context: context,
                          builder: (contextDialog) {
                            return TransactionAuthDialog(
                              onConfirm: (String password) {
                                _save(transactionCreated, password, context);
                              },
                            );
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

  void _save(
    Transaction transactionCreated,
    String password,
    BuildContext context,
  ) async {
    Transaction transaction =
        await _send(transactionCreated, password, context);

    _showSuccessfulMessage(transaction, context);
  }

  Future<void> _showSuccessfulMessage(
      Transaction transaction, BuildContext context) async {
    if (transaction != null) {
      await showDialog(
          context: context,
          builder: (contextDialog) {
            return SuccessDialog('Successful transaction!');
          });
      Navigator.pop(context);
    }
  }

  Future<Transaction> _send(Transaction transactionCreated, String password,
      BuildContext context) async {
    final Transaction transaction = await _webClient
        .saveTransfer(transactionCreated, password)
        .catchError((e) {
      _showFailureMessage(context,
          message: 'Timeout submitting the transaction!');
    }, test: (e) => e is TimeoutException)
        .catchError((e) {
      _showFailureMessage(context, message: e.message);
    }, test: (e) => e is HttpException)
        .catchError((e) {
      _showFailureMessage(context);
    });
    return transaction;
  }

  void _showFailureMessage(BuildContext context,
      {String message = 'Unknown Error'}) {
    showDialog(
        context: context,
        builder: (contextDialog) {
          return FailureDialog(message);
        });
  }
}
