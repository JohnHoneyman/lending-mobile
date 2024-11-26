import 'package:flutter/material.dart';
import 'package:lendingmobile/core/common/index.dart';
import 'package:lendingmobile/features/profile/index.dart';

class PersonalInfoPage extends StatelessWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const PersonalInfoPage(),
      );
  const PersonalInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final profileItems = [
      {
        'infoName': 'Personal Information',
        'route': PersonalInformationFormPage.route(),
      },
      {
        'infoName': 'Valid IDs',
        'route': ValidIdsFormPage.route(),
      },
      {
        'infoName': 'Residential Address',
        'route': ResidentialAddressPage.route(),
      },
      {
        'infoName': 'Proof of Income',
        'route': ProofOfIncomeFormsPage.route(),
        'isVerified': true,
      },
      {
        'infoName': 'Existing Loans (if any)',
        'route': FinancialObligationsFormPage.route(),
      },
      {
        'infoName': 'Credit Cards (if any)',
        'route': ActiveCreditCardFormPage.route(),
      },
      {
        'infoName': 'Recurring monthly expenses (if any)',
        'route': RecurringMonthlyExpenses.route(),
      },
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffeeeeee),
      ),
      backgroundColor: const Color(0xffeeeeee),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: keycloakWrapper.getUserInfo(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          final userData = snapshot.data ?? {};
          final userName = userData['name'] ?? 'John Cena';
          final userEmail = userData['email'] ?? 'johncena@gmail.com';

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView(
              children: [
                Container(
                  height: 72,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Account Verification',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff573D9B),
                        ),
                      ),
                      CircularProgressIndicator(
                        value: 0.6,
                        backgroundColor: Colors.grey,
                      )
                    ],
                  ),
                ),
                const Gap(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              color: const Color(0xff573D9B),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: const Icon(
                              Icons.person,
                              color: Colors.white,
                              size: 35,
                            ),
                          ),
                          const Gap(width: 8),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                userName,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                userEmail,
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 8,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: const Color(0xff65558f),
                        ),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.edit_outlined,
                              color: Colors.white,
                              size: 16,
                            ),
                            Gap(width: 4),
                            Text(
                              'Edit',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Gap(height: 8),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: profileItems.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        ProfileInfoTypeWidget(
                          infoName: profileItems[index]['infoName'] as String,
                          isVerified:
                              profileItems[index]['isVerified'] ?? false,
                          onTap: () => Navigator.push(
                            context,
                            profileItems[index]['route'] as Route,
                          ),
                        ),
                        const Gap(height: 8),
                      ],
                    );
                  },
                ),
                Container(
                  height: 72,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Credit Score',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const Gap(height: 8),
              ],
            ),
          );
        },
      ),
    );
  }
}
