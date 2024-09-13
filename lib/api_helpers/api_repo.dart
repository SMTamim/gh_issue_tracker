import 'dart:convert';

import 'package:gh_issue_tracker/api_helpers/api_client.dart';
import 'package:gh_issue_tracker/api_helpers/api_helpers.dart';
import 'package:gh_issue_tracker/models/git_hub_profile_response.dart';
import 'package:gh_issue_tracker/models/git_hub_search_response.dart';
import 'package:gh_issue_tracker/models/issue_response.dart';
import 'package:gh_issue_tracker/models/issues_response.dart';
import 'package:gh_issue_tracker/models/issues_search_response.dart';
import 'package:http/http.dart' as http;

class APIRepo {
  static Future<List<SingleRepo>?> getGitHubSearchResponse(
      {required String repoName}) async {
    try {
      await APIHelper.preAPICallCheck();

      final http.Response response =
          await APIClient.instance.requestGetMethodAsJSONEncoded(
        url: '/search/repositories?q=$repoName',
      );

      APIHelper.postAPICallCheck(response);
      final GitHubSearchResponse responseModel =
          GitHubSearchResponse.getAPIResponseObjectSafeValue(
              jsonDecode(response.body));
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.incompleteResults = false;
      }
      // log(responseModel.items.length.toString());
      return responseModel.items;
    } catch (e) {
      APIHelper.handleExceptions(e);
      return null;
    }
  }

  static Future<List<Issues>?> getSearchedIssues(
      {required String owner,
      required String repoName,
      required String query}) async {
    try {
      await APIHelper.preAPICallCheck();

      final http.Response response =
          await APIClient.instance.requestGetMethodAsJSONEncoded(
        url: '/search/issues?q=repo:$owner/$repoName%20$query',
      );

      APIHelper.postAPICallCheck(response);
      final IssuesSearchResponse responseModel =
          IssuesSearchResponse.getAPIResponseObjectSafeValue(
              jsonDecode(response.body));
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.incompleteResults = false;
      }
      // log(responseModel.items.length.toString());
      return responseModel.items;
    } catch (e) {
      APIHelper.handleExceptions(e);
      return null;
    }
  }

  static Future<List<Issues>?> getIssueResponse(
      {required SingleRepo repo}) async {
    try {
      await APIHelper.preAPICallCheck();

      final http.Response response =
          await APIClient.instance.requestGetMethodAsJSONEncoded(
        url: '/repos/${repo.owner.login}/${repo.name}/issues',
      );

      APIHelper.postAPICallCheck(response);
      final IssuesResponse responseModel =
          IssuesResponse.getAPIResponseObjectSafeValue(
              jsonDecode(response.body));
      // if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
      //   responseModel.incompleteResults = false;
      // }
      // log(responseModel.items.length.toString());
      return responseModel.items;
    } catch (e) {
      APIHelper.handleExceptions(e);
      return null;
    }
  }

  static Future<GitHubProfileResponse?> getProfileResponse(
      {required String profileName}) async {
    try {
      await APIHelper.preAPICallCheck();
      final http.Response response =
          await APIClient.instance.requestGetMethodAsJSONEncoded(
        url: '/users/$profileName',
      );

      APIHelper.postAPICallCheck(response);
      final GitHubProfileResponse responseModel =
          GitHubProfileResponse.getAPIResponseObjectSafeValue(
              jsonDecode(response.body));
      return responseModel;
    } catch (e) {
      APIHelper.handleExceptions(e);
      return null;
    }
  }

  static Future<IssueResponse?> getIssueDetails(
      {required String owner,
      required String repo,
      required Issues issue}) async {
    try {
      await APIHelper.preAPICallCheck();
      final http.Response response =
          await APIClient.instance.requestGetMethodAsJSONEncoded(
        url: '/repos/$owner/$repo/issues/${issue.number}',
      );

      APIHelper.postAPICallCheck(response);
      final IssueResponse responseModel =
          IssueResponse.getAPIResponseObjectSafeValue(
              jsonDecode(response.body));
      return responseModel;
    } catch (e) {
      APIHelper.handleExceptions(e);
      return null;
    }
  }
}
