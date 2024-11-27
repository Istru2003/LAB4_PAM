import '../entities/barbershop.dart';

abstract class BarbershopRepository {
  Future<List<Barbershop>> getNearestBarbershops();
  Future<List<Barbershop>> getMostRecommendedBarbershops();
  Future<List<Barbershop>> getFeaturedBarbershops();
  Future<List<Barbershop>> getAllBarbershops();
  Future<List<Barbershop>> searchBarbershops(String query);
}