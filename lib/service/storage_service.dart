import 'dart:convert';

import 'package:frontend_patient/model/corona_test_case.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const String STORAGE_KEY = "test-cases";

  static Future<List<CoronaTestCase>> getAll() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String testCaseJSON = prefs.getString(STORAGE_KEY);

    if (testCaseJSON == null)
      return [];

    final List<dynamic> json = jsonDecode(testCaseJSON);
    final List<CoronaTestCase> testCases = [];

    for(final Map<String, dynamic> testCaseJSON in json) {
      testCases.add(CoronaTestCase.fromJson(testCaseJSON));
    }

    return testCases;
  }

  static Future<bool> storeOrUpdate(final CoronaTestCase testCase) async {
    final List<CoronaTestCase> testCases = await StorageService.getAll();
    testCases.add(testCase);

    final String json = jsonEncode(testCases.toSet());
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(STORAGE_KEY, json);
  }
}