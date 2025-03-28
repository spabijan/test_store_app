import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:test_store_app/r.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({
    required this.itemCount,
    required this.text,
    this.onBack,
    super.key,
  });

  final VoidCallback? onBack;
  final int itemCount;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 118,
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(AssetIcons.cartb), fit: BoxFit.cover)),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 52.0, left: 16, right: 32),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (onBack != null)
                  IconButton(
                      onPressed: onBack,
                      icon: const Icon(Icons.arrow_back, color: Colors.white)),
                Text(
                  text,
                  style: GoogleFonts.lato(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const Spacer(),
                Stack(clipBehavior: Clip.none, children: [
                  Image.asset(AssetIcons.cart, width: 25, height: 25),
                  if (itemCount > 0)
                    Positioned(
                      top: -8,
                      right: -8,
                      child: Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.yellow.shade800),
                        child: Center(
                            child: Text(itemCount.toString(),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10))),
                      ),
                    )
                ]),
              ],
            ),
          )
        ],
      ),
    );
  }
}
