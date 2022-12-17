import 'package:flutter/material.dart';

class ReservationItem extends StatelessWidget {
  const ReservationItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: const Color.fromARGB(100, 0, 0, 65),
          borderRadius: BorderRadius.circular(25)
      ),
      child: Row(
        children: const [
          Text(
            'User-Name : ',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600
            ),
          ),
          Text(
            '14/5/2022 3:35AM',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
