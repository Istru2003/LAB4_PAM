import '../../domain/entities/barbershop.dart';

class BarbershopModel extends Barbershop {
  BarbershopModel({
    required String name,
    required String locationWithDistance,
    required String image,
    required double reviewRate,
    int? totalUsers,
  }) : super(
    name: name,
    locationWithDistance: locationWithDistance,
    image: image,
    reviewRate: reviewRate,
    totalUsers: totalUsers,
  );

  factory BarbershopModel.fromJson(Map<String, dynamic> json) {
    return BarbershopModel(
      name: json['name'] as String,
      locationWithDistance: json['location_with_distance'] as String,
      image: json['image'] as String,
      reviewRate: (json['review_rate'] as num).toDouble(),
      totalUsers: json['totalUsers'] as int?,
    );
  }
}
