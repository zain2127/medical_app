import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final Icon;
  final String categoryname;
  CategoryCard({required this.Icon, required this.categoryname});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Colors.blue[100],
            borderRadius: BorderRadius.circular(12)
        ),
        child: Row(
          children: [
            Image.asset(Icon,height: 40,),
            SizedBox(width: 10,),
            Text(categoryname)
          ],
        ),
      ),
    );
  }
}