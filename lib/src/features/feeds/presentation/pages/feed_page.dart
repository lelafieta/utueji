import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../../../../config/themes/app_colors.dart';
import '../../../../core/resources/icons/app_icons.dart';
import '../../../../core/utils/app_date_utils_helper.dart';
import '../../../../core/utils/app_utils.dart';
import '../cubit/feed_cubit.dart';
import '../cubit/feed_state.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({
    super.key,
  });

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  @override
  void initState() {
    super.initState();
    context.read<FeedCubit>().getFeeds();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeedCubit, FeedState>(
      builder: (context, state) {
        if (state is FeedLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is FeedLoaded) {
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemBuilder: (context, index) {
              final feed = state.feeds[index];
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Container(
                            width: 40,
                            height: 40,
                            color: Colors.black12,
                            child: CachedNetworkImage(
                              imageUrl: feed.user!.avatarUrl!,
                              fit: BoxFit.cover,
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) =>
                                      CircularProgressIndicator(
                                          value: downloadProgress.progress),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                          ),
                        ),
                        title: Text(
                            "${feed.user!.firstName} ${feed.user!.lastName}"),
                        subtitle: Text(AppDateUtilsHelper.formatDate(
                            data: feed.createdAt!, showTime: true)),
                        trailing: const Icon(Icons.more_vert),
                      ),
                      Text("${feed.description}"),
                      const SizedBox(height: 10),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: SizedBox(
                                width: double.infinity,
                                height: 200,
                                child: CachedNetworkImage(
                                  imageUrl: feed.image!,
                                  fit: BoxFit.cover,
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) =>
                                          SizedBox(
                                    width: 40,
                                    height: 40,
                                    child: CircularProgressIndicator(
                                      value: downloadProgress.progress,
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 0,
                              bottom: 0,
                              right: 0,
                              child: Container(
                                height: 45,
                                color: AppColors.primaryColor,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Doar para sorrir",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      size: 20,
                                      color: Colors.white,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    AppIcons.heartBold,
                                    color: Colors.red,
                                    width: 16,
                                  ),
                                  const SizedBox(width: 5),
                                  const Text(
                                    "55",
                                    style: TextStyle(color: Colors.black),
                                  )
                                ],
                              ),
                              const SizedBox(width: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    AppIcons.commentAlt,
                                    color: Colors.black,
                                    width: 16,
                                  ),
                                  const SizedBox(width: 5),
                                  const Text(
                                    "58",
                                    style: TextStyle(color: Colors.black),
                                  )
                                ],
                              ),
                              const SizedBox(width: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    AppIcons.eye,
                                    color: Colors.black,
                                    width: 16,
                                  ),
                                  const SizedBox(width: 5),
                                  const Text(
                                    "1.2M",
                                    style: TextStyle(color: Colors.black),
                                  )
                                ],
                              )
                            ],
                          ),
                          SvgPicture.asset(
                            AppIcons.paperPlane,
                            color: Colors.black,
                            width: 16,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const Divider(
                height: 20,
              );
            },
            itemCount: 10,
          );
        }
        return const Text("data");
      },
    );
  }
}
