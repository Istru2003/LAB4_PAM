import 'package:flutter/material.dart';
import '../../domain/entities/barbershop.dart';

class BarbershopCard extends StatelessWidget {
  final Barbershop barbershop;

  const BarbershopCard({Key? key, required this.barbershop}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            barbershop.image,
            width: 80,
            height: 80,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: 60,
                height: 60,
                color: Colors.grey,
                child: Icon(Icons.error),
              );
            },
          ),
        ),
        title: Text(barbershop.name),
        subtitle: Text(barbershop.locationWithDistance),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.star, color: Colors.yellow),
            Text(barbershop.reviewRate.toString()),
          ],
        ),
      ),
    );
  }
}