import 'package:flutter/material.dart';
import '../../../../domain/entities/barbershop.dart';
import '../../../../domain/repositories/barbershop_repository.dart';
import '../widgets/barbershop_card.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import '../../../../data/models/barbershop_model.dart';
import 'all_barbershops_page.dart';

class NearestBarbershopList extends StatefulWidget {
  final BarbershopRepository repository;

  const NearestBarbershopList({Key? key, required this.repository})
      : super(key: key);

  @override
  _NearestBarbershopListState createState() => _NearestBarbershopListState();
}

class _NearestBarbershopListState extends State<NearestBarbershopList> {
  List<Barbershop> nearestBarbershops = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadBarbershops();
  }

  Future<void> loadBarbershops() async {
    String jsonString = await rootBundle.loadString('assets/json/v2.json');
    final Map<String, dynamic> jsonData = json.decode(jsonString);

    final List<dynamic> barbershopData = jsonData['nearest_barbershop'];

    setState(() {
      nearestBarbershops = barbershopData
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
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Nearest Barbershop',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          )
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: nearestBarbershops.length < 3 ? nearestBarbershops.length : 3,
          itemBuilder: (context, index) {
            return BarbershopCard(barbershop: nearestBarbershops[index]);
          },
        ),
        Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AllBarbershopsPage(
                    barbershops: nearestBarbershops,
                  ),
                ),
              );
            },
            child: Text('See All'),
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