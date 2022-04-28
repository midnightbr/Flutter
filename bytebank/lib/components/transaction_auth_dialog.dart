import 'package:flutter/material.dart';

const String _titule = 'Authenticate';

class TransactionAuthDialog extends StatefulWidget {
  final Function(String password) onConfirm;

  TransactionAuthDialog({
    required this.onConfirm,
  });

  @override
  State<TransactionAuthDialog> createState() => _TransactionAuthDialogState();
}

class _TransactionAuthDialogState extends State<TransactionAuthDialog> {
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(_titule),
      content: TextField(
        controller: _passwordController,
        // Escondendo a senha
        obscureText: true,
        // Máximo de caracteres
        maxLength: 4,
        // Selecionando teclado para tipo númerico
        keyboardType: TextInputType.number,
        // Alinhando o texto
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          // Add as bordas involta do input
          border: OutlineInputBorder(),
        ),
        style: TextStyle(
          // Tamanho da fonte
          fontSize: 56,
          // Espaçamento entre os caracteres
          letterSpacing: 32,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            // Passando a senha digitada
            widget.onConfirm(_passwordController.text);
            // Retorna a tela após o click
            Navigator.pop(context);
          },
          child: Text('Confirm'),
        ),
      ],
    );
  }
}
