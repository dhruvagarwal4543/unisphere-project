import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// ignore: unused_import
import '../../../models/employee.dart';
import '../../../viewmodels/employee_list_viewmodel.dart';

class EmployeeDetailView extends StatelessWidget {
  final String id;
  const EmployeeDetailView({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final viewModel = EmployeeListViewModel();

    return FutureBuilder(
      future: viewModel.loadEmployees(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final employee = viewModel.employees.firstWhere((e) => e.id == id);

        return Scaffold(
          appBar: AppBar(
            title: const Text('Employee Details'),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => context.pop(),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _info('👤 Name', employee.name),
                    _info('📧 Email', employee.email),
                    _info('🧑‍💼 Position', employee.position),
                    _info('🏢 Department', employee.department),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        ElevatedButton.icon(
                          icon: const Icon(Icons.edit),
                          label: const Text('Edit'),
                          onPressed: () => context.go('/edit/${employee.id}'),
                        ),
                        const SizedBox(width: 12),
                        ElevatedButton.icon(
                          icon: const Icon(Icons.delete),
                          label: const Text('Delete'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                          onPressed: () async {
                            await viewModel.deleteEmployee(employee.id);
                            if (context.mounted) context.go('/');
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _info(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Text('$label: ', style: const TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
