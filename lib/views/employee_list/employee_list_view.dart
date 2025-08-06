import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../viewmodels/employee_list_viewmodel.dart';

class EmployeeListView extends StatefulWidget {
  const EmployeeListView({super.key});

  @override
  State<EmployeeListView> createState() => _EmployeeListViewState();
}

class _EmployeeListViewState extends State<EmployeeListView> {
  final _viewModel = EmployeeListViewModel();

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    await _viewModel.loadEmployees();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Employee Manager'), centerTitle: true),
      body: _viewModel.employees.isEmpty
          ? const Center(child: Text('No employees added yet.'))
          : ListView.builder(
              itemCount: _viewModel.employees.length,
              padding: const EdgeInsets.all(12),
              itemBuilder: (context, index) {
                final employee = _viewModel.employees[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    title: Text(
                      employee.name,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text(
                          '${employee.position} • ${employee.department}',
                          style: const TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          employee.email,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () => context.go('/detail/${employee.id}'),
                  ),
                );
              },
            ),

      // ✅ Two floating action buttons with labels
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton.extended(
            heroTag: 'attendanceBtn',
            onPressed: () => context.push('/attendance'),
            icon: const Icon(Icons.check_circle),
            label: const Text('Mark Attendance'),
          ),
          const SizedBox(height: 12),
          FloatingActionButton.extended(
            heroTag: 'addBtn',
            onPressed: () => context.push('/add'),
            icon: const Icon(Icons.person_add),
            label: const Text('Add Employee'),
          ),
        ],
      ),
    );
  }
}
