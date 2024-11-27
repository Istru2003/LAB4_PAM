import 'package:flutter/material.dart';
import '../../../domain/entities/barbershop.dart';
import '../../../domain/repositories/barbershop_repository.dart';
import '../../../data/repositories/barbershop_repository_impl.dart';
import '../widgets/barbershop_card.dart';
import '../widgets/booking_card.dart';
import '../widgets/search_dialog.dart';
import '../widgets/most_recommended_list.dart';
import '../widgets/featured_barbershop_card.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final BarbershopRepository _repository = BarbershopRepositoryImpl();
  List<Barbershop> allBarbershops = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final barbershops = await _repository.getAllBarbershops();
    setState(() {
      allBarbershops = barbershops;
      isLoading = false;
    });
  }

  void showSearchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SearchDialog(
          repository: _repository,
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              BookingCard(),
              _buildSearchBar(),
              _buildNearestBarbershops(),
              // Most Recommended Section
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Most Recommended',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              FeaturedBarbershopCard(repository: _repository),
              MostRecommendedList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.location_on, color: Color(0xFF9D9DFF)),
                  SizedBox(width: 4),
                  Text(
                    'Yogyakarta',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Text(
                'Joe Samanta',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          CircleAvatar(
            backgroundImage: AssetImage('assets/images/photo_4_2024-09-23_18-56-35.jpg'),
            radius: 25,
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => showSearchDialog(context),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    Icon(Icons.search, color: Colors.grey),
                    SizedBox(width: 8),
                    Text(
                      "Search barber's, haircut ser...",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(width: 12),
          _buildFilterButton(),
        ],
      ),
    );
  }

  Widget _buildFilterButton() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.deepPurple,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.deepPurple.withOpacity(0.3),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            // Add filter action
          },
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: EdgeInsets.all(12),
            child: Icon(
              Icons.tune,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNearestBarbershops() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Nearest Barbershop',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: allBarbershops.length < 3 ? allBarbershops.length : 3,
          itemBuilder: (context, index) {
            return BarbershopCard(barbershop: allBarbershops[index]);
          },
        ),
      ],
    );
  }
}