class Transferencia {
  final int id;
  final double value;
  final int numberAccount;

  Transferencia(this.value, this.numberAccount, this.id);

  @override
  String toString() {
    return 'Transferencia{value: $value, numberAccount: $numberAccount}';
  }
}
