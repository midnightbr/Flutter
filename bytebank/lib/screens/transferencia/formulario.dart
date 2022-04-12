import 'package:bytebank/components/editor.dart';
import 'package:bytebank/database/app_database.dart';
import 'package:bytebank/models/transferencia.dart';
import 'package:flutter/material.dart';

// Atributos constantes
const _tituloAppBar = 'New Transfer';
const _rotuloConta = 'Number Account';
const _dicaConta = '0000';
const _rotuloValor = 'Value';
const _dicaValor = '00.00';
const _buttonTexto = 'Confirm';


class FormularioTransferencia extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FormularioTransferenciaState();
}

class FormularioTransferenciaState extends State<FormularioTransferencia> {
  final TextEditingController _controladorCampoNumberAccount =
      TextEditingController();
  final TextEditingController _controladorCampoValue = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_tituloAppBar),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Editor(
                _controladorCampoNumberAccount,
                _rotuloConta,
                _dicaConta),
            Editor(_controladorCampoValue,
                _rotuloValor,
                _dicaValor,
                icon: Icons.monetization_on),
            ElevatedButton(
              child: Text(_buttonTexto),
              onPressed: () => _criaTransferencia(context),
            ),
          ],
        ),
      ),
    );
  }

  void _criaTransferencia(BuildContext context) {
    final int? numberAccount =
        int.tryParse(_controladorCampoNumberAccount.text);
    final double? value = double.tryParse(_controladorCampoValue.text);
    if (numberAccount != null && value != null) {
      final transferenciaCriada = Transferencia(value, numberAccount, 0);
      saveTransfer(transferenciaCriada).then((id) => Navigator.pop(context));
    }
  }
}
