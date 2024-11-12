import 'package:flutter/material.dart';
import 'package:lendingmobile/core/common/index.dart';
import 'package:lendingmobile/features/profile/index.dart';

class ProfilePage extends StatelessWidget {
  final dynamic snapshotData;
  const ProfilePage({
    super.key,
    required this.snapshotData,
  });

  Future<bool> logout() async {
    // Check if user has successfully logged out.
    final isLoggedOut = await keycloakWrapper.logout();

    return isLoggedOut;
  }

  @override
  Widget build(BuildContext context) {
    final name = snapshotData.data?['name'] ?? '';
    final givenName = snapshotData.data?['given_name'] ?? '';
    final familyName = snapshotData.data?['family_name'] ?? '';
    final email = snapshotData.data?['email'] ?? '';
    return Container(
      decoration: const BoxDecoration(color: Color(0xff65558F)),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Profile',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 24),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: const Icon(
                      Icons.person,
                      color: Color(0xff65558F),
                      size: 32,
                    ),
                  ),
                  const Gap(
                    height: 0,
                    width: 8,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        email,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35),
                ),
              ),
              child: Column(
                children: [
                  const Gap(
                    height: 32,
                  ),
                  ProfileInkwell(
                    text: 'Personal Information',
                    icon: Icons.person_4_outlined,
                    onTap: () {
                      Navigator.push(context, PersonalInfoPage.route());
                    },
                  ),
                  ProfileInkwell(
                    text: 'Loan History',
                    icon: Icons.monetization_on_outlined,
                    onTap: () {},
                  ),
                  ProfileInkwell(
                    text: 'Password & Security',
                    icon: Icons.shield_outlined,
                    onTap: () {},
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: SizedBox(
                      height: 50,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Other',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                  ProfileInkwell(
                    text: 'FAQ',
                    icon: Icons.question_mark_rounded,
                    onTap: () {},
                  ),
                  ProfileInkwell(
                    text: 'Terms, Conditions and Privacy Policy',
                    icon: Icons.check_box_outlined,
                    onTap: () {},
                  ),
                  ProfileInkwell(
                    text: 'Help Center',
                    icon: Icons.front_hand_outlined,
                    onTap: logout,
                  ),
                  ProfileInkwell(
                    text: 'Log Out Your Account',
                    icon: Icons.power_settings_new,
                    onTap: logout,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
