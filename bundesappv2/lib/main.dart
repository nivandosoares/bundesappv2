import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'models/Classificacao.dart';

void main() => runApp(MyApp());
//NÂO ESQUECER DE COLOCAR HTTP NAS DEPENDECIAS E BAIXAR DEPOIS
Future<Classificacao> fetchClassificacao() async {
  final response = await http.get(
      'https://www.parsehub.com/api/v2/runs/tLTJeXqG80HC/data?api_key=tau1-4-7WTCX');
  if (response.statusCode == 200) {
    // Se o servidor retornar o status 200, processa o JSON
    return Classificacao.fromJson(json.decode(response.body));
  } else {
    // Caso contrário, fudeu
    throw Exception('Deu ruim');
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bundoes app (beta)',
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        primaryColor: const Color(0xFF212121),
        accentColor: const Color(0xFF64ffda),
        canvasColor: const Color(0xFF303030),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<Classificacao> futureClassificacao;

  @override
  void initState() {
    super.initState();
    futureClassificacao = fetchClassificacao();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BUNDOES APP HEUEHEU"),
      ),
      body: Container(
        child: FutureBuilder<Classificacao>(
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Clube time = snapshot.data.clube.first;
              // print(time.logoUrl.toString());
              return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new Image.network(
                      time.logoUrl,
                      fit: BoxFit.fill,
                      width: 47.0,
                      height: 47.0,
                    ),
                    new Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Text(
                            time.time,
                            style: new TextStyle(
                                fontSize: 12.0,
                                color: const Color(0xFFffffff),
                                fontWeight: FontWeight.w900,
                                fontFamily: "Roboto"),
                          ),
                          new Text(
                            ' posição : ' +
                                time.posicao +
                                ' , ' +
                                time.pontos +
                                ' pontos, ' +
                                ' aproveitamento ' +
                                time.aproveitamento +
                                ' % ',
                            style: new TextStyle(
                                fontSize: 12.0,
                                color: const Color(0xFFffffff),
                                fontWeight: FontWeight.w400,
                                fontFamily: "Roboto"),
                          ),
                          new Text(
                            "Extras",
                            style: new TextStyle(
                                fontSize: 12.0,
                                color: const Color(0xFFffffff),
                                fontWeight: FontWeight.w200,
                                fontFamily: "Roboto"),
                          )
                        ])
                  ]);
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            // By default, show a loading spinner.
            return CircularProgressIndicator();
          },
          future: futureClassificacao,
        ),
      ),
    );
  }
}
/*
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<Classificacao> futureClassificacao;

  void fabPressed() {}

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('BUNDOES APP HUEHEUEH'),
      ),
      body: new Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Image.network(
              'https://github.com/flutter/website/blob/master/_includes/code/layout/lakes/images/lake.jpg?raw=true',
              fit: BoxFit.fill,
              width: 67.0,
              height: 67.0,
            ),
            Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Text(
                    "Nome do time",
                    style: new TextStyle(
                        fontSize: 18.0,
                        color: const Color(0xFF000000),
                        fontWeight: FontWeight.w500,
                        fontFamily: "Roboto"),
                  ),
                  new Text(
                    "campeonato x - posição x, x pontos, x% de aproveitamento",
                    style: new TextStyle(
                        fontSize: 8.0,
                        color: const Color(0xFF000000),
                        fontWeight: FontWeight.w500,
                        fontFamily: "Roboto"),
                  ),
                  new Text(
                    "último resultado vitória por 1- 0 contra time y ",
                    style: new TextStyle(
                        fontSize: 8.0,
                        color: const Color(0xFF000000),
                        fontWeight: FontWeight.w500,
                        fontFamily: "Roboto"),
                  )
                ])
          ]),
    );
  }
}
*/
