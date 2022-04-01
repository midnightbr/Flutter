class Transferencia {
  final double value;
  final int numberAccount;

  Transferencia(this.value, this.numberAccount);

  @override
  String toString() {
    return 'Transferencia{value: $value, numberAccount: $numberAccount}';
  }
}
