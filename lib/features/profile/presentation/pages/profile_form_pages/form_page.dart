import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lendingmobile/core/common/widgets/json_schema_form/json_schema_form.dart';
import 'package:lendingmobile/core/model/form_model.dart';
import 'package:lendingmobile/core/model/json_schema.dart';
import 'package:lendingmobile/core/services/dio/get_access_token.dart';
import 'package:lendingmobile/core/services/form_engine/form_engine_api.dart';

class FormPage extends StatefulWidget {
  final String formId;

  const FormPage({super.key, required this.formId});

  static route(String formId) => MaterialPageRoute(
        builder: (context) => FormPage(
          formId: formId,
        ),
      );

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  late JsonSchema schema;
  bool isLoading = true;

  void fetchFormData() async {
    final accessToken = await getAccessToken();

    if (accessToken != null) {
      final formEngineApi = FormEngineApi(Dio());

      final response =
          await formEngineApi.fetchFormFromId(accessToken, widget.formId);

      if (response != null && response.statusCode == 200) {
        print(response.data);
        setState(() {
          schema = JsonSchema.fromMap(response.data['fields']);
        });
        print(schema);
      } else {
        print("Failed");
      }
    } else {
      print('Error');
    }
    isLoading = false;
  }

  @override
  void initState() {
    super.initState();
    fetchFormData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(schema.title ?? ''),
      ),
      body: isLoading
          ? const CircularProgressIndicator()
          : JsonSchemaForm(
              jsonSchema: schema,
            ),
    );
  }
}
