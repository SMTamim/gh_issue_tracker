import 'package:gh_issue_tracker/api_helpers/api_helpers.dart';
import 'package:gh_issue_tracker/models/issues_response.dart';

class IssuesSearchResponse {
  int totalCount;
  bool incompleteResults;
  List<Issues> items;

  IssuesSearchResponse(
      {this.totalCount = 0,
      this.incompleteResults = false,
      this.items = const []});

  factory IssuesSearchResponse.fromJson(Map<String, dynamic> json) {
    return IssuesSearchResponse(
      totalCount: APIHelper.getSafeIntValue(json['total_count']),
      incompleteResults: APIHelper.getSafeBoolValue(json['incomplete_results']),
      items: APIHelper.getSafeListValue(json['items'])
          .map((e) => Issues.getAPIResponseObjectSafeValue(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'total_count': totalCount,
        'incomplete_results': incompleteResults,
        'items': items.map((e) => e.toJson()).toList(),
      };

  factory IssuesSearchResponse.empty() => IssuesSearchResponse();

  static IssuesSearchResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? IssuesSearchResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : IssuesSearchResponse.empty();
}

class SingleItems {
  String login;

  SingleItems({this.login = ''});

  factory SingleItems.fromJson(Map<String, dynamic> json) {
    return SingleItems(
      login: APIHelper.getSafeStringValue(json['login']),
    );
  }

  Map<String, dynamic> toJson() => {
        'login': login,
      };

  factory SingleItems.empty() => SingleItems();

  static SingleItems getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? SingleItems.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : SingleItems.empty();
}
