class CarbonActivityModel {
  final String id;
  final String userId;
  final String activityType;
  final double carbonAmount;
  final DateTime date;
  final String? description;
  final String category;

  CarbonActivityModel({
    required this.id,
    required this.userId,
    required this.activityType,
    required this.carbonAmount,
    required this.date,
    this.description,
    required this.category,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'user_id': userId,
    'activity_type': activityType,
    'carbon_amount': carbonAmount,
    'date': date.toIso8601String(),
    'description': description,
    'category': category,
  };

  factory CarbonActivityModel.fromJson(Map<String, dynamic> json) {
    return CarbonActivityModel(
      id: json['id'] ?? '',
      userId: json['user_id'] ?? '',
      activityType: json['activity_type'] ?? '',
      carbonAmount: (json['carbon_amount'] as num).toDouble(),
      date: DateTime.parse(json['date']),
      description: json['description'],
      category: json['category'] ?? 'other',
    );
  }
}