import 'package:gh_issue_tracker/api_helpers/api_helpers.dart';

class GitHubSearchResponse {
  int totalCount;
  String message;
  bool incompleteResults;
  List<SingleRepo> items;

  GitHubSearchResponse(
      {this.totalCount = 0,
      this.message = '',
      this.incompleteResults = false,
      this.items = const []});

  factory GitHubSearchResponse.fromJson(Map<String, dynamic> json) {
    return GitHubSearchResponse(
      totalCount: APIHelper.getSafeIntValue(json['total_count']),
      message: APIHelper.getSafeStringValue(json['message']),
      incompleteResults: APIHelper.getSafeBoolValue(json['incomplete_results']),
      items: APIHelper.getSafeListValue(json['items'])
          .map((e) => SingleRepo.getAPIResponseObjectSafeValue(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'total_count': totalCount,
        'message': message,
        'incomplete_results': incompleteResults,
        'items': items.map((e) => e.toJson()).toList(),
      };

  factory GitHubSearchResponse.empty() => GitHubSearchResponse();

  static GitHubSearchResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? GitHubSearchResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : GitHubSearchResponse.empty();
}

class SingleRepo {
  int id;
  String nodeId;
  String name;
  String fullName;
  bool private;
  Owner owner;
  String htmlUrl;
  String description;
  bool fork;
  String url;
  String forksUrl;
  String keysUrl;
  String collaboratorsUrl;
  String teamsUrl;
  String hooksUrl;
  String issueEventsUrl;
  String eventsUrl;
  String assigneesUrl;
  String branchesUrl;
  String tagsUrl;
  String blobsUrl;
  String gitTagsUrl;
  String gitRefsUrl;
  String treesUrl;
  String statusesUrl;
  String languagesUrl;
  String stargazersUrl;
  String contributorsUrl;
  String subscribersUrl;
  String subscriptionUrl;
  String commitsUrl;
  String gitCommitsUrl;
  String commentsUrl;
  String issueCommentUrl;
  String contentsUrl;
  String compareUrl;
  String mergesUrl;
  String archiveUrl;
  String downloadsUrl;
  String issuesUrl;
  String pullsUrl;
  String milestonesUrl;
  String notificationsUrl;
  String labelsUrl;
  String releasesUrl;
  String deploymentsUrl;
  String createdAt;
  String updatedAt;
  String pushedAt;
  String gitUrl;
  String sshUrl;
  String cloneUrl;
  String svnUrl;
  String homepage;
  int size;
  int stargazersCount;
  int watchersCount;
  String language;
  bool hasIssues;
  bool hasProjects;
  bool hasDownloads;
  bool hasWiki;
  bool hasPages;
  bool hasDiscussions;
  int forksCount;
  dynamic mirrorUrl;
  bool archived;
  bool disabled;
  int openIssuesCount;
  dynamic license;
  bool allowForking;
  bool isTemplate;
  bool webCommitSignoffRequired;
  List<String> topics;
  String visibility;
  int forks;
  int openIssues;
  int watchers;
  String defaultBranch;
  double score;

  SingleRepo(
      {this.id = 0,
      this.nodeId = '',
      this.name = '',
      this.fullName = '',
      this.private = false,
      required this.owner,
      this.htmlUrl = '',
      this.description = '',
      this.fork = false,
      this.url = '',
      this.forksUrl = '',
      this.keysUrl = '',
      this.collaboratorsUrl = '',
      this.teamsUrl = '',
      this.hooksUrl = '',
      this.issueEventsUrl = '',
      this.eventsUrl = '',
      this.assigneesUrl = '',
      this.branchesUrl = '',
      this.tagsUrl = '',
      this.blobsUrl = '',
      this.gitTagsUrl = '',
      this.gitRefsUrl = '',
      this.treesUrl = '',
      this.statusesUrl = '',
      this.languagesUrl = '',
      this.stargazersUrl = '',
      this.contributorsUrl = '',
      this.subscribersUrl = '',
      this.subscriptionUrl = '',
      this.commitsUrl = '',
      this.gitCommitsUrl = '',
      this.commentsUrl = '',
      this.issueCommentUrl = '',
      this.contentsUrl = '',
      this.compareUrl = '',
      this.mergesUrl = '',
      this.archiveUrl = '',
      this.downloadsUrl = '',
      this.issuesUrl = '',
      this.pullsUrl = '',
      this.milestonesUrl = '',
      this.notificationsUrl = '',
      this.labelsUrl = '',
      this.releasesUrl = '',
      this.deploymentsUrl = '',
      this.createdAt = '',
      this.updatedAt = '',
      this.pushedAt = '',
      this.gitUrl = '',
      this.sshUrl = '',
      this.cloneUrl = '',
      this.svnUrl = '',
      this.homepage = '',
      this.size = 0,
      this.stargazersCount = 0,
      this.watchersCount = 0,
      this.language = '',
      this.hasIssues = false,
      this.hasProjects = false,
      this.hasDownloads = false,
      this.hasWiki = false,
      this.hasPages = false,
      this.hasDiscussions = false,
      this.forksCount = 0,
      this.mirrorUrl,
      this.archived = false,
      this.disabled = false,
      this.openIssuesCount = 0,
      this.license,
      this.allowForking = false,
      this.isTemplate = false,
      this.webCommitSignoffRequired = false,
      this.topics = const [],
      this.visibility = '',
      this.forks = 0,
      this.openIssues = 0,
      this.watchers = 0,
      this.defaultBranch = '',
      this.score = 0.0});

  factory SingleRepo.fromJson(Map<String, dynamic> json) {
    return SingleRepo(
      id: APIHelper.getSafeIntValue(json['id']),
      nodeId: APIHelper.getSafeStringValue(json['node_id']),
      name: APIHelper.getSafeStringValue(json['name']),
      fullName: APIHelper.getSafeStringValue(json['full_name']),
      private: APIHelper.getSafeBoolValue(json['private']),
      owner: Owner.getAPIResponseObjectSafeValue(json['owner']),
      htmlUrl: APIHelper.getSafeStringValue(json['html_url']),
      description: APIHelper.getSafeStringValue(json['description']),
      fork: APIHelper.getSafeBoolValue(json['fork']),
      url: APIHelper.getSafeStringValue(json['url']),
      forksUrl: APIHelper.getSafeStringValue(json['forks_url']),
      keysUrl: APIHelper.getSafeStringValue(json['keys_url']),
      collaboratorsUrl: APIHelper.getSafeStringValue(json['collaborators_url']),
      teamsUrl: APIHelper.getSafeStringValue(json['teams_url']),
      hooksUrl: APIHelper.getSafeStringValue(json['hooks_url']),
      issueEventsUrl: APIHelper.getSafeStringValue(json['issue_events_url']),
      eventsUrl: APIHelper.getSafeStringValue(json['events_url']),
      assigneesUrl: APIHelper.getSafeStringValue(json['assignees_url']),
      branchesUrl: APIHelper.getSafeStringValue(json['branches_url']),
      tagsUrl: APIHelper.getSafeStringValue(json['tags_url']),
      blobsUrl: APIHelper.getSafeStringValue(json['blobs_url']),
      gitTagsUrl: APIHelper.getSafeStringValue(json['git_tags_url']),
      gitRefsUrl: APIHelper.getSafeStringValue(json['git_refs_url']),
      treesUrl: APIHelper.getSafeStringValue(json['trees_url']),
      statusesUrl: APIHelper.getSafeStringValue(json['statuses_url']),
      languagesUrl: APIHelper.getSafeStringValue(json['languages_url']),
      stargazersUrl: APIHelper.getSafeStringValue(json['stargazers_url']),
      contributorsUrl: APIHelper.getSafeStringValue(json['contributors_url']),
      subscribersUrl: APIHelper.getSafeStringValue(json['subscribers_url']),
      subscriptionUrl: APIHelper.getSafeStringValue(json['subscription_url']),
      commitsUrl: APIHelper.getSafeStringValue(json['commits_url']),
      gitCommitsUrl: APIHelper.getSafeStringValue(json['git_commits_url']),
      commentsUrl: APIHelper.getSafeStringValue(json['comments_url']),
      issueCommentUrl: APIHelper.getSafeStringValue(json['issue_comment_url']),
      contentsUrl: APIHelper.getSafeStringValue(json['contents_url']),
      compareUrl: APIHelper.getSafeStringValue(json['compare_url']),
      mergesUrl: APIHelper.getSafeStringValue(json['merges_url']),
      archiveUrl: APIHelper.getSafeStringValue(json['archive_url']),
      downloadsUrl: APIHelper.getSafeStringValue(json['downloads_url']),
      issuesUrl: APIHelper.getSafeStringValue(json['issues_url']),
      pullsUrl: APIHelper.getSafeStringValue(json['pulls_url']),
      milestonesUrl: APIHelper.getSafeStringValue(json['milestones_url']),
      notificationsUrl: APIHelper.getSafeStringValue(json['notifications_url']),
      labelsUrl: APIHelper.getSafeStringValue(json['labels_url']),
      releasesUrl: APIHelper.getSafeStringValue(json['releases_url']),
      deploymentsUrl: APIHelper.getSafeStringValue(json['deployments_url']),
      createdAt: APIHelper.getSafeStringValue(json['created_at']),
      updatedAt: APIHelper.getSafeStringValue(json['updated_at']),
      pushedAt: APIHelper.getSafeStringValue(json['pushed_at']),
      gitUrl: APIHelper.getSafeStringValue(json['git_url']),
      sshUrl: APIHelper.getSafeStringValue(json['ssh_url']),
      cloneUrl: APIHelper.getSafeStringValue(json['clone_url']),
      svnUrl: APIHelper.getSafeStringValue(json['svn_url']),
      homepage: APIHelper.getSafeStringValue(json['homepage']),
      size: APIHelper.getSafeIntValue(json['size']),
      stargazersCount: APIHelper.getSafeIntValue(json['stargazers_count']),
      watchersCount: APIHelper.getSafeIntValue(json['watchers_count']),
      language: APIHelper.getSafeStringValue(json['language']),
      hasIssues: APIHelper.getSafeBoolValue(json['has_issues']),
      hasProjects: APIHelper.getSafeBoolValue(json['has_projects']),
      hasDownloads: APIHelper.getSafeBoolValue(json['has_downloads']),
      hasWiki: APIHelper.getSafeBoolValue(json['has_wiki']),
      hasPages: APIHelper.getSafeBoolValue(json['has_pages']),
      hasDiscussions: APIHelper.getSafeBoolValue(json['has_discussions']),
      forksCount: APIHelper.getSafeIntValue(json['forks_count']),
      mirrorUrl: json['mirror_url'],
      archived: APIHelper.getSafeBoolValue(json['archived']),
      disabled: APIHelper.getSafeBoolValue(json['disabled']),
      openIssuesCount: APIHelper.getSafeIntValue(json['open_issues_count']),
      license: json['license'],
      allowForking: APIHelper.getSafeBoolValue(json['allow_forking']),
      isTemplate: APIHelper.getSafeBoolValue(json['is_template']),
      webCommitSignoffRequired:
          APIHelper.getSafeBoolValue(json['web_commit_signoff_required']),
      topics: APIHelper.getSafeListValue(json['topics'])
          .map((e) => APIHelper.getSafeStringValue(e))
          .toList(),
      visibility: APIHelper.getSafeStringValue(json['visibility']),
      forks: APIHelper.getSafeIntValue(json['forks']),
      openIssues: APIHelper.getSafeIntValue(json['open_issues']),
      watchers: APIHelper.getSafeIntValue(json['watchers']),
      defaultBranch: APIHelper.getSafeStringValue(json['default_branch']),
      score: APIHelper.getSafeDoubleValue(json['score']),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'node_id': nodeId,
        'name': name,
        'full_name': fullName,
        'private': private,
        'owner': owner.toJson(),
        'html_url': htmlUrl,
        'description': description,
        'fork': fork,
        'url': url,
        'forks_url': forksUrl,
        'keys_url': keysUrl,
        'collaborators_url': collaboratorsUrl,
        'teams_url': teamsUrl,
        'hooks_url': hooksUrl,
        'issue_events_url': issueEventsUrl,
        'events_url': eventsUrl,
        'assignees_url': assigneesUrl,
        'branches_url': branchesUrl,
        'tags_url': tagsUrl,
        'blobs_url': blobsUrl,
        'git_tags_url': gitTagsUrl,
        'git_refs_url': gitRefsUrl,
        'trees_url': treesUrl,
        'statuses_url': statusesUrl,
        'languages_url': languagesUrl,
        'stargazers_url': stargazersUrl,
        'contributors_url': contributorsUrl,
        'subscribers_url': subscribersUrl,
        'subscription_url': subscriptionUrl,
        'commits_url': commitsUrl,
        'git_commits_url': gitCommitsUrl,
        'comments_url': commentsUrl,
        'issue_comment_url': issueCommentUrl,
        'contents_url': contentsUrl,
        'compare_url': compareUrl,
        'merges_url': mergesUrl,
        'archive_url': archiveUrl,
        'downloads_url': downloadsUrl,
        'issues_url': issuesUrl,
        'pulls_url': pullsUrl,
        'milestones_url': milestonesUrl,
        'notifications_url': notificationsUrl,
        'labels_url': labelsUrl,
        'releases_url': releasesUrl,
        'deployments_url': deploymentsUrl,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'pushed_at': pushedAt,
        'git_url': gitUrl,
        'ssh_url': sshUrl,
        'clone_url': cloneUrl,
        'svn_url': svnUrl,
        'homepage': homepage,
        'size': size,
        'stargazers_count': stargazersCount,
        'watchers_count': watchersCount,
        'language': language,
        'has_issues': hasIssues,
        'has_projects': hasProjects,
        'has_downloads': hasDownloads,
        'has_wiki': hasWiki,
        'has_pages': hasPages,
        'has_discussions': hasDiscussions,
        'forks_count': forksCount,
        'mirror_url': mirrorUrl,
        'archived': archived,
        'disabled': disabled,
        'open_issues_count': openIssuesCount,
        'license': license,
        'allow_forking': allowForking,
        'is_template': isTemplate,
        'web_commit_signoff_required': webCommitSignoffRequired,
        'topics': topics,
        'visibility': visibility,
        'forks': forks,
        'open_issues': openIssues,
        'watchers': watchers,
        'default_branch': defaultBranch,
        'score': score,
      };

  factory SingleRepo.empty() => SingleRepo(
        owner: Owner.empty(),
      );

  static SingleRepo getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? SingleRepo.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : SingleRepo.empty();
}

class Owner {
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

  Owner(
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

  factory Owner.fromJson(Map<String, dynamic> json) {
    return Owner(
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

  factory Owner.empty() => Owner();

  static Owner getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Owner.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : Owner.empty();
}
