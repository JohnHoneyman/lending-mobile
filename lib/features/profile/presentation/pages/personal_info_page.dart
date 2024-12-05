import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lendingmobile/core/common/index.dart';
import 'package:lendingmobile/core/model/form_data.dart';
import 'package:lendingmobile/core/model/form_model.dart';
import 'package:lendingmobile/core/services/dio/get_access_token.dart';
import 'package:lendingmobile/core/services/form_engine/form_engine_api.dart';
import 'package:lendingmobile/core/utils/get_form_version_id.dart';
import 'package:lendingmobile/features/profile/index.dart';
import 'package:lendingmobile/features/profile/presentation/pages/profile_form_pages/form_page.dart';

class PersonalInfoPage extends StatefulWidget {
  final String userId;

  const PersonalInfoPage({super.key, required this.userId});

  static route(String userId) => MaterialPageRoute(
        builder: (context) => PersonalInfoPage(userId: userId),
      );

  @override
  State<PersonalInfoPage> createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage> {
  List<FormStruct> formList = [];
  List<FormDataStruct> formDataList = [];

  void handleFetchFormListData() async {
    final accessToken = await getAccessToken();

    if (accessToken != null) {
      final formEngineApi = FormEngineApi(Dio());

      final response = await formEngineApi.fetchFormList(accessToken, 1, 10);

      if (response != null && response.statusCode == 200) {
        List<FormStruct> updatedFormList = [];
        for (var item in response.data['data']) {
          updatedFormList.add(FormStruct.fromMap(item));
        }

        setState(() {
          formList = updatedFormList;
        });
      } else {
        print('Failed to submit form. Status code: ${response?.data}');
      }
    } else {
      print('Failed to get access token');
    }
  }

  void handleFetchFormDataFromUserId() async {
    final accessToken = await getAccessToken();

    if (accessToken != null) {
      final formEngineApi = FormEngineApi(Dio());
      final userId = widget.userId;

      final response = await formEngineApi.fetchFormDataFromUserId(
          accessToken, userId, 1, 10);

      if (response != null && response.statusCode == 200) {
        List<FormDataStruct> updatedFormDataList = [];
        for (var item in response.data['data']) {
          updatedFormDataList.add(FormDataStruct.fromMap(item));
        }

        setState(() {
          formDataList = updatedFormDataList;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    handleFetchFormListData();
    handleFetchFormDataFromUserId();
  }

  @override
  Widget build(BuildContext context) {
    final List<FormStruct> profileItems = [
      FormStruct(
        formID: '967ae16c-b3b7-469c-a302-626fc75de5e2',
        name: 'Personal Information',
      ),
      FormStruct(
        formID: 'c6b202cb-a86c-4c5b-8e23-4c38b3c112d3',
        name: 'Valid IDs',
      ),
      FormStruct(
        formID: '7806b593-73f7-449b-af21-9920dd1b36f4',
        name: 'Residential Address',
      ),
      FormStruct(
        formID: '533e8c38-4f0f-439c-aa5a-79d84a135262',
        name: 'Proof of Income',
      ),
      FormStruct(
        formID: 'febb3f5d-9be1-4829-b2e5-d044b84687e6',
        name: 'Existing Loans (if any)',
      ),
      FormStruct(
        formID: 'd6bb027b-7056-492d-a206-f1f5b6f0e52f',
        name: 'Credit Cards (if any)',
      ),
      FormStruct(
        formID: '8422a26f-f40a-47ba-9493-9f17f3d84e05',
        name: 'Recurring monthly expenses (if any)',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffeeeeee),
      ),
      backgroundColor: const Color(0xffeeeeee),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: keycloakWrapper.getUserInfo(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          final userData = snapshot.data ?? {};
          final userName = userData['name'] ?? 'John Cena';
          final userEmail = userData['email'] ?? 'johncena@gmail.com';

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView(
              children: [
                Container(
                  height: 72,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Account Verification',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff573D9B),
                        ),
                      ),
                      CircularProgressIndicator(
                        value: 0.6,
                        backgroundColor: Colors.grey,
                      )
                    ],
                  ),
                ),
                const Gap(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              color: const Color(0xff573D9B),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: const Icon(
                              Icons.person,
                              color: Colors.white,
                              size: 35,
                            ),
                          ),
                          const Gap(width: 8),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                userName,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                userEmail,
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 8,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: const Color(0xff65558f),
                        ),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.edit_outlined,
                              color: Colors.white,
                              size: 16,
                            ),
                            Gap(width: 4),
                            Text(
                              'Edit',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Gap(height: 8),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: profileItems.length,
                  itemBuilder: (context, index) {
                    final formVersionID =
                        getFormVersionID(profileItems[index].formID, formList);
                    final formVersion =
                        getFormVersion(profileItems[index].formID, formList);

                    return Column(
                      children: [
                        ProfileInfoTypeWidget(
                          infoName: profileItems[index].name,
                          isVerified: profileItems[index].isVerified ?? false,
                          onTap: () => Navigator.push(
                            context,
                            FormPage.route(
                              widget.userId,
                              profileItems[index].formID,
                              formVersionID,
                              formVersion,
                            ),
                          ),
                        ),
                        const Gap(height: 8),
                      ],
                    );
                  },
                ),
                const Gap(height: 8),
              ],
            ),
          );
        },
      ),
    );
  }
}
