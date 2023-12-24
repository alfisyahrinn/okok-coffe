import 'package:flutter/material.dart';
import '../utils/color.dart';

class Loading extends StatelessWidget {
  const Loading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 24,
      width: 24,
      child: CircularProgressIndicator(
        backgroundColor: Colors.white,
        color: MyColor.secondary,
        strokeWidth: 4,
      ),
    );
  }
}
