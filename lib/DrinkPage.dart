import 'dart:html';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async' show Future;
import 'dart:convert';

class DrinkPage extends StatefulWidget {
  DrinkPage();

  @override
  _DrinkPageState createState() => _DrinkPageState();
}

class _DrinkPageState extends State<DrinkPage> {
  _DrinkPageState();

  late Future<String> jsonString;
  late Future<String> drinkString;

  @override
  void initState() {
    super.initState();

    drinkString = _loadRemoteIndex();
  }

  @override
  Widget build(BuildContext context) {
    final title = 'Drink';
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: FutureBuilder<String>(
            future: drinkString,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                Map<String, dynamic> drinks =
                    jsonDecode(snapshot.data!.characters.string);
                return Column(children: [
                  Text('Name:  ${drinks['drinks'][0]['strDrink']}'),
                  Text(
                      'Ingredient 1:  ${drinks['drinks'][0]['strIngredient1']}( ${drinks['drinks'][0]['strMeasure1']})'),
                  Text(
                      'Ingredient 2:  ${drinks['drinks'][0]['strIngredient2']}( ${drinks['drinks'][0]['strMeasure2']})'),
                  Text(
                      'Ingredient 3:  ${drinks['drinks'][0]['strIngredient3']}( ${drinks['drinks'][0]['strMeasure3']})'),
                  Text(
                      'Ingredient 4:  ${drinks['drinks'][0]['strIngredient4']}( ${drinks['drinks'][0]['strMeasure4']})'),
                  Text(
                      'Instructions:  ${drinks['drinks'][0]['strInstructions']}')
                ]);
              } else if (snapshot.hasError) {
                return Text('error');
              }
              return CircularProgressIndicator();
            }));
  }
}

Future<String> _loadRemoteIndex() async {
  final token = 'c3q4f9qad3i8q4a5858g';
  final response = await (http.get(
      Uri.parse('https://www.thecocktaildb.com/api/json/v1/1/random.php')));

  if (response.statusCode == 200) {
    return response.body;
  } else {
    print('Http Error: ${response.statusCode}!');
    throw Exception('Invalid data source.');
  }
}
