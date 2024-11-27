import 'dart:convert';
import 'package:flutter/services.dart';
import '../../domain/repositories/barbershop_repository.dart';
import '../../domain/entities/barbershop.dart';
import '../models/barbershop_model.dart';

class BarbershopRepositoryImpl implements BarbershopRepository {
  @override
  Future<List<Barbershop>> getNearestBarbershops() async {
    final jsonString = await rootBundle.loadString('assets/json/v2.json');
    final jsonData = json.decode(jsonString);
    final List<dynamic> barbershopData = jsonData['nearest_barbershop'];
    return barbershopData.map((json) => BarbershopModel.fromJson(json)).toList();
  }

  @override
  Future<List<Barbershop>> getMostRecommendedBarbershops() async {
    final jsonString = await rootBundle.loadString('assets/json/v2.json');
    final jsonData = json.decode(jsonString);
    final List<dynamic> barbershopData = jsonData['most_recommended'];
    return barbershopData.map((json) => BarbershopModel.fromJson(json)).toList();
  }

  @override
  Future<List<Barbershop>> getFeaturedBarbershops() async {
    final jsonString = await rootBundle.loadString('assets/json/v2.json');
    final jsonData = json.decode(jsonString);
    final List<dynamic> barbershopData = jsonData['list'];
    return barbershopData.map((json) => BarbershopModel.fromJson(json)).toList();
  }

  @override
  Future<List<Barbershop>> getAllBarbershops() async {
    final nearestBarbershops = await getNearestBarbershops();
    final recommendedBarbershops = await getMostRecommendedBarbershops();
    return [...nearestBarbershops, ...recommendedBarbershops];
  }

  @override
  Future<List<Barbershop>> searchBarbershops(String query) async {
    final allBarbershops = await getAllBarbershops();
    if (query.isEmpty) return [];
    return allBarbershops
        .where((barbershop) =>
        barbershop.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}
