import 'package:flutter/material.dart';
import 'package:rent_a_car/constants/dimensions.dart';

class BigText extends StatelessWidget {
  final Color? color;
  final String text;
  final double size;
  final TextOverflow overFlow;
  const BigText(
      {Key? key,
      this.color = const Color(0xFF332d2b),
      required this.text,
      this.overFlow = TextOverflow.ellipsis,
      this.size = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: overFlow,
      style: TextStyle(
        fontSize: size == 0 ? Dimensions.font20 : size,
        fontFamily: 'Roboto',
        color: color,
      ),
    );
  }
}
