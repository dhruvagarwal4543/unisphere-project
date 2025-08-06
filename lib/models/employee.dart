class Employee {
  final String id;
  final String name;
  final String email;
  final String position;
  final String department;
  final bool isPresent;

  Employee({
    required this.id,
    required this.name,
    required this.email,
    required this.position,
    required this.department,
    this.isPresent = false,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      position: json['position'],
      department: json['department'],
      isPresent: json['isPresent'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'position': position,
      'department': department,
      'isPresent': isPresent,
    };
  }

  copyWith({required bool isPresent}) {}
}
