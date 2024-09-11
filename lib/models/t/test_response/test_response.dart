import 'assignee.dart';
import 'label.dart';
import 'pull_request.dart';
import 'reactions.dart';
import 'user.dart';

class TestResponse {
  String? url;
  String? repositoryUrl;
  String? labelsUrl;
  String? commentsUrl;
  String? eventsUrl;
  String? htmlUrl;
  int? id;
  String? nodeId;
  int? number;
  String? title;
  User? user;
  List<Label>? labels;
  String? state;
  bool? locked;
  dynamic assignee;
  List<Assignee>? assignees;
  dynamic milestone;
  int? comments;
  String? createdAt;
  String? updatedAt;
  dynamic closedAt;
  String? authorAssociation;
  dynamic activeLockReason;
  bool? draft;
  PullRequest? pullRequest;
  String? body;
  dynamic closedBy;
  Reactions? reactions;
  String? timelineUrl;
  dynamic performedViaGithubApp;
  dynamic stateReason;

  TestResponse({
    this.url,
    this.repositoryUrl,
    this.labelsUrl,
    this.commentsUrl,
    this.eventsUrl,
    this.htmlUrl,
    this.id,
    this.nodeId,
    this.number,
    this.title,
    this.user,
    this.labels,
    this.state,
    this.locked,
    this.assignee,
    this.assignees,
    this.milestone,
    this.comments,
    this.createdAt,
    this.updatedAt,
    this.closedAt,
    this.authorAssociation,
    this.activeLockReason,
    this.draft,
    this.pullRequest,
    this.body,
    this.closedBy,
    this.reactions,
    this.timelineUrl,
    this.performedViaGithubApp,
    this.stateReason,
  });

  factory TestResponse.fromJson(Map<String, dynamic> json) => TestResponse(
        url: json['url'] as String?,
        repositoryUrl: json['repository_url'] as String?,
        labelsUrl: json['labels_url'] as String?,
        commentsUrl: json['comments_url'] as String?,
        eventsUrl: json['events_url'] as String?,
        htmlUrl: json['html_url'] as String?,
        id: json['id'] as int?,
        nodeId: json['node_id'] as String?,
        number: json['number'] as int?,
        title: json['title'] as String?,
        user: json['user'] == null
            ? null
            : User.fromJson(json['user'] as Map<String, dynamic>),
        labels: (json['labels'] as List<dynamic>?)
            ?.map((e) => Label.fromJson(e as Map<String, dynamic>))
            .toList(),
        state: json['state'] as String?,
        locked: json['locked'] as bool?,
        assignee: json['assignee'] as dynamic,
        assignees: (json['assignees'] as List<dynamic>?)
            ?.map((e) => Assignee.fromJson(e as Map<String, dynamic>))
            .toList(),
        milestone: json['milestone'] as dynamic,
        comments: json['comments'] as int?,
        createdAt: json['created_at'] as String?,
        updatedAt: json['updated_at'] as String?,
        closedAt: json['closed_at'] as dynamic,
        authorAssociation: json['author_association'] as String?,
        activeLockReason: json['active_lock_reason'] as dynamic,
        draft: json['draft'] as bool?,
        pullRequest: json['pull_request'] == null
            ? null
            : PullRequest.fromJson(
                json['pull_request'] as Map<String, dynamic>),
        body: json['body'] as String?,
        closedBy: json['closed_by'] as dynamic,
        reactions: json['reactions'] == null
            ? null
            : Reactions.fromJson(json['reactions'] as Map<String, dynamic>),
        timelineUrl: json['timeline_url'] as String?,
        performedViaGithubApp: json['performed_via_github_app'] as dynamic,
        stateReason: json['state_reason'] as dynamic,
      );

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
        'user': user?.toJson(),
        'labels': labels?.map((e) => e.toJson()).toList(),
        'state': state,
        'locked': locked,
        'assignee': assignee,
        'assignees': assignees?.map((e) => e.toJson()).toList(),
        'milestone': milestone,
        'comments': comments,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'closed_at': closedAt,
        'author_association': authorAssociation,
        'active_lock_reason': activeLockReason,
        'draft': draft,
        'pull_request': pullRequest?.toJson(),
        'body': body,
        'closed_by': closedBy,
        'reactions': reactions?.toJson(),
        'timeline_url': timelineUrl,
        'performed_via_github_app': performedViaGithubApp,
        'state_reason': stateReason,
      };
}
