import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/employee.dart';

class EmployeeListViewModel {
  List<Employee> employees = [];

  Future<void> loadEmployees() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('employees');
    if (jsonString != null) {
      final List list = json.decode(jsonString);
      employees = list.map((e) => Employee.fromJson(e)).toList();
    } else {
      employees = [];
    }
  }

  Future<void> toggleAttendance(String id, bool status) async {
    await loadEmployees(); // Ensure latest list
    final prefs = await SharedPreferences.getInstance();

    final index = employees.indexWhere((e) => e.id == id);
    if (index != -1) {
      final updated = Employee(
        id: employees[index].id,
        name: employees[index].name,
        email: employees[index].email,
        position: employees[index].position,
        department: employees[index].department,
        isPresent: status,
      );
      employees[index] = updated;

      final jsonData = json.encode(employees.map((e) => e.toJson()).toList());
      await prefs.setString('employees', jsonData);
    }
  }

  Future<void> deleteEmployee(String id) async {
    await loadEmployees();
    employees.removeWhere((e) => e.id == id);
    final prefs = await SharedPreferences.getInstance();
    final jsonData = json.encode(employees.map((e) => e.toJson()).toList());
    await prefs.setString('employees', jsonData);
  }

  Future<void> saveEmployee(Employee employee) async {
    await loadEmployees();
    employees.add(employee);
    final prefs = await SharedPreferences.getInstance();
    final jsonData = json.encode(employees.map((e) => e.toJson()).toList());
    await prefs.setString('employees', jsonData);
  }

  Future<void> markAll(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    employees = employees
        .map((e) => e.copyWith(isPresent: value))
        .toList()
        .cast<Employee>();
    final jsonData = json.encode(employees.map((e) => e.toJson()).toList());
    await prefs.setString('employees', jsonData);
  }
}
