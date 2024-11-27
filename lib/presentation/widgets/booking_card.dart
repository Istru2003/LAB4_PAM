import 'package:flutter/material.dart';

class BookingCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        width: double.infinity,
        height: 230,
        decoration: BoxDecoration(
          color: Colors.orange,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  'assets/images/barbershop-seamless-pattern-black-on-white-repeating-pattern-print-for-men-s-barber-shop-a-set-of-accessories-for-men-s-hairdresser-on-white-background-vector.jpg',
                  fit: BoxFit.cover,
                  opacity: AlwaysStoppedAnimation(0.1),
                ),
              ),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(10),
                ),
                child: Image.asset(
                  'assets/images/photo_5_2024-09-23_18-56-35.png',
                  height: 210,
                  width: 210,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/images/Снимок экрана 2024-09-23 191707.png',
                    height: 70,
                    width: 70,
                  ),
                  Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      // Add booking action
                    },
                    child: Text(
                      'Booking Now',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}