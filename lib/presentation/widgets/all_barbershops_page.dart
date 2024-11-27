import 'package:flutter/material.dart';
import '../../../../domain/entities/barbershop.dart';
import '../widgets/barbershop_card.dart';

class AllBarbershopsPage extends StatelessWidget {
  final List<Barbershop> barbershops;

  const AllBarbershopsPage({Key? key, required this.barbershops}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Barbershops', style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.deepPurple,
      ),
      body: ListView.builder(
        itemCount: barbershops.length,
        itemBuilder: (context, index) {
          return BarbershopCard(
            barbershop: barbershops[index],
          );
        },
      ),
    );
  }
}