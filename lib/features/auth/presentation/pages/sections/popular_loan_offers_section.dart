import 'package:flutter/material.dart';
import 'package:lendingmobile/core/common/index.dart';

class PopularLoanOffersSection extends StatelessWidget {
  const PopularLoanOffersSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Popular Loan Offers',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        const Gap(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Container(
                height: 150,
                width: 250,
                color: Colors.blueGrey,
              ),
              const Gap(height: 0, width: 16),
              Container(
                height: 150,
                width: 250,
                color: Colors.blueGrey,
              ),
              const Gap(height: 0, width: 16),
              Container(
                height: 150,
                width: 250,
                color: Colors.blueGrey,
              ),
            ],
          ),
        )
      ],
    );
  }
}
