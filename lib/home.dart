import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String _preco = "0";
  String _precoUSD = "0";
  String _precoEUR = "0";

  void _recuperarPreco() async{

    String url = "https://blockchain.info/ticker";
    http.Response response = await http.get(url);

    Map<String, dynamic> retorno = json.decode(response.body);
    print(retorno["BRL"]["buy"].toString());
    setState(() {
      _preco = retorno["BRL"]["buy"].toString();
      _precoEUR = retorno["EUR"]["buy"].toString();
      _precoUSD = retorno["USD"]["buy"].toString();

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(32),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset("images/bitcoin.png"),
              Padding(
                padding: EdgeInsets.only(top: 30, bottom: 30),
                child: Text(
                  "R\$ $_preco \nU\$D $_precoUSD \nEUR $_precoEUR",
                  style: TextStyle(
                    fontSize: 35,
                  ),
                ),
              ),
              RaisedButton(
                child: Text(
                    "Atualizar",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white
                  ),
                ),
                color: Colors.orange,
                padding: EdgeInsets.fromLTRB(30, 15, 30, 15),
                onPressed: _recuperarPreco,
              ),
            ],
          ),
        ),
      ),

    );
  }
}
