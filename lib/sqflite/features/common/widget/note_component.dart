import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoteComponent extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String)? onChanged;
  const NoteComponent({super.key, required this.controller, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      maxLines: 20,
      cursorColor: Colors.white,
      style: TextStyle(color: Colors.white,fontFamily: 'Mukta'),
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xff202020),
        hintText: 'description...',
        hintStyle: TextStyle(color: Color(0xff737373),fontFamily: 'Mukta',),
        enabled: true,
        focusColor: Colors.red,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(width: 1,color: Color(0xff3C3C3C)),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(width: 1,color: Color(0xff3C3C3C)),
        )
      ),
    );
  }
}
