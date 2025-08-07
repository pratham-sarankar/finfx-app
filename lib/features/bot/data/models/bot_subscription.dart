class BotSubscription {
  final String id;
  final String status;
  final double lotSize;
  final DateTime subscribedAt;
  final DateTime? cancelledAt;
  final DateTime? expiresAt;

  BotSubscription({
    required this.id,
    required this.status,
    required this.lotSize,
    required this.subscribedAt,
    this.cancelledAt,
    this.expiresAt,
  });

  factory BotSubscription.fromJson(Map<String, dynamic> json) {
    return BotSubscription(
      id: json['id'] as String,
      status: json['status'] as String,
      lotSize: (json['lotSize'] as num).toDouble(),
      subscribedAt: DateTime.parse(json['subscribedAt'] as String),
      cancelledAt: json['cancelledAt'] != null
          ? DateTime.parse(json['cancelledAt'] as String)
          : null,
      expiresAt: json['expiresAt'] != null
          ? DateTime.parse(json['expiresAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status': status,
      'lotSize': lotSize,
      'subscribedAt': subscribedAt.toIso8601String(),
      'cancelledAt': cancelledAt?.toIso8601String(),
      'expiresAt': expiresAt?.toIso8601String(),
    };
  }

  bool get isActive => status == 'active';
  bool get isPaused => status == 'paused';
}
