import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/entities/no_params.dart';
import '../../domain/usecases/fetch_feeds_usecase.dart';
import 'feed_state.dart';

class FeedCubit extends Cubit<FeedState> {
  final FetchFeedsUseCase fetchFeedsUseCase;

  FeedCubit({required this.fetchFeedsUseCase}) : super(FeedInitial());

  Future<void> getFeeds() async {
    emit(FeedLoading());

    final feeds = fetchFeedsUseCase.call(const NoParams());

    feeds.listen((event) {
      emit(FeedLoaded(feeds: event));
    });
  }
}
