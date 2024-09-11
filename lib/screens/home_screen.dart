import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gh_issue_tracker/api_helpers/api_repo.dart';
import 'package:gh_issue_tracker/constants/app_colors.dart';
import 'package:gh_issue_tracker/constants/app_constants.dart';
import 'package:gh_issue_tracker/models/git_hub_search_response.dart';
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

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  void search() async {
    String query = _searchController.text;
    log('Search Query: $query');

    // Clear previous repos
    setState(() {
      _repos = [];
    });

    List<SingleRepo>? repos =
        await APIRepo.getGitHubSearchResponse(repoName: query);

    if (repos != null) {
      log('Fetched Repos: ${repos.length}');
    } else {
      log('No repos found or null response');
    }

    if (repos != null && repos.isNotEmpty) {
      setState(() {
        _repos = repos;
        log('Repos after setState: ${_repos.length}');
      });
    } else {
      setState(() {
        _repos = [];
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
              body: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 30),
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
                      child: CustomScrollView(
                        slivers: [
                          SliverList.separated(
                            itemBuilder: (context, index) {
                              final repo = _repos[index];

                              return Padding(
                                padding: AppConstants.screenPadding,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          FittedBox(
                                            fit: BoxFit.fitWidth,
                                            child: Text(
                                              '${index + 1}: ${repo.fullName}',
                                              overflow: TextOverflow.clip,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        const Icon(Icons.date_range),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          'Updated At: ${repo.updatedAt}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall
                                              ?.copyWith(
                                                  color:
                                                      AppColors.timeTextColor),
                                        ),
                                      ],
                                    ),
                                  ],
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
                    )
                  ],
                ),
              ),
            )));
  }
}
