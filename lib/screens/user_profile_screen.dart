import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gh_issue_tracker/api_helpers/api_repo.dart';
import 'package:gh_issue_tracker/constants/app_colors.dart';
import 'package:gh_issue_tracker/constants/app_constants.dart';
import 'package:gh_issue_tracker/models/git_hub_profile_response.dart';
import 'package:gh_issue_tracker/models/git_hub_search_response.dart';
import 'package:gh_issue_tracker/utils/widgets/core_widgets.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({
    super.key,
    required this.profileName,
    required this.repo,
  });
  final String profileName;
  final SingleRepo repo;

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
    getProfile();
    super.initState();
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
                        child: isLoading
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : Column(
                                children: [
                                  if (ghProfile.avatarUrl.isNotEmpty)
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
                                  Text(ghProfile.name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge),
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
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Text("Public Repos: ${ghProfile.publicRepos}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text("Public Gists: ${ghProfile.publicGists}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text("Followers: ${ghProfile.followers}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium),
                                ],
                              ),
                      )),
                ],
              ),
              bottomNavigationBar:
                  CommonNavigationBar(repo: widget.repo, isUserScreen: true),
            )));
  }
}
