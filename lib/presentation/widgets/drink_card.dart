import 'package:flutter/material.dart';
import 'package:pam1/domain/entities/drink.dart';

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
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(drink.name, style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(drink.type),
                  Text('\$${drink.price}'),
                  Text(drink.origin),
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
