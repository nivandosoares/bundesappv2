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
      theme: ThemeData(
        primarySwatch: Colors.blue,
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
        title: Text("Testanto dados do primeiro colocado"),
      ),
      body: Container(
        child: Center(
          child: FutureBuilder<Classificacao>(
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data.clube.length,
                    itemBuilder: (context, index) {
                      Clube times = snapshot.data.clube[index];
                      return Column(
                        children: <Text>[
                          Text(
                              'pos : ' +
                                  times.posicao.toString() +
                                  ' ' +
                                  times.time.toString() +
                                  '\n\n',
                              style: TextStyle(fontSize: 20.0))
                        ],
                      );
                    });
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner.
              return CircularProgressIndicator();
            },
            future: futureClassificacao,
          ),
        ),
      ),
    );
  }
}
