import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gh_issue_tracker/api_helpers/api_repo.dart';
import 'package:gh_issue_tracker/constants/app_colors.dart';
import 'package:gh_issue_tracker/constants/app_constants.dart';
import 'package:gh_issue_tracker/models/git_hub_search_response.dart';
import 'package:gh_issue_tracker/screens/issues_list_screen.dart';
import 'package:gh_issue_tracker/utils/helpers/helpers.dart';
import 'package:gh_issue_tracker/utils/widgets/core_widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = true;
  final TextEditingController _searchController = TextEditingController();
  List<SingleRepo> _repos = [];

  Timer? _searchTimer;

  startTimer() {
    _searchTimer = Timer(AppConstants.searchTimerDuration, () {
      search();
    });
  }

  resetTimer() {
    if (_searchTimer?.isActive ?? false) {
      _searchTimer?.cancel();
    }
    startTimer();
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _searchController.text = 'flutter';
        isLoading = false;
        search();
      });
    });
    // _searchController.addListener(search);
  }

  void search() async {
    String query = _searchController.text;
    log('Search Query: $query');

    // Clear previous repos
    setState(() {
      isLoading = true;
      _repos = [];
    });

    List<SingleRepo>? repos =
        await APIRepo.getGitHubSearchResponse(repoName: query);

    if (repos != null && repos.isNotEmpty) {
      setState(() {
        isLoading = false;
        _repos = repos;
      });
    } else {
      setState(() {
        isLoading = false;
        _repos = [];
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
          Container(
            margin: const EdgeInsets.only(top: 80),
            child: Text(
              'GitHub Issue Tracker',
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(color: AppColors.primaryTextColor),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: TextField(
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: AppColors.primaryTextColor),
              controller: _searchController,
              onChanged: (value) => resetTimer(),
              decoration: InputDecoration(
                suffix: IconButton(
                    onPressed: search, icon: const Icon(Icons.search)),
                labelText: 'Search Repo',
                labelStyle: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(fontSize: 19, color: Colors.amber),
                hintText: 'Enter repository name',
                hintStyle: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: AppColors.secondaryTextColor),
              ),
            ),
          ),
          Expanded(
            child: StackedLoadingOverlay(
              isLoading: isLoading,
              contentWidget: CustomScrollView(
                slivers: [
                  SliverList.separated(
                    itemBuilder: (context, index) {
                      SingleRepo repo = _repos[index];

                      return Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            Helper.goToNextRoute(
                              context,
                              IssuesListScreen(repo: repo),
                              false,
                            );
                          },
                          child: Padding(
                            padding: AppConstants.screenPadding,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          '${index + 1}: ${repo.fullName}',
                                          maxLines: 2,
                                          overflow: TextOverflow.clip,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.date_range),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      'Updated At: ${Helper.issueCreatedOn(repo.updatedAt)}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                              color: AppColors.timeTextColor),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => const Divider(
                      color: AppColors.defaultDividerColor,
                    ),
                    itemCount: _repos.length,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }
}
