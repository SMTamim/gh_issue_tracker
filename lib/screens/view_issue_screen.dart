import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:gh_issue_tracker/api_helpers/api_repo.dart';
import 'package:gh_issue_tracker/constants/app_constants.dart';
import 'package:gh_issue_tracker/models/issue_response.dart';
import 'package:gh_issue_tracker/models/issues_response.dart';
import 'package:gh_issue_tracker/utils/widgets/core_widgets.dart';

// ignore: must_be_immutable
class ViewIssueScreen extends StatefulWidget {
  ViewIssueScreen(
      {super.key,
      required this.issue,
      required this.owner,
      required this.repo});

  Issues issue;
  String owner;
  String repo;

  @override
  State<ViewIssueScreen> createState() => _ViewIssueScreenState();
}

class _ViewIssueScreenState extends State<ViewIssueScreen> {
  bool isLoading = true;
  IssueResponse issue = IssueResponse.empty();

  Future<void> getIssueDetails() async {
    IssueResponse? response = await APIRepo.getIssueDetails(
        owner: widget.owner, repo: widget.repo, issue: widget.issue);
    if (response == null) {
      log('No response for issues!');
      return;
    }
    log(response.toJson().toString());
    setState(() {
      issue = response;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getIssueDetails();
    // Future.delayed(const Duration(seconds: 2), () {
    //   setState(() {
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: StackedLoadingOverlay(
            isLoading: isLoading,
            contentWidget: Scaffold(
              backgroundColor: const Color(0xFF333333),
              body: CustomScrollView(
                slivers: [
                  SliverPadding(
                      padding: AppConstants.screenPadding,
                      sliver: SliverToBoxAdapter(
                        child: Text(
                          'Title: ${issue.title}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      )),
                  const SliverToBoxAdapter(
                    child: SizedBox(height: 10),
                  ),
                  const SliverPadding(
                      padding: AppConstants.screenPadding,
                      sliver: SliverToBoxAdapter(
                        child: Text('Description:',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      )),
                  SliverToBoxAdapter(
                    child: Markdown(
                      data: issue.body,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                    ),
                  ),
                ],
              ),
            )));
  }
}
