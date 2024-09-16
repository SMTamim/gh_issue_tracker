import 'package:flutter/material.dart';
import 'package:gh_issue_tracker/constants/app_colors.dart';
import 'package:gh_issue_tracker/models/git_hub_search_response.dart';
import 'package:gh_issue_tracker/screens/issues_list_screen.dart';
import 'package:gh_issue_tracker/screens/user_profile_screen.dart';
import 'package:gh_issue_tracker/utils/helpers/helpers.dart';

class CoreWidgets {}

class StackedLoadingOverlay extends StatelessWidget {
  final bool isLoading;
  final Widget contentWidget;
  const StackedLoadingOverlay(
      {super.key, required this.isLoading, required this.contentWidget});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        contentWidget,
        isLoading
            ? Positioned.fill(
                child: Container(
                  decoration:
                      BoxDecoration(color: Colors.black.withOpacity(0.3)),
                  child: const Center(
                    child: SizedBox(
                        height: 250, width: 250, child: Icon(Icons.pending)),
                  ),
                ),
              )
            : Container()
      ],
    );
  }
}

class CommonNavigationBar extends StatelessWidget {
  const CommonNavigationBar(
      {super.key, required this.repo, this.isUserScreen = false});

  final SingleRepo repo;
  final bool isUserScreen;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 7),
      decoration: const BoxDecoration(color: AppColors.bottomNavBarColor),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            onTap: isUserScreen
                ? () {
                    Helper.goToNextRoute(
                        context,
                        IssuesListScreen(
                          repo: repo,
                        ));
                  }
                : null,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.commit,
                    color: isUserScreen
                        ? AppColors.defaultNavBarColor
                        : AppColors.selectedNavBarColor),
                Text(
                  'Commits',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: isUserScreen
                          ? AppColors.defaultNavBarColor
                          : AppColors.selectedNavBarColor,
                      fontSize: 10),
                )
              ],
            ),
          ),
          InkWell(
            onTap: isUserScreen
                ? null
                : () => Helper.goToNextRoute(
                    context,
                    UserProfileScreen(
                      profileName: 'smtamim',
                      repo: repo,
                    )),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.person,
                    color: isUserScreen
                        ? AppColors.selectedNavBarColor
                        : AppColors.defaultNavBarColor),
                Text(
                  'User Profile',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: isUserScreen
                          ? AppColors.selectedNavBarColor
                          : AppColors.defaultNavBarColor,
                      fontSize: 10),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
