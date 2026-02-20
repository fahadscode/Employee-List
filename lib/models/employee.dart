class Employee {
  final int? id;
  final String name;
  final String role;
  final DateTime dateOfJoining;
  final bool isActive;

  Employee({
    this.id,
    required this.name,
    required this.role,
    required this.dateOfJoining,
    required this.isActive,
  });

  int get yearsInOrganization {
    return DateTime.now().difference(dateOfJoining).inDays ~/ 365;
  }

  bool get shouldFlagGreen => isActive && yearsInOrganization > 5;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'role': role,
      'date_of_joining': dateOfJoining.toIso8601String(),
      'is_active': isActive ? 1 : 0,
    };
  }

  factory Employee.fromMap(Map<String, dynamic> map) {
    return Employee(
      id: map['id'] as int?,
      name: map['name'] as String,
      role: map['role'] as String,
      dateOfJoining: DateTime.parse(map['date_of_joining'] as String),
      isActive: (map['is_active'] as int) == 1,
    );
  }
}
