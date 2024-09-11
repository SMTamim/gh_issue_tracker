import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gh_issue_tracker/api_helpers/api_repo.dart';
import 'package:gh_issue_tracker/constants/app_colors.dart';
import 'package:gh_issue_tracker/constants/app_constants.dart';
import 'package:gh_issue_tracker/models/git_hub_search_response.dart';
import 'package:gh_issue_tracker/models/issues_response.dart';
import 'package:gh_issue_tracker/screens/user_profile_screen.dart';
import 'package:gh_issue_tracker/utils/helpers/helpers.dart';
import 'package:gh_issue_tracker/utils/widgets/core_widgets.dart';

// ignore: must_be_immutable
class CommitsScreen extends StatefulWidget {
  CommitsScreen({super.key, required this.repo});

  SingleRepo repo;

  @override
  State<CommitsScreen> createState() => _CommitsScreenState();
}

class _CommitsScreenState extends State<CommitsScreen> {
  bool isLoading = true;
  IssuesResponse issues = IssuesResponse();

  Future<void> getIssues() async {
    IssuesResponse? response =
        await APIRepo.getIssueResponse(repo: super.widget.repo);
    if (response == null) {
      log('No response for issues!');
      return;
    }
    log(response.toJson().toString());
    setState(() {
      issues = response;
    });
  }

  @override
  void initState() {
    super.initState();
    getIssues();
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
      });
    });
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Flutter Commit List'),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                                color: AppColors.capsuleColor,
                                borderRadius: BorderRadius.circular(26)),
                            child: Text(widget.repo.defaultBranch),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverList.separated(
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: AppConstants.screenPadding,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                      child: Text(issues.items[index].title)),
                                  Text(
                                    Helper.issueCreatedOn(
                                        issues.items[index].createdAt),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                            color: AppColors.timeTextColor),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              UserProfileScreen(
                                                profileName: issues
                                                    .items[index].user.login,
                                                repo: widget.repo,
                                              )));
                                },
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: Container(
                                          height: 20,
                                          width: 20,
                                          decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: AppColors.capsuleColor),
                                          child: CachedNetworkImage(
                                            imageUrl: issues
                                                .items[index].user.avatarUrl,
                                          )),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      issues.items[index].user.login,
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => const Divider(
                            color: AppColors.defaultDividerColor,
                          ),
                      itemCount: issues.items.length)
                ],
              ),
              bottomNavigationBar: Container(
                padding: const EdgeInsets.symmetric(vertical: 7),
                decoration:
                    const BoxDecoration(color: AppColors.bottomNavBarColor),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.commit,
                            color: AppColors.selectedNavBarColor),
                        Text(
                          'Commits',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  color: AppColors.selectedNavBarColor,
                                  fontSize: 10),
                        )
                      ],
                    ),
                    InkWell(
                      onTap: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UserProfileScreen(
                                      profileName: 'smtamim',
                                      repo: widget.repo,
                                    )))
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.person,
                              color: AppColors.defaultNavBarColor),
                          Text(
                            'User Profile',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    color: AppColors.defaultNavBarColor,
                                    fontSize: 10),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )));
  }
}
