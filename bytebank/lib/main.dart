// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(BytebankApp());
}

class BytebankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.deepPurple,
        ).copyWith(
          secondary: Colors.indigoAccent[400],
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.deepPurpleAccent[400],
          textTheme: ButtonTextTheme.primary
        ),
      ),
      home: ListaTransferencias(),
    );
  }
}

class FormularioTransferencia extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FormularioTransferenciaState();
  }
}

class FormularioTransferenciaState extends State<FormularioTransferencia> {
  final TextEditingController _controladorCampoNumberAccount =
  TextEditingController();
  final TextEditingController _controladorCampoValue = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criando Transferência'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Editor(_controladorCampoNumberAccount, 'Número da conta', '0000'),
            Editor(_controladorCampoValue, 'Valor', '00.00',
                icon: Icons.monetization_on),
            ElevatedButton(
              child: Text('Confirmar'),
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
      final transferenciaCriada = Transferencia(value, numberAccount);
      Navigator.pop(context, transferenciaCriada);
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
        keyboardType: TextInputType.number,
      ),
    );
  }
}

class ListaTransferencias extends StatefulWidget {
  final List<Transferencia> _transferencias = [];

  @override
  State<StatefulWidget> createState() {
    return ListaTransferenciasState();
  }
}

class ListaTransferenciasState extends State<ListaTransferencias> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transferências'),
      ),
      body: ListView.builder(
        itemCount: widget._transferencias.length,
        itemBuilder: (context, indice) {
          final transferencia = widget._transferencias[indice];
          return ItemTransferencia(transferencia);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final Future<Transferencia?> future =
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return FormularioTransferencia();
          }));
          future.then((transferenciaRecebida) {
            Future.delayed(Duration(milliseconds: 500), () {
              debugPrint('$transferenciaRecebida');
              if(transferenciaRecebida != null) {
                /**
                 * Essa parte do código é muito importante para garantir
                 * que o conteúdo seja adicionado a tela, garantindo assim
                 * a atualização dos dados de forma correta.
                  */
                setState(() {
                  widget._transferencias.add(transferenciaRecebida);
                });
              }
            });
          });
        },
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
