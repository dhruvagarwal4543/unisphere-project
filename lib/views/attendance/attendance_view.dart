import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../viewmodels/employee_list_viewmodel.dart';

class AttendanceView extends StatefulWidget {
  const AttendanceView({super.key});

  @override
  State<AttendanceView> createState() => _AttendanceViewState();
}

class _AttendanceViewState extends State<AttendanceView> {
  final viewModel = EmployeeListViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.loadEmployees().then((_) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    final presentCount = viewModel.employees.where((e) => e.isPresent).length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mark Attendance'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.done_all),
            tooltip: 'Mark All Present',
            onPressed: () async {
              await viewModel.markAll(true);
              setState(() {});
            },
          ),
          IconButton(
            icon: const Icon(Icons.clear),
            tooltip: 'Clear All',
            onPressed: () async {
              await viewModel.markAll(false);
              setState(() {});
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              'Present: $presentCount / ${viewModel.employees.length}',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: viewModel.employees.length,
              itemBuilder: (context, index) {
                final e = viewModel.employees[index];
                return Card(
                  child: ListTile(
                    title: Text(e.name),
                    subtitle: Text('${e.position} - ${e.department}'),
                    trailing: Checkbox(
                      value: e.isPresent,
                      onChanged: (value) async {
                        await viewModel.toggleAttendance(e.id, value ?? false);
                        setState(() {});
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
