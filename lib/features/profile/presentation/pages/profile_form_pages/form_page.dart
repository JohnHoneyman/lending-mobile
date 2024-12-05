import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lendingmobile/core/common/widgets/json_schema_form/json_schema_form.dart';
import 'package:lendingmobile/core/model/form_info.dart';
import 'package:lendingmobile/core/services/dio/get_access_token.dart';
import 'package:lendingmobile/core/services/form_engine/form_engine_api.dart';
import 'package:lendingmobile/features/profile/index.dart';

class FormPage extends StatefulWidget {
  final String? userId;
  final String formID;
  final String formVersionID;
  final String version;

  const FormPage({
    super.key,
    this.userId,
    required this.formID,
    required this.formVersionID,
    required this.version,
  });

  static route(String? userId, String formId, String formVersionID,
          String version) =>
      MaterialPageRoute(
        builder: (context) => FormPage(
          userId: userId ?? '',
          formID: formId,
          formVersionID: formVersionID,
          version: version,
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

      final response = await formEngineApi.fetchFormFromId(
        accessToken,
        widget.formID,
        widget.version,
      );

      if (response != null && response.statusCode == 200) {
        return FormInfoStruct.fromMap(response.data);
      } else {
        throw Exception('Failed to load form data');
      }
    } else {
      throw Exception('No access token found');
    }
  }

  void submitData(Map<String, dynamic> data) async {
    final accessToken = await getAccessToken();

    if (accessToken != null) {
      final formEngineApi = FormEngineApi(Dio());
      final FormInfoStruct formInfo = await formInfoFuture;
      Map<String, dynamic> formattedData = {
        'data': data,
        'formVersion': formInfo.versionID,
        'userID': widget.userId,
      };

      final response =
          await formEngineApi.submitDataToForm(accessToken, formattedData);

      if (response != null && response.statusCode == 200) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Successfully saved changes.'),
            ),
          );
          Navigator.pushReplacement(
            context,
            PersonalInfoPage.route(widget.userId!),
          );
        }
      } else {
        print('Failed! $response');
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
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text('Form'),
    //   ),
    //   body: JsonSchemaForm(
    //     jsonSchema: JsonSchema.fromMap(JsonSchemaData.proofOfIncome),
    //     onSubmit: submitData,
    //   ),
    // );

    return FutureBuilder<FormInfoStruct>(
      future: formInfoFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Text(
                'Error: ${snapshot.error}',
              ),
            ),
          );
        } else if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              title: Text(snapshot.data?.name ?? 'Form'),
            ),
            body: JsonSchemaForm(
              jsonSchema: snapshot.data!.fields,
              onSubmit: submitData,
            ),
          );
        } else {
          return const Center(child: Text('No Data'));
        }
      },
    );
  }
}
