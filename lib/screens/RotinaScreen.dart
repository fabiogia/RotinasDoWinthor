import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:rotinasdowinthor/utils/Dialogos.dart';

import 'PhotoViewScreen.dart';

class RotinaScreen extends StatefulWidget {
  RotinaScreen(this.document, {Key key}) : super(key: key);

  final DocumentSnapshot document;

  @override
  _RotinaScreenState createState() => _RotinaScreenState(document);
}

class _RotinaScreenState extends State<RotinaScreen> {

  final DocumentSnapshot document;
  final _scaffoldKey = GlobalKey<ScaffoldState>(); 

  // var _itens = List<Widget>();

  _RotinaScreenState(this.document);

  String _montarConteudo() {
    String conteudo = "${document["cod"]} - ${document["nome"]}";

    // _itens.add(ListTile(
    //   title: Text("${document["cod"]} - ${document["nome"]}\n\nComentários:"),
    // ));

    if (document["comentarios"] != null) {
      conteudo += "\n.\n.\n**Comentários:**\n\n";

      for(int i=0; i < document["comentarios"].length; i++) {
        String c = document["comentarios"][i];
        conteudo += c.replaceAll("\\n", "\n") + "\n\n---\n";
      }
    }

    return conteudo;
  }

  @override
  void initState() {
    //
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Rotina"),
      ),
      body: SafeArea(
          child: Markdown(
            styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(p: Theme.of(context).textTheme.body1.copyWith(fontSize: 16.0)),
            data: _montarConteudo(),
            onTapLink: (String href) { 
              var root = MaterialPageRoute(builder:  (context) => new PhotoViewScreen(href));
              Navigator.push(context, root);
            },
          ),
        ),
      
      // Column(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: _itens
      // )
    );
  }

//   final String _markdownData = """
// # Markdown Example
// Markdown allows you to easily include formatted text, images, and even formatted Dart code in your app.
// ## Titles
// Setext-style
// ```
// This is an H1
// =============
// This is an H2
// -------------
// ```
// Atx-style
// ```
// # This is an H1
// ## This is an H2
// ###### This is an H6
// ```
// Select the valid headers:
// - [x] `# hello`
// - [ ] `#hello`
// ## Links
// [Google's Homepage][Google]
// ```
// [inline-style](https://www.google.com)
// [reference-style][Google]
// ```
// ## Images
// ![Flutter logo](/dart-lang/site-shared/master/src/_assets/image/flutter/icon/64.png)
// ## Tables
// |Syntax                                 |Result                               |
// |---------------------------------------|-------------------------------------|
// |`*italic 1*`                           |*italic 1*                           |
// |`_italic 2_`                           | _italic 2_                          |
// |`**bold 1**`                           |**bold 1**                           |
// |`__bold 2__`                           |__bold 2__                           |
// |`This is a ~~strikethrough~~`          |This is a ~~strikethrough~~          |
// |`***italic bold 1***`                  |***italic bold 1***                  |
// |`___italic bold 2___`                  |___italic bold 2___                  |
// |`***~~italic bold strikethrough 1~~***`|***~~italic bold strikethrough 1~~***|
// |`~~***italic bold strikethrough 2***~~`|~~***italic bold strikethrough 2***~~|
// ## Styling
// Style text as _italic_, __bold__, ~~strikethrough~~, or `inline code`.
// - Use bulleted lists
// - To better clarify
// - Your points
// ## Code blocks
// Formatted Dart code looks really pretty too:
// ```
// void main() {
//   runApp(MaterialApp(
//     home: Scaffold(
//       body: Markdown(data: markdownData),
//     ),
//   ));
// }
// ```
// ## Markdown widget
// This is an example of how to create your own Markdown widget:
//     Markdown(data: 'Hello _world_!');
// Enjoy!
// [Google]: https://www.google.com/
// """;
}