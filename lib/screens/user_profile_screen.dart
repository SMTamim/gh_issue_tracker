import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gh_issue_tracker/api_helpers/api_repo.dart';
import 'package:gh_issue_tracker/constants/app_colors.dart';
import 'package:gh_issue_tracker/constants/app_constants.dart';
import 'package:gh_issue_tracker/models/git_hub_profile_response.dart';
import 'package:gh_issue_tracker/models/git_hub_search_response.dart';
import 'package:gh_issue_tracker/screens/commits_screen.dart';
import 'package:gh_issue_tracker/utils/widgets/core_widgets.dart';

// ignore: must_be_immutable
class UserProfileScreen extends StatefulWidget {
  UserProfileScreen({
    super.key,
    required this.profileName,
    required this.repo,
  });
  String profileName;
  SingleRepo repo;

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  bool isLoading = true;
  GitHubProfileResponse ghProfile = GitHubProfileResponse();

  Future<void> getProfile() async {
    GitHubProfileResponse? response =
        await APIRepo.getProfileResponse(profileName: widget.profileName);
    if (response == null) {
      log('No response for issues!');
      return;
    }
    log(response.toJson().toString());
    setState(() {
      ghProfile = response;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getProfile();
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
                  const SliverPadding(
                    padding: AppConstants.screenPadding,
                    sliver: SliverToBoxAdapter(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('User Profile'),
                        ],
                      ),
                    ),
                  ),
                  SliverPadding(
                      padding: AppConstants.screenPadding,
                      sliver: SliverToBoxAdapter(
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Container(
                                  height: 168,
                                  width: 168,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.capsuleColor),
                                  child: CachedNetworkImage(
                                    imageUrl: ghProfile.avatarUrl,
                                  )),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Text(ghProfile.name ?? 'Name not set',
                                style: Theme.of(context).textTheme.bodyLarge),
                            Text("@${ghProfile.login}",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(fontSize: 18)),
                            const SizedBox(
                              height: 16,
                            ),
                            Text(
                                "Bio: ${ghProfile.bio.length > 16 ? '${ghProfile.bio.substring(0, 14)}...' : ghProfile.bio}",
                                style: Theme.of(context).textTheme.bodyMedium),
                            const SizedBox(
                              height: 16,
                            ),
                            Text("Public Repos: ${ghProfile.publicRepos}",
                                style: Theme.of(context).textTheme.bodyMedium),
                            const SizedBox(
                              height: 8,
                            ),
                            Text("Public Gists: ${ghProfile.publicGists}",
                                style: Theme.of(context).textTheme.bodyMedium),
                            const SizedBox(
                              height: 8,
                            ),
                            Text("Followers: ${ghProfile.followers}",
                                style: Theme.of(context).textTheme.bodyMedium),
                          ],
                        ),
                      )),
                ],
              ),
              bottomNavigationBar: Container(
                padding: const EdgeInsets.symmetric(vertical: 7),
                decoration:
                    const BoxDecoration(color: AppColors.bottomNavBarColor),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    CommitsScreen(repo: widget.repo)));
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.commit,
                              color: AppColors.defaultNavBarColor),
                          Text(
                            'Commits',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    color: AppColors.defaultNavBarColor,
                                    fontSize: 10),
                          )
                        ],
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.person,
                            color: AppColors.selectedNavBarColor),
                        Text(
                          'User Profile',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  color: AppColors.selectedNavBarColor,
                                  fontSize: 10),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )));
  }
}
