import 'package:gh_issue_tracker/api_helpers/api_helpers.dart';

class IssueResponse {
  String url;
  String repositoryUrl;
  String labelsUrl;
  String commentsUrl;
  String eventsUrl;
  String htmlUrl;
  int id;
  String nodeId;
  int number;
  String title;
  User user;
  List<SingleLabels> labels;
  String state;
  bool locked;
  dynamic assignee;
  dynamic milestone;
  int comments;
  String createdAt;
  String updatedAt;
  dynamic closedAt;
  String authorAssociation;
  dynamic activeLockReason;
  String body;
  dynamic closedBy;
  Reactions reactions;
  String timelineUrl;
  dynamic performedViaGithubApp;
  dynamic stateReason;

  IssueResponse(
      {this.url = '',
      this.repositoryUrl = '',
      this.labelsUrl = '',
      this.commentsUrl = '',
      this.eventsUrl = '',
      this.htmlUrl = '',
      this.id = 0,
      this.nodeId = '',
      this.number = 0,
      this.title = '',
      required this.user,
      this.labels = const [],
      this.state = '',
      this.locked = false,
      this.assignee,
      this.milestone,
      this.comments = 0,
      this.createdAt = '',
      this.updatedAt = '',
      this.closedAt,
      this.authorAssociation = '',
      this.activeLockReason,
      this.body = '',
      this.closedBy,
      required this.reactions,
      this.timelineUrl = '',
      this.performedViaGithubApp,
      this.stateReason});

  factory IssueResponse.fromJson(Map<String, dynamic> json) {
    return IssueResponse(
      url: APIHelper.getSafeStringValue(json['url']),
      repositoryUrl: APIHelper.getSafeStringValue(json['repository_url']),
      labelsUrl: APIHelper.getSafeStringValue(json['labels_url']),
      commentsUrl: APIHelper.getSafeStringValue(json['comments_url']),
      eventsUrl: APIHelper.getSafeStringValue(json['events_url']),
      htmlUrl: APIHelper.getSafeStringValue(json['html_url']),
      id: APIHelper.getSafeIntValue(json['id']),
      nodeId: APIHelper.getSafeStringValue(json['node_id']),
      number: APIHelper.getSafeIntValue(json['number']),
      title: APIHelper.getSafeStringValue(json['title']),
      user: User.getAPIResponseObjectSafeValue(json['user']),
      labels: APIHelper.getSafeListValue(json['labels'])
          .map((e) => SingleLabels.getAPIResponseObjectSafeValue(e))
          .toList(),
      state: APIHelper.getSafeStringValue(json['state']),
      locked: APIHelper.getSafeBoolValue(json['locked']),
      assignee: json['assignee'],
      milestone: json['milestone'],
      comments: APIHelper.getSafeIntValue(json['comments']),
      createdAt: APIHelper.getSafeStringValue(json['created_at']),
      updatedAt: APIHelper.getSafeStringValue(json['updated_at']),
      closedAt: json['closed_at'],
      authorAssociation:
          APIHelper.getSafeStringValue(json['author_association']),
      activeLockReason: json['active_lock_reason'],
      body: APIHelper.getSafeStringValue(json['body']),
      closedBy: json['closed_by'],
      reactions: Reactions.getAPIResponseObjectSafeValue(json['reactions']),
      timelineUrl: APIHelper.getSafeStringValue(json['timeline_url']),
      performedViaGithubApp: json['performed_via_github_app'],
      stateReason: json['state_reason'],
    );
  }

  Map<String, dynamic> toJson() => {
        'url': url,
        'repository_url': repositoryUrl,
        'labels_url': labelsUrl,
        'comments_url': commentsUrl,
        'events_url': eventsUrl,
        'html_url': htmlUrl,
        'id': id,
        'node_id': nodeId,
        'number': number,
        'title': title,
        'user': user.toJson(),
        'labels': labels.map((e) => e.toJson()).toList(),
        'state': state,
        'locked': locked,
        'assignee': assignee,
        'milestone': milestone,
        'comments': comments,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'closed_at': closedAt,
        'author_association': authorAssociation,
        'active_lock_reason': activeLockReason,
        'body': body,
        'closed_by': closedBy,
        'reactions': reactions.toJson(),
        'timeline_url': timelineUrl,
        'performed_via_github_app': performedViaGithubApp,
        'state_reason': stateReason,
      };

  factory IssueResponse.empty() => IssueResponse(
        user: User.empty(),
        reactions: Reactions.empty(),
      );

  static IssueResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? IssueResponse.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : IssueResponse.empty();
}

class User {
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

  User(
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
      this.siteAdmin = false});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
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
      };

  factory User.empty() => User();

  static User getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? User.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : User.empty();
}

class SingleLabels {
  int id;
  String nodeId;
  String url;
  String name;
  String color;
  bool defaults;
  String description;

  SingleLabels(
      {this.id = 0,
      this.nodeId = '',
      this.url = '',
      this.name = '',
      this.color = '',
      this.defaults = false,
      this.description = ''});

  factory SingleLabels.fromJson(Map<String, dynamic> json) {
    return SingleLabels(
      id: APIHelper.getSafeIntValue(json['id']),
      nodeId: APIHelper.getSafeStringValue(json['node_id']),
      url: APIHelper.getSafeStringValue(json['url']),
      name: APIHelper.getSafeStringValue(json['name']),
      color: APIHelper.getSafeStringValue(json['color']),
      defaults: APIHelper.getSafeBoolValue(json['default']),
      description: APIHelper.getSafeStringValue(json['description']),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'node_id': nodeId,
        'url': url,
        'name': name,
        'color': color,
        'default': defaults,
        'description': description,
      };

  factory SingleLabels.empty() => SingleLabels();

  static SingleLabels getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? SingleLabels.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : SingleLabels.empty();
}

class Reactions {
  String url;
  int totalCount;
  int plusOne;
  int minusOne;
  int laugh;
  int hooray;
  int confused;
  int heart;
  int rocket;
  int eyes;

  Reactions(
      {this.url = '',
      this.totalCount = 0,
      this.plusOne = 0,
      this.minusOne = 0,
      this.laugh = 0,
      this.hooray = 0,
      this.confused = 0,
      this.heart = 0,
      this.rocket = 0,
      this.eyes = 0});

  factory Reactions.fromJson(Map<String, dynamic> json) {
    return Reactions(
      url: APIHelper.getSafeStringValue(json['url']),
      totalCount: APIHelper.getSafeIntValue(json['total_count']),
      plusOne: APIHelper.getSafeIntValue(json['+1']),
      minusOne: APIHelper.getSafeIntValue(json['-1']),
      laugh: APIHelper.getSafeIntValue(json['laugh']),
      hooray: APIHelper.getSafeIntValue(json['hooray']),
      confused: APIHelper.getSafeIntValue(json['confused']),
      heart: APIHelper.getSafeIntValue(json['heart']),
      rocket: APIHelper.getSafeIntValue(json['rocket']),
      eyes: APIHelper.getSafeIntValue(json['eyes']),
    );
  }

  Map<String, dynamic> toJson() => {
        'url': url,
        'total_count': totalCount,
        '+1': plusOne,
        '-1': minusOne,
        'laugh': laugh,
        'hooray': hooray,
        'confused': confused,
        'heart': heart,
        'rocket': rocket,
        'eyes': eyes,
      };

  factory Reactions.empty() => Reactions();

  static Reactions getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Reactions.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : Reactions.empty();
}
