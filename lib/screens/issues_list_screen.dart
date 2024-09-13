import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gh_issue_tracker/api_helpers/api_repo.dart';
import 'package:gh_issue_tracker/constants/app_colors.dart';
import 'package:gh_issue_tracker/constants/app_constants.dart';
import 'package:gh_issue_tracker/models/git_hub_search_response.dart';
import 'package:gh_issue_tracker/models/issues_response.dart';
import 'package:gh_issue_tracker/screens/user_profile_screen.dart';
import 'package:gh_issue_tracker/screens/view_issue_screen.dart';
import 'package:gh_issue_tracker/utils/helpers/helpers.dart';
import 'package:gh_issue_tracker/utils/widgets/core_widgets.dart';

// ignore: must_be_immutable
class IssuesListScreen extends StatefulWidget {
  IssuesListScreen({super.key, required this.repo});

  SingleRepo repo;

  @override
  State<IssuesListScreen> createState() => _IssuesListScreenState();
}

class _IssuesListScreenState extends State<IssuesListScreen> {
  bool isLoading = true;
  List<Issues> _issues = [];
  final TextEditingController _searchController = TextEditingController();

  Future<void> getIssues() async {
    List<Issues>? response =
        await APIRepo.getIssueResponse(repo: super.widget.repo);
    if (response == null) {
      log('No response for issues!');
      return;
    }
    // log(response.toJson().toString());
    setState(() {
      _issues = response;
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

  void search() async {
    String query = _searchController.text;
    log('Search Query: $query');

    List<Issues>? issues = await APIRepo.getSearchedIssues(
        owner: widget.repo.owner.login,
        repoName: widget.repo.name,
        query: query);

    if (issues != null) {
      log('Fetched Repos: ${issues.length}');
    } else {
      log('No repos found or null response');
    }

    if (issues != null && issues.isNotEmpty) {
      setState(() {
        _issues = issues;
        log('Repos after setState: ${_issues.length}');
      });
    } else {
      setState(() {
        _issues = [];
        log('No repos found, setting empty list');
      });
    }
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
                  SliverPadding(
                      padding: AppConstants.screenPadding,
                      sliver: SliverToBoxAdapter(
                        child: TextField(
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: AppColors.primaryTextColor),
                          controller: _searchController,
                          decoration: InputDecoration(
                            suffix: IconButton(
                                onPressed: search,
                                icon: const Icon(Icons.search)),
                            labelText: 'Search Issue',
                            labelStyle: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(fontSize: 19, color: Colors.amber),
                            hintText: 'Enter issue search term',
                            hintStyle: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: AppColors.secondaryTextColor),
                          ),
                        ),
                      )),
                  SliverList.separated(
                      itemBuilder: (context, index) {
                        // Check if the title container the word Flutter or flutter
                        String title = _issues[index].title;
                        if (title.toLowerCase().contains('flutter')) {
                          return const SizedBox.shrink();
                        }
                        return Padding(
                          padding: AppConstants.screenPadding,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ViewIssueScreen(
                                            issue: _issues[index],
                                            owner: widget.repo.owner.login,
                                            repo: widget.repo.name,
                                          )));
                            },
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(child: Text(_issues[index].title)),
                                    Text(
                                      Helper.issueCreatedOn(
                                          _issues[index].createdAt),
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
                                                  profileName:
                                                      _issues[index].user.login,
                                                  repo: widget.repo,
                                                )));
                                  },
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: Container(
                                            height: 20,
                                            width: 20,
                                            decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: AppColors.capsuleColor),
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  _issues[index].user.avatarUrl,
                                            )),
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        _issues[index].user.login,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        // Check if the title container the word Flutter or flutter
                        String title = _issues[index].title;
                        if (title.toLowerCase().contains('flutter')) {
                          return const SizedBox.shrink();
                        }
                        return const Divider(
                          color: AppColors.defaultDividerColor,
                        );
                      },
                      itemCount: _issues.length)
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
