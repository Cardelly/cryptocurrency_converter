import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'dart:convert';

import '../model/data.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String currency = 'Selecione uma moeda';
  double price = 0.0;
  Data data = Data();
  bool isLoading = false;
  Map<String, dynamic> d = {
    "BTC": {"BRL": 0},
    "ETH": {"BRL": 0},
    "XRP": {"BRL": 0},
  };

  void getCurrencies() async {
    setState(() {
      isLoading = true;
    });
    var url = Uri.parse(
        "https://min-api.cryptocompare.com/data/pricemulti?fsyms=BTC,ETH,XRP&tsyms=$currency");
    http.Response response = await http.get(url);
    Map<String, dynamic> data = json.decode(response.body);
    setState(() {
      d = data;
      isLoading = false;
    });
  }

  void bottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          color: ThemeData.dark().primaryColor,
          child: ListView.builder(
            itemCount: data.currencies.length,
            itemBuilder: (context, index) {
              // var k = d.keys.toList();
              return ListTile(
                leading: Icon(Icons.emoji_flags),
                title: Text(data.currencies[index]),
                onTap: () {
                  currency = data.currencies[index];
                  getCurrencies();
                  Navigator.pop(context);
                },
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : SafeArea(
            child: Scaffold(
              body: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(child: Container()),
                  Image.asset(
                    '../../assets/images/Logo.png',
                    height: 100,
                  ),
                  Expanded(child: Container()),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30.0, 10, 30, 10),
                    child: Card(
                      color: ThemeData.dark().primaryColor,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text('Bitcoin (BTC)'),
                            Expanded(
                              child: TextButton(
                                child: Text(
                                    '$currency - ${d["BTC"][currency] ?? ' 0'}'),
                                onPressed: bottomSheet,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30.0, 10, 30, 10),
                    child: Card(
                      color: ThemeData.dark().primaryColor,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text('Ethereum (ETH)'),
                            Expanded(
                              child: TextButton(
                                child: Text(
                                    '$currency - ${d["ETH"][currency] ?? ' 0'}'),
                                onPressed: bottomSheet,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30.0, 10, 30, 10),
                    child: Card(
                      color: ThemeData.dark().primaryColor,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text('Monero (XRP)'),
                            Expanded(
                              child: TextButton(
                                child: Text(
                                    '$currency - ${d["XRP"][currency] ?? ' 0'}'),
                                onPressed: bottomSheet,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(child: Container()),
                  DefaultTextStyle(
                    style: TextStyle(color: Colors.grey),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Column(
                        children: [
                          Text('Matheus Henrique Silva Miranda'),
                          Text('Phillippy Cardelly Albuquerque dos Santos'),
                          Text('Vitor Azevedo Silva'),
                          Text('Wesley Costa da Silva'),
                        ],
                      ),
                    ),
                  ),
                  Expanded(child: Container()),
                ],
              ),
              floatingActionButton: FloatingActionButton(
                backgroundColor: ThemeData.dark().primaryColor,
                foregroundColor: ThemeData.dark().accentColor,
                onPressed: bottomSheet,
                child: Icon(
                  Icons.arrow_upward,
                ),
              ),
            ),
          );
  }
}
