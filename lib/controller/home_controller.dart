import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sale_app/api_config/api_config.dart';
import 'package:sale_app/model/model.dart';

class HomeController extends ChangeNotifier {
  bool isLoading = true;
  List<EmployeeModel> items = [];

  final uri = Uri.parse("http://10.0.2.2:9000/details");

  fetchData() async {
    isLoading = true;
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      var decodedData = await jsonDecode(response.body);
      items = List<EmployeeModel>.from(
          decodedData.map((data) => EmployeeModel.fromJson(data)));
      print("Data Loaded");
    } else {
      print("Failed to load data");
    }
    isLoading = false;
    notifyListeners();
  }

  addData({
    required String name,
    required String address,
    required int? phone,
    required String email,
    required String country,
  }) async {
    if (name.isEmpty) {
      print("Name cannot be empty.");
      return;
    }

    final addUrl = Uri.parse("http://10.0.2.2:9000/data/add");

    try {
      var requestBody = {
        "name": name,
        "address": address,
        "phone_number": phone?.toString() ?? "",
        "email": email,
        "country": country,
      };

      print("Request Body: $requestBody");

      var response = await http.post(addUrl, body: requestBody);

      if (response.statusCode == 200) {
        print("Data added successfully");
      } else {
        print("Failed to add data. Status code: ${response.statusCode}");
        print("Response body: ${response.body}");
      }
    } catch (e) {
      print("Error during data addition: $e");
    }

    fetchData();
    isLoading = false;
    notifyListeners();
  }

  deleteEmployee({required String id, required BuildContext context}) async {
    final oprtnUrl = Uri.parse("http://10.0.2.2:9000/data/$id");
    var response = await http.delete(oprtnUrl);
    if (response.statusCode == 200) {
      fetchData();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Item deleted")));
      isLoading = false;
      notifyListeners();
    } else {
      print("Data Unavailable");
    }
  }
}
