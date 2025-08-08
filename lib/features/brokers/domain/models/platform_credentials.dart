class PlatformCredentials {
  final String id;
  final String userId;
  final String platformName;
  final Map<String, dynamic> credentials;

  PlatformCredentials({
    required this.id,
    required this.userId,
    required this.platformName,
    required this.credentials,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'platformName': platformName,
      'credentials': credentials,
    };
  }

  factory PlatformCredentials.fromJson(Map<String, dynamic> json) {
    return PlatformCredentials(
      id: json['id'] as String,
      userId: json['userId'] as String,
      platformName: json['platformName'] as String,
      credentials: json['credentials'] as Map<String, dynamic>,
    );
  }

  // Helper methods to get specific credential fields
  String? get broker => credentials['broker'] as String?;
  String? get loginId => credentials['loginId'] as String?;
  String? get password => credentials['password'] as String?;
  String? get brokerServer => credentials['brokerServer'] as String?;
}

class PlatformCredentialsRequest {
  final String userId;
  final String platformName;
  final Map<String, dynamic> credentials;

  PlatformCredentialsRequest({
    required this.userId,
    required this.platformName,
    required this.credentials,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'platformName': platformName,
      'credentials': credentials,
    };
  }
}
