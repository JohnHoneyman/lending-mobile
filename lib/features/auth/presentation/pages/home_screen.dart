import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lendingmobile/core/common/index.dart';
import 'package:lendingmobile/features/auth/presentation/pages/sections/popular_loan_offers_section.dart';
import 'package:lendingmobile/features/auth/presentation/pages/sections/whats_new_section.dart';
import 'package:lendingmobile/features/loan/index.dart';
import 'package:lendingmobile/features/profile/index.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> _onPullToRefresh() async {
    setState(() {
      keycloakWrapper.updateToken;
    });
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BotNavbarWidget(
        selectedIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      body: FutureBuilder(
        future: keycloakWrapper.getUserInfo(),
        builder: (context, snapshot) {
          final name = snapshot.data?['name'];
          log(keycloakWrapper.accessToken!);
          log(keycloakWrapper.toString());
          log(snapshot.data.toString());
          return SafeArea(
            child: RefreshIndicator(
              onRefresh: _onPullToRefresh,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: _selectedIndex == 0
                      ? Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(16, 40, 16, 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RichText(
                                    text: const TextSpan(
                                      text: 'Lending',
                                      style: TextStyle(
                                          color: Color(0xff65558f),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 40),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: 'App',
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text('Welcome, $name!'),
                                  const Gap(),
                                  Container(
                                    height: 150,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: const Color(0xffa49bba),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: const Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '100,000',
                                          style: TextStyle(
                                            fontSize: 40,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          'Remaining Balance',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Gap(),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(color: Colors.grey),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16.0, vertical: 8),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Monthly Bill',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              Text('Nov 11,2024')
                                            ],
                                          ),
                                          Gap(),
                                          Row(
                                            children: [
                                              Text(
                                                'PHP 8,667',
                                                style: TextStyle(
                                                  color: Color(0xff65558F),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              Icon(
                                                Icons
                                                    .keyboard_arrow_right_outlined,
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Gap(),
                            const PopularLoanOffersSection(),
                            const Gap(),
                            const WhatsNewSection(),
                          ],
                        )
                      : _selectedIndex == 1
                          ? AddLoanPage()
                          : ProfilePage(snapshotData: snapshot),
                ),
              ),
            ),
          );

          //
        },
      ),
    );
  }
}
