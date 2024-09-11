class PullRequest {
  String? url;
  String? htmlUrl;
  String? diffUrl;
  String? patchUrl;
  dynamic mergedAt;

  PullRequest({
    this.url,
    this.htmlUrl,
    this.diffUrl,
    this.patchUrl,
    this.mergedAt,
  });

  factory PullRequest.fromJson(Map<String, dynamic> json) => PullRequest(
        url: json['url'] as String?,
        htmlUrl: json['html_url'] as String?,
        diffUrl: json['diff_url'] as String?,
        patchUrl: json['patch_url'] as String?,
        mergedAt: json['merged_at'] as dynamic,
      );

  Map<String, dynamic> toJson() => {
        'url': url,
        'html_url': htmlUrl,
        'diff_url': diffUrl,
        'patch_url': patchUrl,
        'merged_at': mergedAt,
      };
}
