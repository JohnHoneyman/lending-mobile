import 'package:flutter/material.dart';
import 'package:lendingmobile/core/common/index.dart';
import 'package:lendingmobile/features/auth/presentation/pages/guest_calculator_page.dart';

class LoginScreen extends StatelessWidget {
  final bool isFromCalcPage;
  const LoginScreen({
    super.key,
    this.isFromCalcPage = false,
  });

  Future<bool> login() async {
    final isLoggedIn = await keycloakWrapper.login();
    return isLoggedIn;
  }

  @override
  Widget build(BuildContext context) {
    bool fromCalcPage = isFromCalcPage;
    return Scaffold(
      body: Center(
        child: fromCalcPage
            ? Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 48.0,
                          ),
                          child: const Text(
                            'Before we proceed, let\'s sign in to your account!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff65558f),
                              height: 1,
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32.0,
                          ),
                          child: const Text(
                            'Signing in allows you to check out different offers. Give it a try!',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 32),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(8),
                      onTap: login,
                      child: Ink(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: const Color(0xff65558f),
                            borderRadius: BorderRadius.circular(16)),
                        child: const Center(
                          child: Text(
                            'Log In To Your Account',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : Padding(
                padding: const EdgeInsets.all(40.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Lending Platform',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff65558f),
                      ),
                    ),
                    const Text(
                      'Let\'s get started!',
                      style: TextStyle(
                          fontSize: 24, fontWeight: FontWeight.normal),
                    ),
                    const Gap(height: 30),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, GuestCalculatorPage.route());
                        keycloakWrapper.initialize();
                      },
                      child: Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Compute your loan',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            Text.rich(
                              TextSpan(
                                text: 'Try out our ',
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                                children: [
                                  TextSpan(
                                    text: 'loan calculator!',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff65558f),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Gap(height: 30),
                    InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: login,
                      child: Ink(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: const Color(0xff65558f),
                            borderRadius: BorderRadius.circular(16)),
                        child: const Center(
                          child: Text(
                            'Log In To Your Account',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
