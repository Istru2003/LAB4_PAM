class Barbershop {
  final String name;
  final String locationWithDistance;
  final String image;
  final double reviewRate;
  final int? totalUsers;

  Barbershop({
    required this.name,
    required this.locationWithDistance,
    required this.image,
    required this.reviewRate,
    this.totalUsers,
  });
}