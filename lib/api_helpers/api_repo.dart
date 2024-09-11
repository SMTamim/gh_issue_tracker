import 'dart:convert';
import 'dart:developer';

import 'package:gh_issue_tracker/api_helpers/api_client.dart';
import 'package:gh_issue_tracker/api_helpers/api_helpers.dart';
import 'package:gh_issue_tracker/models/git_hub_search_response.dart';
import 'package:gh_issue_tracker/utils/helpers/helpers.dart';
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
}
