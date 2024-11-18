import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class LoanHistoryPage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const LoanHistoryPage(),
      );
  const LoanHistoryPage({super.key});

  @override
  State<LoanHistoryPage> createState() => _LoanHistoryPageState();
}

class _LoanHistoryPageState extends State<LoanHistoryPage> {
  List<dynamic>? jsonList;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    try {
      var response =
          await Dio().get('https://jsonplaceholder.typicode.com/posts');
      if (response.statusCode == 200) {
        setState(() {
          jsonList = response.data as List;
        });
        print(jsonList);
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: Change to actual content
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
          itemCount: jsonList == null ? 0 : jsonList!.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Text(
                    jsonList?[index]['title'].toString().substring(0, 5) ?? ''),
                subtitle: Text(
                    jsonList?[index]['body'].toString().substring(0, 25) ?? ''),
              ),
            );
          }),
    );
  }
}
