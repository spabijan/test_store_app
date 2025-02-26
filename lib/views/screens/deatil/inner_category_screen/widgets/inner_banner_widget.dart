import 'package:flutter/material.dart';

class InnerBannerScreen extends StatelessWidget {
  const InnerBannerScreen({
    required this.imageUrl,
    super.key,
  });

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170,
      width: MediaQuery.of(context).size.width,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(imageUrl, fit: BoxFit.cover)),
    );
  }
}
