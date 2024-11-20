import 'package:flutter/material.dart';
import 'package:flutter_json_schema_form/controller/flutter_json_schema_form_controller.dart';

class AddLoanPage extends StatefulWidget {
  const AddLoanPage({super.key});

  @override
  State<AddLoanPage> createState() => _AddLoanPageState();
}

class _AddLoanPageState extends State<AddLoanPage> {
  Map<String, dynamic> formState = {
    "propertyType": "Apartment",
  };

  final controller = FlutterJsonSchemaFormController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Row(
          children: [
            Spacer(),
            Expanded(
              child: FlutterJsonSchemaForm(
                controller: controller,
                jsonSchema: controller.jsonSchema,
                formState: formState,
                onSubmit: () {
                  print(controller.data);
                },
                onChanged: (newFormState) {
                  setState(() {
                    formState = newFormState;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
