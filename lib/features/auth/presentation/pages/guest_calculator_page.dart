import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lendingmobile/core/common/index.dart';
import 'package:lendingmobile/main.dart';

class GuestCalculatorPage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const GuestCalculatorPage(),
      );
  const GuestCalculatorPage({super.key});

  @override
  State<GuestCalculatorPage> createState() => _GuestCalculatorPageState();
}

class _GuestCalculatorPageState extends State<GuestCalculatorPage> {
  double _currentLoanAmountValue = 0;
  double _currentTenureValue = 3;
  final double _currentInterest = 0.03;

  double monthlyPayment = 0.0;
  double totalAmount = 0.0;

  void calculateLoanDetails() {
    double monthlyInterestRate = _currentInterest / 12;
    double numberOfPayments = _currentTenureValue;

    // Monthly payment formula
    double powResult = pow(1 + monthlyInterestRate, numberOfPayments)
        as double; // Correct usage of pow

    setState(() {
      monthlyPayment = _currentLoanAmountValue *
          (monthlyInterestRate * powResult) /
          (powResult - 1);

      // Total amount to receive

      totalAmount = monthlyPayment * numberOfPayments;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Loan Application',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: const Color(0xff65558f),
      ),
      backgroundColor: const Color(0xfff1f4f8),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              color: Colors.white,
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Calculate your loan',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    Text(
                      'Use our loan calculator to accurately determine your loan details and financial obligations.',
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Gap(
              height: 8,
            ),
            Container(
              width: double.infinity,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Step 1',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const Text(
                      'Enter loan amount',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Column(
                      children: [
                        TextField(
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^\d*\.?\d*$'))
                          ],
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                            hintText: 'PHP 0000.00',
                          ),
                          onChanged: (value) {
                            setState(() {
                              _currentLoanAmountValue =
                                  double.tryParse(value) ?? 0;
                            });
                            calculateLoanDetails();
                          },
                        ),
                        const Text(
                          'Minimum of PHP 2,500 and maximum of PHP 50,000',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const Gap(),
            Container(
              width: double.infinity,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Step 2',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const Text(
                      'Tenure',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Slider(
                      value: _currentTenureValue,
                      min: 3,
                      max: 24,
                      divisions: 7,
                      label: _currentTenureValue.round().toString(),
                      onChanged: (double value) {
                        setState(() {
                          _currentTenureValue = value;
                        });
                        calculateLoanDetails();
                      },
                    ),
                  ],
                ),
              ),
            ),
            const Gap(),
            Container(
              width: double.infinity,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Summary',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Initial amount',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Php ${_currentLoanAmountValue.toStringAsFixed(2)}',
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Monthly Interest',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${(_currentInterest * 10)}%',
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Duration',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${_currentTenureValue.round()} months',
                        ),
                      ],
                    ),
                    const Divider(
                      height: 25,
                      thickness: 1.5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Monthly Payment',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Php ${monthlyPayment.toStringAsFixed(2)}',
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total Amount to Receive',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Php ${totalAmount.toStringAsFixed(2)}',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const Gap(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () {
                  Navigator.push(
                    context,
                    LendingApp.route(isFromCalcPage: true),
                  );
                  keycloakWrapper.initialize();
                },
                child: Ink(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: const Color(0xff65558f),
                      borderRadius: BorderRadius.circular(8)),
                  child: const Center(
                    child: Text(
                      'Next',
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
        ),
      ),
    );
  }
}
