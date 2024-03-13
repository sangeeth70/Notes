
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final double? height;
  final double? width;
  final VoidCallback? onTap;
  final bool isSaved;
  const CustomButton({super.key, required this.title, this.height, this.width, this.onTap, required this.isSaved});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        alignment: Alignment.center,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSaved ? Color(0xff202020) : Colors.white,
          border: Border.all(width: 1,color: isSaved ? Color(0xff3C3C3C) : Colors.transparent),
          borderRadius: BorderRadius.circular(10)
        ),
        child: Text(title,style: TextStyle(fontFamily: 'Mukta',fontSize: 14,color: isSaved ? Color(0xff737373) : Colors.black),),
      ),
    );
  }
}
