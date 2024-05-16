import 'dart:convert';

enum Role {
  admin,
  lecturer,
  student,
}

class User {
  final String id;
  final String name;
  final String qrLink;
  final Role role;

  User({
    required this.id,
    required this.name,
    required this.qrLink,
    required this.role,
  });

  User copyWith({
    String? token,
    String? id,
    String? name,
    String? qrLink,
    Role? role,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      qrLink: qrLink ?? this.qrLink,
      role: role ?? this.role,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'qrLink': qrLink,
      'role': role.toString().split('.').last,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as String,
      name: map['name'] as String,
      qrLink: map['qrLink'] as String,
      role: _roleFromString(map['role'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(id: $id, name: $name, qrLink: $qrLink, role: $role)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.qrLink == qrLink &&
        other.role == role;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ qrLink.hashCode ^ role.hashCode;
  }

  static Role _roleFromString(String roleString) {
    switch (roleString) {
      case 'admin':
        return Role.admin;
      case 'lecturer':
        return Role.lecturer;
      case 'student':
        return Role.student;
      default:
        throw ArgumentError('Invalid role string: $roleString');
    }
  }
}
