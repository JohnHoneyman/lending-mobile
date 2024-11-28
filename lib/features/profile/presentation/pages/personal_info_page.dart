import 'package:flutter/material.dart';
import 'package:lendingmobile/core/common/index.dart';
import 'package:lendingmobile/core/model/form_model.dart';
import 'package:lendingmobile/features/profile/index.dart';
import 'package:lendingmobile/features/profile/presentation/pages/profile_form_pages/form_page.dart';

class PersonalInfoPage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const PersonalInfoPage(),
      );
  const PersonalInfoPage({super.key});

  @override
  State<PersonalInfoPage> createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage> {
  List<FormStruct> formList = [];

  // void fetchFormListData() async {
  //   final accessToken = await getAccessToken();

  //   if (accessToken != null) {
  //     final formEngineApi = FormEngineApi(Dio());

  //     final response = await formEngineApi.fetchFormList(accessToken);

  //     if (response != null && response.statusCode == 200) {
  //       List<FormStruct> updatedFormList = [];
  //       for (var item in response.data) {
  //         updatedFormList.add(FormStruct.fromMap(item));
  //       }

  //       setState(() {
  //         formList = updatedFormList;
  //       });
  //       print('Form list updated: ${formList} items');
  //     } else {
  //       print('Failed to submit form. Status code: ${response?.data}');
  //     }
  //   } else {
  //     print('Failed to get access token');
  //   }
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   fetchFormListData();
  // }

  @override
  Widget build(BuildContext context) {
    final profileItems = [
      {
        'infoName': 'Personal Information',
        'id': '967ae16c-b3b7-469c-a302-626fc75de5e2',
      },
      {
        'infoName': 'Valid IDs',
        'id': 'c6b202cb-a86c-4c5b-8e23-4c38b3c112d3',
      },
      {
        'infoName': 'Residential Address',
        'id': '7806b593-73f7-449b-af21-9920dd1b36f4',
      },
      {
        'infoName': 'Proof of Income',
        'id': '533e8c38-4f0f-439c-aa5a-79d84a135262',
        'isVerified': true,
      },
      {
        'infoName': 'Existing Loans (if any)',
        'id': 'febb3f5d-9be1-4829-b2e5-d044b84687e6',
      },
      {
        'infoName': 'Credit Cards (if any)',
        'id': 'd6bb027b-7056-492d-a206-f1f5b6f0e52f',
      },
      {
        'infoName': 'Recurring monthly expenses (if any)',
        'id': '8422a26f-f40a-47ba-9493-9f17f3d84e05',
      },
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
                    return Column(
                      children: [
                        ProfileInfoTypeWidget(
                          infoName: profileItems[index]['infoName'] as String,
                          isVerified:
                              (profileItems[index] as Map)['isVerified'] ??
                                  false,
                          onTap: () => Navigator.push(
                            context,
                            FormPage.route((profileItems[index] as Map)['id']),
                          ),
                        ),
                        const Gap(height: 8),
                      ],
                    );
                  },
                ),
                // formList.isEmpty
                //     ? const SizedBox.shrink()
                //     : ListView.builder(
                //         shrinkWrap: true,
                //         physics: const NeverScrollableScrollPhysics(),
                //         itemCount: formList.length,
                //         itemBuilder: (context, index) {
                //           String id = formList[index].id;
                //           String infoName = formList[index].name;
                //           return Column(
                //             children: [
                //               ProfileInfoTypeWidget(
                //                 infoName: infoName,
                //                 onTap: () => Navigator.push(
                //                   context,
                //                   FormPage.route(id),
                //                 ),
                //               ),
                //               const Gap(height: 8),
                //             ],
                //           );
                //         },
                //       ),
                // Container(
                //   height: 72,
                //   padding: const EdgeInsets.symmetric(
                //     horizontal: 16,
                //   ),
                //   decoration: BoxDecoration(
                //     color: Colors.white,
                //     borderRadius: BorderRadius.circular(8),
                //   ),
                //   child: const Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Text(
                //         'Credit Score',
                //         maxLines: 2,
                //         overflow: TextOverflow.ellipsis,
                //       ),
                //     ],
                //   ),
                // ),
                const Gap(height: 8),
              ],
            ),
          );
        },
      ),
    );
  }
}
