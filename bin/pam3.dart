import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

void main() {
  runApp(DrinkStoreApp());
}

class DrinkStoreApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Drink Store',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.location_on),
            SizedBox(width: 8),
            Text('Donnerville Drive'),
            Icon(Icons.arrow_drop_down),
          ],
        ),
        actions: [
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.notifications_none),
                onPressed: () {},
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  constraints: BoxConstraints(
                    minWidth: 16,
                    minHeight: 16,
                  ),
                  child: Text(
                    '19',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: Icon(Icons.search),
                suffixIcon: Icon(Icons.mic),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Text('Shop wines by',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(width: 10),
                Chip(
                  label: Text('Type',
                      style: TextStyle(color: Colors.white, fontSize: 12)),
                  backgroundColor: Colors.pink,
                  padding: EdgeInsets.symmetric(horizontal: 4),
                ),
                SizedBox(width: 10),
                Chip(
                  label: Text('Style', style: TextStyle(fontSize: 12)),
                  backgroundColor: Colors.grey[200],
                  padding: EdgeInsets.symmetric(horizontal: 4),
                ),
                SizedBox(width: 10),
                Chip(
                  label: Text('Countries', style: TextStyle(fontSize: 12)),
                  backgroundColor: Colors.grey[200],
                  padding: EdgeInsets.symmetric(horizontal: 4),
                ),
                SizedBox(width: 10),
                Chip(
                  label: Text('Grape', style: TextStyle(fontSize: 12)),
                  backgroundColor: Colors.grey[200],
                  padding: EdgeInsets.symmetric(horizontal: 4),
                ),
              ],
            ),
          ),
          SizedBox(height: 8),
          Flexible(
            child: DrinkList(),
          ),
        ],
      ),
    );
  }
}

class DrinkList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Drink>>(
      future: loadDrinks(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No drinks available'));
        }

        final drinks = snapshot.data!;
        return ListView.builder(
          itemCount: drinks.length,
          itemBuilder: (context, index) {
            return DrinkCard(drink: drinks[index]);
          },
        );
      },
    );
  }
}

class DrinkCard extends StatelessWidget {
  final Drink drink;

  DrinkCard({required this.drink});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Row(
          children: [
            Image.network(
              drink.imagePath,
              width: 80,
              height: 120,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 80,
                  height: 120,
                  color: Colors.grey[300],
                  child: Icon(Icons.error),
                );
              },
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding:
                        EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        color: drink.isAvailable ? Colors.green : Colors.red,
                        child: Text(
                          drink.isAvailable ? 'Available' : 'Unavailable',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Text(drink.name,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Row(
                    children: [
                      Icon(Icons.wine_bar, size: 16, color: Colors.grey),
                      SizedBox(width: 4),
                      Text(drink.type, style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                  SizedBox(height: 4),
                  Text(drink.origin, style: TextStyle(color: Colors.grey)),
                  ...drink.tags.map((tag) => Chip(label: Text(tag))).toList(),
                  Text('\$${drink.price}',
                      style: TextStyle(color: Colors.blue)),
                ],
              ),
            ),
            IconButton(
              icon: Icon(
                drink.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: drink.isFavorite ? Colors.pink : Colors.grey,
              ),
              onPressed: () {
                // Mark as favorite
              },
            ),
          ],
        ),
      ),
    );
  }
}

class Drink {
  final String name;
  final String type;
  final String origin;
  final int price;
  final bool isAvailable;
  final int criticsScore;
  final List<String> tags;
  final String imagePath;
  bool isFavorite;

  Drink({
    required this.name,
    required this.type,
    required this.origin,
    required this.price,
    required this.isAvailable,
    required this.criticsScore,
    required this.tags,
    required this.imagePath,
    this.isFavorite = false,
  });

  factory Drink.fromJson(Map<String, dynamic> json) {
    return Drink(
      name: json['name'],
      type: json['type'],
      origin: json['origin'],
      price: json['price'],
      isAvailable: json['isAvailable'],
      criticsScore: json['criticsScore'],
      tags: List<String>.from(json['tags']),
      imagePath: json['imagePath'],
      isFavorite: json['isFavorite'] ?? false,
    );
  }
}

Future<List<Drink>> loadDrinks() async {
  final String response =
  await rootBundle.loadString('assets/drinks_data.json');
  final List<dynamic> data = json.decode(response)['drinks'];
  return data.map((drinkData) => Drink.fromJson(drinkData)).toList();
}