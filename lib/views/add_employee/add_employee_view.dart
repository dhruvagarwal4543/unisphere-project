import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../viewmodels/add_employee_viewmodel.dart'; // or use EmployeeListViewModel for edit

class AddEmployeeView extends StatefulWidget {
  const AddEmployeeView({super.key});

  @override
  State<AddEmployeeView> createState() => _AddEmployeeViewState();
}

class _AddEmployeeViewState extends State<AddEmployeeView> {
  final _formKey = GlobalKey<FormState>();
  final _viewModel = AddEmployeeViewModel(); // or EditEmployeeViewModel

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Employee')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTextField('Name', onChanged: (v) => _viewModel.name = v),
              const SizedBox(height: 16),
              _buildTextField(
                'Email',
                onChanged: (v) => _viewModel.email = v,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                'Position',
                onChanged: (v) => _viewModel.position = v,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                'Department',
                onChanged: (v) => _viewModel.department = v,
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                icon: const Icon(Icons.save),
                label: const Text("Save"),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await _viewModel.save();
                    if (mounted) context.pop();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label, {
    required Function(String) onChanged,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: const Icon(Icons.person_outline),
      ),
      keyboardType: keyboardType,
      validator: (val) => val == null || val.isEmpty ? 'Required' : null,
      onChanged: onChanged,
    );
  }
}
