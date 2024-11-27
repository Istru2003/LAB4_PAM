import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import '../../../../domain/entities/barbershop.dart';
import '../../../../domain/repositories/barbershop_repository.dart';
import '../../../../data/models/barbershop_model.dart';

class FeaturedBarbershopCard extends StatefulWidget {
  final BarbershopRepository repository; 

  const FeaturedBarbershopCard({Key? key, required this.repository}) : super(key: key);

  @override
  _FeaturedBarbershopCardState createState() => _FeaturedBarbershopCardState();
}

class _FeaturedBarbershopCardState extends State<FeaturedBarbershopCard> {
  late PageController _pageController;
  int _currentPage = 0;
  List<Barbershop> featuredBarbershops = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0, viewportFraction: 1.0);
    loadFeaturedBarbershops();
  }

  Future<void> loadFeaturedBarbershops() async {
    String jsonString = await rootBundle.loadString('assets/json/v2.json');
    final Map<String, dynamic> jsonData = json.decode(jsonString);

    final List<dynamic> barbershopData = jsonData['list'];

    setState(() {
      featuredBarbershops = barbershopData
          .map((json) => BarbershopModel.fromJson(json))
          .toList();
      isLoading = false;
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return SizedBox(
        height: 350,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (featuredBarbershops.isEmpty) {
      return SizedBox(
        height: 350,
        child: Center(child: Text('No featured barbershops available')),
      );
    }

    return Column(
      children: [
        SizedBox(
          height: 350,
          child: PageView.builder(
            controller: _pageController,
            itemCount: featuredBarbershops.length,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            itemBuilder: (context, index) {
              final barbershop = featuredBarbershops[index];
              return _buildBarbershopCard(barbershop);
            },
          ),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            featuredBarbershops.length,
            (index) => Container(
              width: 8,
              height: 8,
              margin: EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentPage == index ? Colors.deepPurple : Colors.grey.shade300,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBarbershopCard(Barbershop barbershop) {
    return Card(
      margin: EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                child: Image.network(
                  barbershop.image,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 200,
                      width: double.infinity,
                      color: Colors.grey.shade300,
                      child: Icon(Icons.image_not_supported, size: 50),
                    );
                  },
                ),
              ),
              Positioned(
                bottom: 10,
                right: 10,
                child: ElevatedButton(
                  onPressed: () {
                    // Add booking functionality
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Booking'),
                      SizedBox(width: 8),
                      Icon(Icons.event, size: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  barbershop.name,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.location_on, size: 16, color: Colors.grey),
                    SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        barbershop.locationWithDistance,
                        style: TextStyle(color: Colors.grey),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Icon(Icons.star, size: 16, color: Colors.yellow),
                    SizedBox(width: 4),
                    Text(
                      barbershop.reviewRate.toString(),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
