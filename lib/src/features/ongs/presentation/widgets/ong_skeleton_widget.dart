import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class OngSkeletonWidget extends StatelessWidget {
  const OngSkeletonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ListTile(
            contentPadding: const EdgeInsets.all(10),
            leading: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
            title: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                height: 16,
                width: 150,
                color: Colors.grey,
              ),
            ),
            subtitle: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                height: 12,
                width: 200,
                color: Colors.grey,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    height: 1,
                    color: Colors.grey,
                    width: double.infinity,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: List.generate(4, (index) {
                          return Padding(
                            padding: EdgeInsets.only(left: index * 8.0),
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(
                                width: 16,
                                height: 16,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        height: 16,
                        width: 70,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
