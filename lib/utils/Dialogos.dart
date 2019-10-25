import 'package:flutter/material.dart';

class Dialogos {
  static snackBar(GlobalKey<ScaffoldState> root, String texto, Duration duracao) {
      root.currentState.hideCurrentSnackBar();

      SnackBarAction action;
      if (duracao == Duration.zero) {
        duracao = Duration(hours: 1);
        action = SnackBarAction(label: "Fechar", onPressed: () { 
          root.currentState.hideCurrentSnackBar();
        },);
      }

      final snackBar = SnackBar(
        content: Text(texto),
        duration: duracao,
        action: action,
      );

      root.currentState.showSnackBar(snackBar);
  }

  static Future<T> alert<T>(BuildContext context, String titulo, String conteudo, {List<Widget> actions}) {
    if (actions == null) {
      actions = <Widget>[
        FlatButton(
          child: Text('OK'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ];
    }

    return showDialog<T>(
        context: context,
        builder: (context) => AlertDialog(
            title: Text(titulo),
            content: Text(conteudo ?? "null"),
            actions: actions
          )
      );
    }

  static Future<bool> question(BuildContext context, String titulo, String conteudo) async {
    return await alert<bool>(context, titulo, conteudo, actions: <Widget>[
      FlatButton(
          child: Text('Sim'),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
      FlatButton(
          child: Text('Não'),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ),
    ]);
  }
}