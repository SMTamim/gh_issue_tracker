import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:gh_issue_tracker/api_helpers/api_repo.dart';
import 'package:gh_issue_tracker/constants/app_colors.dart';
import 'package:gh_issue_tracker/constants/app_constants.dart';
import 'package:gh_issue_tracker/models/issue_response.dart';
import 'package:gh_issue_tracker/models/issues_response.dart';
import 'package:gh_issue_tracker/utils/widgets/core_widgets.dart';

class ViewIssueScreen extends StatefulWidget {
  const ViewIssueScreen(
      {super.key,
      required this.issue,
      required this.owner,
      required this.repo});

  final Issues issue;
  final String owner;
  final String repo;

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
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: StackedLoadingOverlay(
            isLoading: isLoading,
            contentWidget: Scaffold(
              backgroundColor: AppColors.backgroundColor,
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
                      styleSheet: MarkdownStyleSheet(
                          h1: TextStyle(color: AppColors.blockQuoteColor),
                          h2: TextStyle(color: AppColors.blockQuoteColor),
                          h3: TextStyle(color: AppColors.blockQuoteColor),
                          h4: TextStyle(color: AppColors.blockQuoteColor),
                          h5: TextStyle(color: AppColors.blockQuoteColor),
                          h6: TextStyle(color: AppColors.blockQuoteColor),
                          code: const TextStyle(
                              color: AppColors.codeTextColor,
                              backgroundColor: AppColors.codeBackgroundColor),
                          codeblockDecoration: const BoxDecoration(
                              color: AppColors.codeblockDecorationColor),
                          blockquote:
                              TextStyle(color: AppColors.blockQuoteColor),
                          blockquoteDecoration: const BoxDecoration(
                              color: Colors.black, shape: BoxShape.circle)),
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
