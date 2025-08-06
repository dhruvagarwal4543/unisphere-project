import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import '../models/employee.dart';

class AddEmployeeViewModel {
  String name = '';
  String email = '';
  String position = '';
  String department = '';

  Future<void> save() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('employees');
    List<Employee> employees = [];

    if (jsonString != null) {
      final List list = json.decode(jsonString);
      employees = list.map((e) => Employee.fromJson(e)).toList();
    }

    final newEmployee = Employee(
      id: const Uuid().v4(),
      name: name,
      email: email,
      position: position,
      department: department,
      isPresent: false, // Default attendance status
    );

    employees.add(newEmployee);

    final jsonData = json.encode(employees.map((e) => e.toJson()).toList());
    await prefs.setString('employees', jsonData);
  }
}
