import 'package:flutter/material.dart';
import 'package:gh_issue_tracker/constants/app_colors.dart';
import 'package:gh_issue_tracker/constants/app_constants.dart';
import 'package:gh_issue_tracker/utils/widgets/core_widgets.dart';

class CommitsScreen extends StatefulWidget {
  const CommitsScreen({super.key});

  @override
  State<CommitsScreen> createState() => _CommitsScreenState();
}

class _CommitsScreenState extends State<CommitsScreen> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
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
                            child: const Text('master'),
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
                                  Text('$index: Number'),
                                  Text(
                                    'Yesterday',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                            color: AppColors.timeTextColor),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.person),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    'Francisco Miles',
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  )
                                ],
                              )
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => const Divider(
                            color: AppColors.defaultDividerColor,
                          ),
                      itemCount: 10)
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
                    Column(
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
                    )
                  ],
                ),
              ),
            )));
  }
}
