import 'package:gh_issue_tracker/api_helpers/api_helpers.dart';

class GitHubProfileResponse {
  String login;
  int id;
  String nodeId;
  String avatarUrl;
  String gravatarId;
  String url;
  String htmlUrl;
  String followersUrl;
  String followingUrl;
  String gistsUrl;
  String starredUrl;
  String subscriptionsUrl;
  String organizationsUrl;
  String reposUrl;
  String eventsUrl;
  String receivedEventsUrl;
  String type;
  bool siteAdmin;
  dynamic name;
  dynamic company;
  String blog;
  dynamic location;
  dynamic email;
  dynamic hireable;
  String bio;
  String twitterUsername;
  int publicRepos;
  int publicGists;
  int followers;
  int following;
  String createdAt;
  String updatedAt;

  GitHubProfileResponse(
      {this.login = '',
      this.id = 0,
      this.nodeId = '',
      this.avatarUrl = '',
      this.gravatarId = '',
      this.url = '',
      this.htmlUrl = '',
      this.followersUrl = '',
      this.followingUrl = '',
      this.gistsUrl = '',
      this.starredUrl = '',
      this.subscriptionsUrl = '',
      this.organizationsUrl = '',
      this.reposUrl = '',
      this.eventsUrl = '',
      this.receivedEventsUrl = '',
      this.type = '',
      this.siteAdmin = false,
      this.name,
      this.company,
      this.blog = '',
      this.location,
      this.email,
      this.hireable,
      this.bio = '',
      this.twitterUsername = '',
      this.publicRepos = 0,
      this.publicGists = 0,
      this.followers = 0,
      this.following = 0,
      this.createdAt = '',
      this.updatedAt = ''});

  factory GitHubProfileResponse.fromJson(Map<String, dynamic> json) {
    return GitHubProfileResponse(
      login: APIHelper.getSafeStringValue(json['login']),
      id: APIHelper.getSafeIntValue(json['id']),
      nodeId: APIHelper.getSafeStringValue(json['node_id']),
      avatarUrl: APIHelper.getSafeStringValue(json['avatar_url']),
      gravatarId: APIHelper.getSafeStringValue(json['gravatar_id']),
      url: APIHelper.getSafeStringValue(json['url']),
      htmlUrl: APIHelper.getSafeStringValue(json['html_url']),
      followersUrl: APIHelper.getSafeStringValue(json['followers_url']),
      followingUrl: APIHelper.getSafeStringValue(json['following_url']),
      gistsUrl: APIHelper.getSafeStringValue(json['gists_url']),
      starredUrl: APIHelper.getSafeStringValue(json['starred_url']),
      subscriptionsUrl: APIHelper.getSafeStringValue(json['subscriptions_url']),
      organizationsUrl: APIHelper.getSafeStringValue(json['organizations_url']),
      reposUrl: APIHelper.getSafeStringValue(json['repos_url']),
      eventsUrl: APIHelper.getSafeStringValue(json['events_url']),
      receivedEventsUrl:
          APIHelper.getSafeStringValue(json['received_events_url']),
      type: APIHelper.getSafeStringValue(json['type']),
      siteAdmin: APIHelper.getSafeBoolValue(json['site_admin']),
      name: json['name'] ?? 'Not set',
      company: json['company'],
      blog: APIHelper.getSafeStringValue(json['blog']),
      location: json['location'],
      email: json['email'],
      hireable: json['hireable'],
      bio: json['bio'] ?? 'Not set',
      twitterUsername: APIHelper.getSafeStringValue(json['twitter_username']),
      publicRepos: APIHelper.getSafeIntValue(json['public_repos']),
      publicGists: APIHelper.getSafeIntValue(json['public_gists']),
      followers: APIHelper.getSafeIntValue(json['followers']),
      following: APIHelper.getSafeIntValue(json['following']),
      createdAt: APIHelper.getSafeStringValue(json['created_at']),
      updatedAt: APIHelper.getSafeStringValue(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() => {
        'login': login,
        'id': id,
        'node_id': nodeId,
        'avatar_url': avatarUrl,
        'gravatar_id': gravatarId,
        'url': url,
        'html_url': htmlUrl,
        'followers_url': followersUrl,
        'following_url': followingUrl,
        'gists_url': gistsUrl,
        'starred_url': starredUrl,
        'subscriptions_url': subscriptionsUrl,
        'organizations_url': organizationsUrl,
        'repos_url': reposUrl,
        'events_url': eventsUrl,
        'received_events_url': receivedEventsUrl,
        'type': type,
        'site_admin': siteAdmin,
        'name': name,
        'company': company,
        'blog': blog,
        'location': location,
        'email': email,
        'hireable': hireable,
        'bio': bio,
        'twitter_username': twitterUsername,
        'public_repos': publicRepos,
        'public_gists': publicGists,
        'followers': followers,
        'following': following,
        'created_at': createdAt,
        'updated_at': updatedAt,
      };

  factory GitHubProfileResponse.empty() => GitHubProfileResponse();

  static GitHubProfileResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? GitHubProfileResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : GitHubProfileResponse.empty();
}
