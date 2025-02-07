import 'package:ethio_gpt/cors/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bool isDarkMod =
        Theme.of(context).scaffoldBackgroundColor == Colors.black;
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.9,
      child: ListView.builder(
        itemCount: 19,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 2),
            child: Shimmer.fromColors(
              baseColor: isDarkMod ? darkGray : Colors.grey,
              highlightColor: darkGray.withOpacity(0.5),
              child: Container(
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: isDarkMod ? Colors.white : Colors.black,
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
