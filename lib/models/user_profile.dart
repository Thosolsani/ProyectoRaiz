
class UserProfile {
  final String? occupation;
  final String? responsibility;
  final String? familySituation;
  final String? goal;

  const UserProfile({
    this.occupation,
    this.responsibility,
    this.familySituation,
    this.goal,
  });

  Map<String, dynamic> toJson() {
    return {
      'occupation': occupation,
      'responsibility': responsibility,
      'familySituation': familySituation,
      'goal': goal,
    };
  }

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      occupation: json['occupation'] as String?,
      responsibility: json['responsibility'] as String?,
      familySituation: json['familySituation'] as String?,
      goal: json['goal'] as String?,
    );
  }
}
