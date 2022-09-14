import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const Githubuser(),
    );
  }
}

class Githubuser extends StatefulWidget {
  const Githubuser({Key? key}) : super(key: key);

  @override
  State<Githubuser> createState() => _GithubuserState();
}

class _GithubuserState extends State<Githubuser> {
  dynamic data;
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    gituserdata();
  }

  Future gituserdata() async {
    final response = await http.get(Uri.parse("https://api.github.com/users"));
    if (response.statusCode == 200) {
      setState(() {});
      isLoading = false;
      data = jsonDecode(response.body);
    } else {
      throw Exception("get data failed");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Git hub user list"),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final res = data[index];
                return Card(
                  child: ListTile(
                    title: Text(res['login']),
                    leading: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.network(res["avatar_url"])),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
