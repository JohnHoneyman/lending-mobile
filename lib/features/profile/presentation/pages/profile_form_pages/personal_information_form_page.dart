import 'package:flutter/material.dart';
import 'package:lendingmobile/core/model/json_schema.dart';

class PersonalInformationFormPage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const PersonalInformationFormPage(),
      );
  const PersonalInformationFormPage({super.key});

  @override
  State<PersonalInformationFormPage> createState() =>
      _PersonalInformationFormPageState();
}

class _PersonalInformationFormPageState
    extends State<PersonalInformationFormPage> {
  final jsonSchemaData = [
    {
      "type": "object",
      "properties": {
        "name": {"type": "string"},
        "email": {"type": "string"},
        "age": {"type": "integer"},
      },
      "required": ["name", "email"]
    },
    {
      "type": "object",
      "title": "Existing Loans/Financial Obligations",
      "properties": {
        "Loans": {
          "type": "array",
          "items": {
            "type": "object",
            "required": [
              "Type of Loan",
              "Outstanding Loan Balance",
              "Monthly Payment Amount",
              "Remaining Loan Term",
              "Name of Lending"
            ],
            "properties": {
              "Type of Loan": {
                "type": "string",
                "enum": ["Personal Loan", "Car Loan", "Housing Loan"]
              },
              "Outstanding Loan Balance": {"type": "number"},
              "Monthly Payment Amount": {"type": "number"},
              "Remaining Loan Term": {"type": "integer"},
              "Name of Lending": {"type": "string"}
            }
          }
        }
      }
    },
    {
      "type": "object",
      "title": "Active Credit Card",
      "properties": {
        "creditCardIssuer": {"type": "string", "title": "Credit Card Issuer"},
        "creditLimit": {
          "type": "integer",
          "title": "Credit Limit",
          "minimum": 0
        },
        "currentBalance": {
          "type": "integer",
          "title": "Current Balance",
          "minimum": 0
        },
        "minimumMonthlyPayment": {
          "type": "integer",
          "title": "Minimum Monthly Payment",
          "minimum": 0
        }
      },
      "required": [
        "creditCardIssuer",
        "creditLimit",
        "currentBalance",
        "minimumMonthlyPayment"
      ],
      "additionalProperties": false
    },
  ];

  @override
  Widget build(BuildContext context) {
    final schema = JsonSchema.fromJson(jsonSchemaData[1]);
    print(schema);

    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Information'),
      ),
      body: ListView.builder(itemBuilder: (context, index) {
        return Container(
          child: Text(index.toString()),
        );
      }),
    );
  }
}
