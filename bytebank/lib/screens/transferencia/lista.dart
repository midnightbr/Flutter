import 'package:bytebank/database/dao/transfer_dao.dart';
import 'package:bytebank/models/transferencia.dart';
// import 'package:bytebank/screens/transferencia/formulario.dart';
import 'package:flutter/material.dart';

const _tituloAppBar = 'Transfers';

class TransfersList extends StatefulWidget {
  @override
  State<TransfersList> createState() => _TransfersListState();
}

class _TransfersListState extends State<TransfersList> {
  final TransferDao _dao = TransferDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _tituloAppBar,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: FutureBuilder<List<Transferencia>>(
        initialData: [],
        future: _dao.findAllTransfers(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            /** Significa que o Future ainda não foi executado
           * Nesse caso é adicionado algum widget que quando acionado inicia
           * a Future para que saia desse estado
           */
            case ConnectionState.none:
              break;
            // Quando os dados ainda estão sendo carregados
            case ConnectionState.waiting:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [CircularProgressIndicator(), Text('Loading')],
                ),
              );
            /**
           * Esse estado significa que ele tem um dado disponivel, mais a Future
           * ainda não foi finalizada. Conhecida como strin
           */
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              // Recebendo os dados do bd
              final List<Transferencia> transfers =
                  snapshot.data as List<Transferencia>;
              return ListView.builder(
                itemBuilder: (context, index) {
                  // Recebendo os itens dentro da lista
                  final Transferencia tranfer = transfers[index];
                  // Retornando os itens para a classe contactItem para a construção
                  return _TranferItem(tranfer);
                },
                itemCount: transfers.length,
              );
          }
          /**
           * Caso nenhum dos casos do switch sejam executaveis (o que é
           * provavelmente bastante dificil de ocorrer), é sempre bom deixar
           * algo para não apresentar a tela vermelha de erro com o usuario.
           */
          return Text('Unknown error');
        },
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.of(context).push(
      //       MaterialPageRoute(
      //         builder: (context) => FormularioTransferencia(),
      //       ),
      //     ).then((value) => setState(() {}));
      //   },
      //   child: Icon(
      //     Icons.account_balance,
      //   ),
      // ),
    );
  }
}

class _TranferItem extends StatefulWidget {
  final Transferencia transfer;


  _TranferItem(this.transfer);

  @override
  State<_TranferItem> createState() => _TranferItemState();
}

class _TranferItemState extends State<_TranferItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 3.0),
      child: Card(
        child: ListTile(
          title: Text(
            '\$${widget.transfer.value.toString()}',
            style: TextStyle(fontSize: 24.0),
          ),
          subtitle: Text(
            widget.transfer.numberAccount.toString(),
            style: TextStyle(fontSize: 16.0),
          ),
        ),
        // const PopupMenuItem(
        //   child: Text('Deletar'),
        // ),
        // const PopupMenuItem(
        // child: Text('Atualizar')
        // ,
        // ),
      ),
    );

    // -> Método antigo
    // Criando a listagem dos itens da lista recebido pelo construtor
    // return Card(
    //   child: ListTile(
    //     title: Text(
    //       transfer.value.toString(),
    //       style: TextStyle(fontSize: 24.0),
    //     ),
    //     subtitle: Text(
    //       transfer.numberAccount.toString(),
    //       style: TextStyle(fontSize: 16.0),
    //     ),
    //   ),
    // );
  }
}
