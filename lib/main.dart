import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'screens/RotinaScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rotinas do WinThor',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Rotinas do WinThor'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: StreamBuilder(
        stream: Firestore.instance.collection('rotina').orderBy('cod').snapshots(),
        builder: (context, snapshot) { 
          if (!snapshot.hasData) return const Text("Carregando...");
          return ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index) => _buildListItem(context, snapshot.data.documents[index])
          );
        },
      )
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
    return ListTile(
      title: Text("${document["cod"]} - ${document["nome"]}"),
      onTap: () async {
        // await _inserirRotinas();

        var root = MaterialPageRoute(builder: (context) => RotinaScreen(document));
        Navigator.push(context, root);
      },
    );
  }


  // Future<void> _inserirRotinas() async {
  //   var rotina = Firestore.instance.collection('rotina');
  //   await rotina.document().setData({ 'cod': 104, 'nome': 'ABC de Falta de Estoque' });
  //   await rotina.document().setData({ 'cod': 105, 'nome': 'Posição do Estoque' });
  //   await rotina.document().setData({ 'cod': 106, 'nome': 'Lucro por Pedido' });
  //   await rotina.document().setData({ 'cod': 107, 'nome': 'Consultar Plano de Contas' });
  //   await rotina.document().setData({ 'cod': 110, 'nome': 'Indicadores de Desempenho' });
  //   await rotina.document().setData({ 'cod': 111, 'nome': 'Resumo do Faturamento' });
  //   await rotina.document().setData({ 'cod': 114, 'nome': 'Vendas por Supervisor /Rca / Cliente' });
  //   await rotina.document().setData({ 'cod': 117, 'nome': 'Boletim Financeiro' });
  //   await rotina.document().setData({ 'cod': 118, 'nome': 'Resumo da Cobrança' });
  //   await rotina.document().setData({ 'cod': 119, 'nome': 'Fluxo de Caixa' });
  //   await rotina.document().setData({ 'cod': 120, 'nome': 'Resumo de Inadimplência' });
  //   await rotina.document().setData({ 'cod': 123, 'nome': 'ABC de Venda e Margem por Produto/Fornec' });
  //   await rotina.document().setData({ 'cod': 124, 'nome': 'Balancete' });
  //   await rotina.document().setData({ 'cod': 125, 'nome': 'Balancete 12 Meses' });
  //   await rotina.document().setData({ 'cod': 131, 'nome': 'Permitir Acesso a Dados' });
  //   await rotina.document().setData({ 'cod': 132, 'nome': 'Parâmetros da Presidência' });
  //   await rotina.document().setData({ 'cod': 139, 'nome': 'Fluxo de Caixa Sintético' });
  //   await rotina.document().setData({ 'cod': 143, 'nome': 'Resumo de Vendas Varejo' });
  //   await rotina.document().setData({ 'cod': 145, 'nome': 'Lucro por RCA' });
  //   await rotina.document().setData({ 'cod': 146, 'nome': 'Resumo de Vendas' });
  //   await rotina.document().setData({ 'cod': 147, 'nome': 'Custo/Venda/Lucro' });
  //   await rotina.document().setData({ 'cod': 148, 'nome': 'Vendas Autorizadas' });
  //   await rotina.document().setData({ 'cod': 149, 'nome': 'Resumo de Brindes' });
  //   await rotina.document().setData({ 'cod': 150, 'nome': 'Resumo de Bonificação' });
  //   await rotina.document().setData({ 'cod': 151, 'nome': 'Resumo de Devolução de Clientes' });
  //   await rotina.document().setData({ 'cod': 152, 'nome': 'Dedo Duro' });
  //   await rotina.document().setData({ 'cod': 153, 'nome': 'Relatório de Fechamento Diário' });
  //   await rotina.document().setData({ 'cod': 154, 'nome': 'Fluxo de Caixa Realizado' });
  //   await rotina.document().setData({ 'cod': 156, 'nome': 'Custo/Venda/Lucro - 12 meses' });
  //   await rotina.document().setData({ 'cod': 156, 'nome': 'Custo-Venda-Lucro - 12 meses' });
  //   await rotina.document().setData({ 'cod': 157, 'nome': 'Resumo de Compras' });
  // }  
}
