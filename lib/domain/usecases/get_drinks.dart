// lib/domain/usecases/get_drinks.dart
import '../repositories/drink_repository.dart';
import '../entities/drink.dart';

class GetDrinks {
  final DrinkRepository repository;

  GetDrinks(this.repository);

  Future<List<Drink>> execute() {
    return repository.getDrinks();
  }
}
