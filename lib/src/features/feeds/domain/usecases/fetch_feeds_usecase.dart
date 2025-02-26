import '../../../../core/entities/no_params.dart';
import '../../../../core/usecases/stream_usecase.dart';
import '../entities/feed_entity.dart';
import '../repositories/i_feed_repository.dart';

class FetchFeedsUseCase extends StreamUseCase<List<FeedEntity>, NoParams> {
  final IFeedRepository repository;

  FetchFeedsUseCase({required this.repository});

  @override
  Stream<List<FeedEntity>> call(NoParams params) {
    return repository.fetchFeeds();
  }
}
