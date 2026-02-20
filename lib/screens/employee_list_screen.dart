import 'package:flutter/material.dart';
import '../controllers/employee_controller.dart';
import '../widgets/employee_card.dart';
import '../widgets/add_employee_dialog.dart';

class EmployeeListScreen extends StatefulWidget {
  const EmployeeListScreen({super.key});

  @override
  State<EmployeeListScreen> createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  final EmployeeController _controller = EmployeeController();

  @override
  void initState() {
    super.initState();
    _controller.loadEmployees();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee List'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListenableBuilder(
        listenable: _controller,
        builder: (context, _) {
          if (_controller.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (_controller.error != null) {
            return Center(
              child: Text('Error: ${_controller.error}'),
            );
          }

          if (_controller.employees.isEmpty) {
            return const Center(child: Text('No employees found.'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: _controller.employees.length,
            itemBuilder: (context, index) {
              final employee = _controller.employees[index];
              return EmployeeCard(
                employee: employee,
                onDelete: () => _controller.deleteEmployee(employee.id!),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog(
          context: context,
          builder: (_) => AddEmployeeDialog(onAdd: _controller.addEmployee),
        ),
        child: const Icon(Icons.person_add),
      ),
    );
  }
}
