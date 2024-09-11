class Assignee {
  String? login;

  Assignee({this.login});

  factory Assignee.fromJson(Map<String, dynamic> json) => Assignee(
        login: json['login'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'login': login,
      };
}
