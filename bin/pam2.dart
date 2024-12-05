import 'package:flutter/material.dart';

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
                    '23',
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
  final List<Drink> drinks = [
    Drink(
      name: '2021 Château Margaux',
      type: 'White wine',
      origin: 'From Champagne Blanc',
      price: 118,
      isAvailable: true,
      criticsScore: 92,
      tags: ['Green and Flinty'],
      imagePath:
      'https://admin.artizanaten.ro/assets/uploads/product/2021/03/360x720/Bor_2021_-1.JPG',
    ),
    Drink(
      name: '2018 Domaine de la Romanée-Conti',
      type: 'Sparkling wine',
      origin: 'From Champagne Blanc',
      price: 238,
      isAvailable: true,
      criticsScore: 88,
      tags: [],
      imagePath:
      'https://images.vivino.com/thumbs/4lgTwiYgQb6FA_Vfjp3G2A_pb_600x600.png',
    ),
    Drink(
      name: '2021 Château Lafite Rothschild ',
      type: 'Rosé wine',
      origin: 'From Champagne Blanc',
      price: 25,
      isAvailable: false,
      criticsScore: 90,
      tags: ['Green and Flinty'],
      imagePath:
      'https://i0.wp.com/vincuvin.shop/wp-content/uploads/2023/01/AtMount_Feteasca_Alba_Vincuvin.png?resize=450%2C450&ssl=1',
    ),
    Drink(
      name: '2020 Vouvray Bianco IGT',
      type: 'Red wine',
      origin: 'From Champagne Blanc',
      price: 45,
      isAvailable: false,
      criticsScore: 84,
      tags: ['Green and Flinty'],
      imagePath:
      'https://vincuvin.shop/wp-content/uploads/2023/01/AtMount_Cabernet_Sauvignon_Merlot_Vincuvin.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: drinks.length,
      itemBuilder: (context, index) {
        return DrinkCard(drink: drinks[index]);
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
                  ...drink.tags
                      .map((tag) => Chip(
                    label: Text(tag, style: TextStyle(fontSize: 10)),
                    backgroundColor: Colors.grey[200],
                  ))
                      .toList(),
                  Text('€ ${drink.price.toString()}',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Row(
                    children: [
                      Text('Critics\' Score: ',
                          style: TextStyle(color: Colors.grey)),
                      Text('${drink.criticsScore}/100',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              children: [
                IconButton(
                  icon: Icon(
                      drink.isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: Colors.red),
                  onPressed: () {
                    // Toggle favorite
                  },
                ),
                Text(drink.isFavorite ? 'Added' : 'Favourite',
                    style: TextStyle(fontSize: 12)),
              ],
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
}
