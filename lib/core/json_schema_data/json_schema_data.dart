import 'package:lendingmobile/core/model/json_schema.dart';

final jsonSchemaData = [
  // Personal Information
  {
    "title": "Personal Information",
    "type": "object",
    "required": [
      "lastName",
      "firstName",
      "contactNumber",
      "dateOfBirth",
      "age",
      "gender",
      "religion",
      "education",
      "maritalStatus",
      "nationality"
    ],
    "if": {
      "properties": {
        "maritalStatus": {
          "enum": ["Single", "Widow"]
        }
      }
    },
    "then": {
      "not": {
        "anyOf": [
          {
            "required": ["spouseLastName"]
          },
          {
            "required": ["spouseFirstName"]
          },
          {
            "required": ["spouseMiddleName"]
          }
        ]
      }
    },
    "else": {
      "required": ["spouseLastName", "spouseFirstName", "spouseMiddleName"]
    },
    "additionalProperties": false,
    "properties": {
      "lastName": {
        "type": "string",
        "title": "Last Name",
        "minLength": 1,
        "maxLength": 100
      },
      "firstName": {
        "type": "string",
        "title": "First Name",
        "minLength": 1,
        "maxLength": 100
      },
      "middleName": {
        "type": "string",
        "title": "Middle Name",
        "maxLength": 100,
        "nullable": true
      },
      "contactNumber": {
        "type": "string",
        "title": "Contact Number",
        "pattern": "^(\\+63|0)9[0-9]{9}\$",
        "description": "Philippine mobile number starting with +639 or 09."
      },
      "dateOfBirth": {
        "type": "string",
        "title": "Date of Birth",
        "format": "date"
      },
      "age": {"type": "integer", "title": "Age", "minimum": 0},
      "gender": {
        "type": "string",
        "title": "Gender",
        "enum": ["Male", "Female", "Other"]
      },
      "religion": {
        "type": "string",
        "title": "Religion",
        "enum": ["Catholic", "Christian", "Islam", "Buddhist", "Others"]
      },
      "education": {
        "type": "string",
        "title": "Education",
        "enum": [
          "Elementary",
          "High School",
          "Vocational",
          "College",
          "Postgraduate"
        ]
      },
      "maritalStatus": {
        "type": "string",
        "title": "Marital Status",
        "enum": ["Single", "Married", "Separated", "Annulled", "Widow"]
      },
      "spouseLastName": {
        "type": "string",
        "title": "Spouse Last Name",
        "maxLength": 100
      },
      "spouseFirstName": {
        "type": "string",
        "title": "Spouse First Name",
        "maxLength": 100
      },
      "spouseMiddleName": {
        "type": "string",
        "title": "Spouse Middle Name",
        "maxLength": 100
      },
      "nationality": {
        "type": "string",
        "title": "Nationality",
        "enum": ["Filipino", "Foreign"]
      },
      "telephone": {
        "type": "string",
        "title": "Telephone",
        "pattern": "^[0-9]{7,10}\$",
        "description": "Optional landline number (7 to 10 digits).",
        "nullable": true
      }
    }
  },
  // Residential Address
  {
    "type": "object",
    "title": "Residential Address",
    "required": [
      "country",
      "province",
      "cityMunicipality",
      "barangay",
      "street",
      "blockNumber",
      "lotNumber",
      "zipCode"
    ],
    "properties": {
      "country": {
        "type": "string",
        "enum": ["Philippines", "Japan", "Malaysia", "Thailand", "Singapore"]
      },
      "province": {"type": "string"},
      "cityMunicipality": {"type": "string"},
      "barangay": {"type": "string"},
      "street": {"type": "string"},
      "blockNumber": {"type": "integer"},
      "lotNumber": {"type": "integer"},
      "zipCode": {"type": "integer"}
    }
  },
  // Existing Loans/Financial Obligations
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
  // Active Credit Card
  {
    "type": "object",
    "title": "Active Credit Card",
    "properties": {
      "creditCardIssuer": {"type": "string", "title": "Credit Card Issuer"},
      "creditLimit": {"type": "integer", "title": "Credit Limit", "minimum": 0},
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
  //Recurring Monthly Expenses
  {
    "type": "object",
    "title": "Recurring Monthly Expenses",
    "properties": {
      "monthlyRentOrMortgage": {
        "type": "integer",
        "title": "Monthly Rent/Mortgage Payment",
        "minimum": 0
      },
      "totalMonthlyUtilityBills": {
        "type": "integer",
        "title": "Total Monthly Utility Bills",
        "minimum": 0
      },
      "otherPaymentExpenses": {
        "type": "integer",
        "title": "Other Payment Expenses",
        "minimum": 0
      }
    },
    "required": [
      "monthlyRentOrMortgage",
      "totalMonthlyUtilityBills",
      "otherPaymentExpenses"
    ],
    "additionalProperties": false
  },
];

final jsonSchema =
    jsonSchemaData.map((data) => JsonSchema.fromJson(data)).toList();
