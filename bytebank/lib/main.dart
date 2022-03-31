// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(BytebankApp());
}

class BytebankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: FormularioTransferencia(),
      ),
    );
  }
}

class FormularioTransferencia extends StatelessWidget {
  final TextEditingController _controladorCampoNumberAccount =
      TextEditingController();
  final TextEditingController _controladorCampoValue = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criando Transferência'),
      ),
      body: Column(
        children: [
          Editor(_controladorCampoNumberAccount, 'Número da conta', '0000'),
          Editor(_controladorCampoValue, 'Valor', '00.00',
              icon: Icons.monetization_on),
          ElevatedButton(
            child: Text('Confirmar'),
            onPressed: () => _criaTransferencia(),
          ),
        ],
      ),
    );
  }
  void _criaTransferencia() {
    final int? numberAccount =
    int.tryParse(_controladorCampoNumberAccount.text);
    final double? value =
    double.tryParse(_controladorCampoValue.text);
    if (numberAccount != null && value != null) {
      Transferencia(value, numberAccount);
    }
  }
}

class Editor extends StatelessWidget {
  final TextEditingController _controller;
  final String _rotulo;
  final String _dica;
  final IconData? icon;

  Editor(this._controller, this._rotulo, this._dica, {this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      // Configuração de margem
      padding: const EdgeInsets.fromLTRB(16.00, 8.00, 16.00, 8.00),
      child: TextField(
        // Utilizado para pegar valores digitados pelo usuario
        controller: _controller,
        style: TextStyle(fontSize: 24.00),
        decoration: InputDecoration(
            icon: icon != null ? Icon(icon) : null,
            labelText: _rotulo,
            hintText: _dica),
      ),
    );
  }
}

class ListaTransferencias extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transferências'),
      ),
      body: Column(
        children: <Widget>[
          ItemTransferencia(Transferencia(100.00, 0001)),
          ItemTransferencia(Transferencia(250.00, 1001)),
          ItemTransferencia(Transferencia(1500.00, 2001)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}

class ItemTransferencia extends StatelessWidget {
  final Transferencia _transferencia;

  ItemTransferencia(this._transferencia);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.monetization_on),
        title: Text(_transferencia.value.toString()),
        subtitle: Text(_transferencia.numberAccount.toString()),
      ),
    );
  }
}

class Transferencia {
  final double value;
  final int numberAccount;

  Transferencia(this.value, this.numberAccount);

  @override
  String toString() {
    return 'Transferencia{value: $value, numberAccount: $numberAccount}';
  }
}
