import 'package:flutter/material.dart';
import 'package:pam1/domain/entities/drink.dart';
import 'package:pam1/presentation/widgets/drink_card.dart';
import 'package:pam1/data/repositories/drink_repository_impl.dart';
import 'package:pam1/domain/repositories/drink_repository.dart';

class HomePage extends StatelessWidget {
  final DrinkRepository drinkRepository = DrinkRepositoryImpl();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Drink Store'),
      ),
      body: FutureBuilder<List<Drink>>(
        future: drinkRepository.getDrinks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading drinks'));
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
      ),
    );
  }
}
