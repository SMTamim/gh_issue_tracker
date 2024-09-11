class Reactions {
  String? url;
  int? totalCount;
  int? plusOne;
  int? minusOne;
  int? laugh;
  int? hooray;
  int? confused;
  int? heart;
  int? rocket;
  int? eyes;

  Reactions({
    this.url,
    this.totalCount,
    this.plusOne,
    this.minusOne,
    this.laugh,
    this.hooray,
    this.confused,
    this.heart,
    this.rocket,
    this.eyes,
  });

  factory Reactions.fromJson(Map<String, dynamic> json) => Reactions(
        url: json['url'] as String?,
        totalCount: json['total_count'] as int?,
        plusOne: json['+1'] as int?,
        minusOne: json['-1'] as int?,
        laugh: json['laugh'] as int?,
        hooray: json['hooray'] as int?,
        confused: json['confused'] as int?,
        heart: json['heart'] as int?,
        rocket: json['rocket'] as int?,
        eyes: json['eyes'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'url': url,
        'total_count': totalCount,
        '+1': 1,
        '-1': 1,
        'laugh': laugh,
        'hooray': hooray,
        'confused': confused,
        'heart': heart,
        'rocket': rocket,
        'eyes': eyes,
      };
}
