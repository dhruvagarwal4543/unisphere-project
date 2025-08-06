import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../viewmodels/employee_list_viewmodel.dart';
import '../../../models/employee.dart';

class EditEmployeeView extends StatefulWidget {
  final String id;
  const EditEmployeeView({super.key, required this.id});

  @override
  State<EditEmployeeView> createState() => _EditEmployeeViewState();
}

class _EditEmployeeViewState extends State<EditEmployeeView> {
  final _formKey = GlobalKey<FormState>();
  final viewModel = EmployeeListViewModel();

  late Employee employee;
  late String name, email, position, department;

  @override
  void initState() {
    super.initState();
    viewModel.loadEmployees().then((_) {
      employee = viewModel.employees.firstWhere((e) => e.id == widget.id);
      name = employee.name;
      email = employee.email;
      position = employee.position;
      department = employee.department;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    if (viewModel.employees.isEmpty) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Edit Employee")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: name,
                decoration: const InputDecoration(labelText: 'Name'),
                onChanged: (val) => name = val,
                validator: (val) => val!.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                initialValue: email,
                decoration: const InputDecoration(labelText: 'Email'),
                onChanged: (val) => email = val,
                validator: (val) =>
                val!.contains('@') ? null : 'Invalid email',
              ),
              TextFormField(
                initialValue: position,
                decoration: const InputDecoration(labelText: 'Position'),
                onChanged: (val) => position = val,
              ),
              TextFormField(
                initialValue: department,
                decoration: const InputDecoration(labelText: 'Department'),
                onChanged: (val) => department = val,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await viewModel.deleteEmployee(widget.id);
                    await viewModel.saveEmployee(Employee(
                      id: widget.id,
                      name: name,
                      email: email,
                      position: position,
                      department: department,
                      isPresent: employee.isPresent, // Keep attendance
                    ));
                    if (mounted) context.go('/');
                  }
                },
                child: const Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
