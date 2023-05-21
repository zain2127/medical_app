import 'package:flutter/material.dart';

class Exercise_Card extends StatelessWidget {
  final Icon;
  final String categoryname;
  Exercise_Card({required this.Icon, required this.categoryname});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Colors.green[200],
            borderRadius: BorderRadius.circular(12)
        ),
        child: Row(
          children: [
            Image.asset(
              Icon,height: 40,),
            SizedBox(width: 10,),
            Text(categoryname,style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),)
          ],
        ),
      ),
    );
  }
}