class UserModel {
  final String id;
  final String email;
  final String? name;
  final DateTime? createdAt;
  final double? dailyCarbonGoal;

  UserModel({
    required this.id,
    required this.email,
    this.name,
    this.createdAt,
    this.dailyCarbonGoal,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'email': email,
    'name': name,
    'created_at': createdAt?.toIso8601String(),
    'daily_carbon_goal': dailyCarbonGoal,
  };

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      name: json['name'],
      createdAt: json['created_at'] != null 
          ? DateTime.parse(json['created_at'])
          : null,
      dailyCarbonGoal: (json['daily_carbon_goal'] as num?)?.toDouble(),
    );
  }
}