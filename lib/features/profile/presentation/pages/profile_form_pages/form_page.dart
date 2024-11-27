import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lendingmobile/core/common/widgets/json_schema_form/json_schema_form.dart';
import 'package:lendingmobile/core/model/form_info.dart';
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
  late Future<FormInfoStruct> formInfoFuture;

  Future<FormInfoStruct> fetchFormData() async {
    final accessToken = await getAccessToken();

    if (accessToken != null) {
      final formEngineApi = FormEngineApi(Dio());

      final response =
          await formEngineApi.fetchFormFromId(accessToken, widget.formId);

      if (response != null && response.statusCode == 200) {
        return FormInfoStruct.fromMap(response.data);
      } else {
        throw Exception('Failed to load form data');
      }
    } else {
      throw Exception('No access token found');
    }
  }

  @override
  void initState() {
    super.initState();
    formInfoFuture = fetchFormData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xfffef7ff),
      child: FutureBuilder<FormInfoStruct>(
        future: formInfoFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
              ),
            );
          } else if (snapshot.hasData) {
            print(snapshot.data);
            return Scaffold(
              appBar: AppBar(
                title: Text(snapshot.data?.name ?? 'Form'),
              ),
              body: JsonSchemaForm(
                jsonSchema: snapshot.data!.fields,
              ),
            );
          } else {
            return const Center(child: Text('No Data'));
          }
        },
      ),
    );
  }
}
