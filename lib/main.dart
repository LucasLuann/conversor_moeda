import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:async';

import 'dart:convert';

const request = "https://api.hgbrasil.com/finance?key=b8ff9e23";

void main() async {
  print(await getData());

  runApp(
    MaterialApp(
      home: Home(),
      theme: ThemeData(
        hintColor: Colors.amber,
        primaryColor: Colors.white,
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.amber)),
          hintStyle: TextStyle(color: Colors.amber),
        ),
      ),
    ),
  );
}

Future<Map> getData() async {
  http.Response response = await http.get(Uri.parse(request));
  return json.decode(response.body);
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double? dolar;
  double? euro;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("\$ Conversor de Moeda \$"),
        backgroundColor: Colors.amber,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: FutureBuilder<Map>(
          future: getData(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Center(
                  child: Text(
                    "Carregando Dados...",
                    style: TextStyle(color: Colors.amber, fontSize: 25.0),
                    textAlign: TextAlign.center,
                  ),
                );
              default:
                if (snapshot.hasError) {
                  return Center(
                      child: Text(
                    "Erro ao Carregar Dados... :(",
                    style: TextStyle(
                      color: Colors.amber,
                      fontSize: 25.0,
                    ),
                    textAlign: TextAlign.center,
                  ));
                } else {
                  dolar = snapshot.data!["results"]["currencies"]["USD"]["buy"];
                  euro = snapshot.data!["results"]["currencies"]["EUR"]["buy"];
                  return SingleChildScrollView(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Icon(
                          Icons.monetization_on,
                          size: 150.0,
                          color: Colors.amber,
                        ),
                        Divider(),
                        TextField(
                          decoration: InputDecoration(
                              labelText: "Reais",
                              labelStyle: TextStyle(color: Colors.amber),
                              border: OutlineInputBorder(),
                              prefixText: "R\$"),
                          style: TextStyle(
                            color: Colors.amber,
                            fontSize: 25.0,
                          ),
                        ),
                        Divider(),
                        TextField(
                          decoration: InputDecoration(
                              labelText: "Dólares",
                              labelStyle: TextStyle(color: Colors.amber),
                              border: OutlineInputBorder(),
                              prefixText: "US\$"),
                          style: TextStyle(
                            color: Colors.amber,
                            fontSize: 25.0,
                          ),
                        ),
                        Divider(),
                        TextField(
                          decoration: InputDecoration(
                              labelText: "Euros",
                              labelStyle: TextStyle(color: Colors.amber),
                              border: OutlineInputBorder(),
                              prefixText: "EUR\$"),
                          style: TextStyle(
                            color: Colors.amber,
                            fontSize: 25.0,
                          ),
                        )
                      ],
                    ),
                  );
                }
            }
          }),
    );
  }
}
