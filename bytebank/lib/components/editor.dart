import 'package:flutter/material.dart';

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
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
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
