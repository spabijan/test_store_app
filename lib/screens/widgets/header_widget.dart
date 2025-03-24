import 'package:flutter/material.dart';
import 'package:test_store_app/r.dart';
import 'package:test_store_app/screens/home_screen/search_product_screen.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Image.asset(AssetIcons.searchbanner,
              width: MediaQuery.of(context).size.width, fit: BoxFit.cover),
          Positioned(
              left: 48,
              top: 64,
              child: Row(
                children: [
                  SizedBox(
                      width: 250,
                      height: 50,
                      child: TextField(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const SearchProductScreen())),
                        decoration: InputDecoration(
                            hintText: 'Input text',
                            prefixIcon: Image.asset(AssetIcons.searc1),
                            suffixIcon: Image.asset(AssetIcons.cam),
                            fillColor: Colors.grey.shade200,
                            focusColor: Colors.black,
                            filled: true,
                            hintStyle: const TextStyle(
                                fontSize: 14, color: Color(0xff7f7f7f)),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 8)),
                      )),
                  Opacity(
                    opacity: 0.9,
                    child: IconButton(
                        onPressed: () {},
                        icon: Center(
                          child: Image.asset(
                            AssetIcons.bell,
                            width: 31,
                            height: 31,
                          ),
                        )),
                  ),
                  Opacity(
                    opacity: 0.9,
                    child: IconButton(
                        onPressed: () {},
                        icon: Image.asset(
                          AssetIcons.message,
                          width: 31,
                          height: 31,
                        )),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
