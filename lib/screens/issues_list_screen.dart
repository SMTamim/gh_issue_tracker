import 'dart:async';
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

class IssuesListScreen extends StatefulWidget {
  const IssuesListScreen({super.key, required this.repo});

  final SingleRepo repo;

  @override
  State<IssuesListScreen> createState() => _IssuesListScreenState();
}

class _IssuesListScreenState extends State<IssuesListScreen> {
  bool isLoading = true;
  bool includeFlutter = false;
  String textToInclude = 'flutter';
  Timer? _searchTimer;
  List<Issues> _issues = [];
  final TextEditingController _searchController = TextEditingController();

  Future<void> getIssues() async {
    List<Issues>? response =
        await APIRepo.getIssueResponse(repo: super.widget.repo);
    if (response == null) {
      log('No response for issues!');
      return;
    }

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

// start the timer
  startTimer() {
    _searchTimer = Timer(AppConstants.searchTimerDuration, () {
      _search();
    });
  }

  // reset the search timer. To prevent excessive call to the api
  resetTimer() {
    if (_searchTimer?.isActive ?? false) {
      _searchTimer?.cancel();
    }
    startTimer();
  }

  // actual search method
  void _search() async {
    if (_searchController.text.isEmpty) {
      return;
    }
    setState(() {
      isLoading = true;
    });
    String query = _searchController.text;

    List<Issues>? issues = await APIRepo.getSearchedIssues(
        owner: widget.repo.owner.login,
        repoName: widget.repo.name,
        query: query);

    if (issues != null && issues.isNotEmpty) {
      setState(() {
        // load the issues if response found with data
        isLoading = false;
        _issues = issues;
      });
    } else {
      setState(() {
        isLoading = false;
        // set empty list if no response found
        _issues = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Column(
        children: [
          Padding(
            padding: AppConstants.screenPadding,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(Helper.formattedTitle(AppConstants.commitScreenTitle,
                    Helper.capitalizeText(text: widget.repo.name))),
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
          Padding(
              padding: AppConstants.screenPadding,
              child: TextField(
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: AppColors.primaryTextColor),
                controller: _searchController,
                onChanged: (value) => resetTimer(),
                decoration: InputDecoration(
                  suffix: IconButton(
                      onPressed: _search, icon: const Icon(Icons.search)),
                  labelText: AppConstants.commitScreenSearchLabel,
                  labelStyle: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(fontSize: 19, color: Colors.amber),
                  hintText: AppConstants.commitScreenSearchTextHint,
                  hintStyle: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: AppColors.secondaryTextColor),
                ),
              )),
          Row(
            children: [
              Checkbox(
                  value: includeFlutter,
                  activeColor: AppColors.capsuleColor,
                  onChanged: (value) {
                    setState(() {
                      isLoading = true;
                      includeFlutter = value!;
                      Future.delayed(AppConstants.defaultLoadingDelay, () {
                        setState(() {
                          isLoading = false;
                        });
                      });
                    });
                  }),
              GestureDetector(
                  onTap: () {
                    setState(() {
                      isLoading = true;
                      includeFlutter = !includeFlutter;
                      Future.delayed(AppConstants.defaultLoadingDelay, () {
                        setState(() {
                          isLoading = false;
                        });
                      });
                    });
                  },
                  child: Text(
                      'Show results with `${Helper.capitalizeText(text: textToInclude)}` in title.'))
            ],
          ),
          Expanded(
              child: StackedLoadingOverlay(
                  isLoading: isLoading,
                  contentWidget: CustomScrollView(
                    slivers: [
                      SliverList.separated(
                          itemBuilder: (context, index) {
                            // Check if the title container the word Flutter or flutter
                            String title = _issues[index].title;
                            if (title
                                    .toLowerCase()
                                    .contains(textToInclude.toLowerCase()) &&
                                !includeFlutter) {
                              return const SizedBox.shrink();
                            }
                            return Padding(
                              padding: AppConstants.screenPadding,
                              child: InkWell(
                                onTap: () {
                                  Helper.goToNextRoute(
                                      context,
                                      ViewIssueScreen(
                                        issue: _issues[index],
                                        owner: widget.repo.owner.login,
                                        repo: widget.repo.name,
                                      ),
                                      false);
                                },
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                            child: Text(_issues[index].title)),
                                        Text(
                                          Helper.issueCreatedOn(
                                              _issues[index].createdAt),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall
                                              ?.copyWith(
                                                  color:
                                                      AppColors.timeTextColor),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Helper.goToNextRoute(
                                            context,
                                            UserProfileScreen(
                                              profileName:
                                                  _issues[index].user.login,
                                              repo: widget.repo,
                                            ),
                                            false);
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
                                                    color:
                                                        AppColors.capsuleColor),
                                                child: CachedNetworkImage(
                                                  imageUrl: _issues[index]
                                                      .user
                                                      .avatarUrl,
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
                            // Check if the title container the word textToInclude // in this case flutter
                            String title = _issues[index].title;
                            if (title
                                    .toLowerCase()
                                    .contains(textToInclude.toLowerCase()) &&
                                !includeFlutter) {
                              return const SizedBox.shrink();
                            }
                            return const Divider(
                              color: AppColors.defaultDividerColor,
                            );
                          },
                          itemCount: _issues.length)
                    ],
                  )))
        ],
      ),
      bottomNavigationBar: CommonNavigationBar(repo: widget.repo),
    ));
  }
}
