import 'package:flutter/material.dart';

class DualScript extends StatelessWidget {
  final String roman;
  final String devanagari;
  final double romanSize;
  const DualScript({super.key, required this.roman, required this.devanagari, this.romanSize = 16});
  @override
  Widget build(BuildContext context) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text(roman, style: TextStyle(fontSize: romanSize, fontWeight: FontWeight.w700)),
    const SizedBox(height: 2),
    Text(devanagari, style: TextStyle(fontSize: romanSize - 3, color: Colors.black54)),
  ]);
}
