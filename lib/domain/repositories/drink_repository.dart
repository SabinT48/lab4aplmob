// lib/domain/repositories/drink_repository.dart
import '../entities/drink.dart';

abstract class DrinkRepository {
  Future<List<Drink>> getDrinks();
}
