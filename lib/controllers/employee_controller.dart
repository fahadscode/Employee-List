import 'package:flutter/foundation.dart';
import '../models/employee.dart';
import '../database/database_helper.dart';

class EmployeeController extends ChangeNotifier {
  List<Employee> _employees = [];
  bool _isLoading = false;
  String? _error;

  List<Employee> get employees => List.unmodifiable(_employees);
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadEmployees() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _employees = await DatabaseHelper.instance.getAllEmployees();
    } catch (e) {
      _error = 'Failed to load employees: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addEmployee(Employee employee) async {
    await DatabaseHelper.instance.insertEmployee(employee);
    await loadEmployees();
  }

  Future<void> deleteEmployee(int id) async {
    await DatabaseHelper.instance.deleteEmployee(id);
    await loadEmployees();
  }
}
