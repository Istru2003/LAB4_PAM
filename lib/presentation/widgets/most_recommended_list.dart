import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import '../../../../domain/entities/barbershop.dart';
import '../widgets/barbershop_card.dart';
import '../../../../data/models/barbershop_model.dart';

class MostRecommendedList extends StatefulWidget {
  @override
  _MostRecommendedListState createState() => _MostRecommendedListState();
}

class _MostRecommendedListState extends State<MostRecommendedList> {
  List<Barbershop> featuredBarbershops = [];
  bool _showAll = false;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadFeaturedBarbershops();
  }

  Future<void> loadFeaturedBarbershops() async {
    String jsonString = await rootBundle.loadString('assets/json/v2.json');
    final Map<String, dynamic> jsonData = json.decode(jsonString);

    final List<dynamic> barbershopData = jsonData['most_recommended'];

    setState(() {
      featuredBarbershops = barbershopData
          .map((json) => BarbershopModel.fromJson(json))
          .toList();
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: _showAll ? featuredBarbershops.length : (featuredBarbershops.length < 3 ? featuredBarbershops.length : 3),
          itemBuilder: (context, index) {
            return BarbershopCard(barbershop: featuredBarbershops[index]);
          },
        ),
        Center(
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                _showAll = !_showAll;
              });
            },
            child: Text(_showAll ? 'Show Less' : 'See All'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class SeeAllButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Color? buttonColor;
  final Color? textColor;

  const SeeAllButton({
    Key? key,
    this.onPressed,
    this.buttonColor = Colors.deepPurple,
    this.textColor = Colors.white
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
        foregroundColor: textColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('See All'),
          SizedBox(width: 8),
          Icon(Icons.arrow_forward, size: 16),
        ],
      ),
    );
  }
}

class CenteredSeeAllButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const CenteredSeeAllButton({Key? key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SeeAllButton(onPressed: onPressed),
    );
  }
}