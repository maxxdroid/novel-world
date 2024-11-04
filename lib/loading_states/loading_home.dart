import 'package:flutter/material.dart';

class LoadingHome extends StatelessWidget {
  const LoadingHome({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 0,
          childAspectRatio: .5,
        ),
      children: List.generate(10, (index) {
        return Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              color: Colors.grey.shade50,
              child: const SizedBox(height: 150, width: 100,),
            ),
            Container(
              width: 100,
              height: 20,
              color: Colors.grey.shade50,
            )
          ],
        );
      }),
    );
  }
}
