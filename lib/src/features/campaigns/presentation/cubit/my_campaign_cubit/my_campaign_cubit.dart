import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:utueji/src/features/campaigns/presentation/cubit/my_campaign_detail_cubit/my_campaign_detail_state.dart';
import '../../../domain/entities/campaign_entity.dart';
import '../../../domain/entities/campaign_params.dart';
import '../../../domain/usecases/get_all_my_campaigns_usecase.dart';
import 'my_campaign_state.dart';

class MyCampaignCubit extends Cubit<MyCampaignState> {
  final GetAllMyCampaignsUseCase getAllMyCampaignsUseCase;

  MyCampaignCubit({required this.getAllMyCampaignsUseCase})
      : super(MyCampaignInitial());

  int _pageSize = 1;
  int _currentPage = 1;
  bool _hasReachedMax = false;
  int length = 10;
  int _limit = 10;
  List<CampaignEntity> _campaigns = [];
  ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  Future<void> getAllMyCamapigns(
      {bool isRefresh = false, bool init = false}) async {
    if (isRefresh) {
      _pageSize = _currentPage;
      _campaigns = [];
    }

    if (init) {
      _hasReachedMax = false;
      _pageSize = _currentPage;
      emit(MyCampaignLoading());
    }
    if (_hasReachedMax) return;

    final result = await getAllMyCampaignsUseCase
        .call(CampaignParams(page: _currentPage, limit: _limit));

    result.fold(
      (failure) {
        isLoading.value = false;
        emit(
          MyCampaignError(
            message: failure.message.toString(),
          ),
        );
      },
      (rounds) async {
        _pageSize = _pageSize + _currentPage;
        _campaigns.addAll(rounds);
        print("CURRENT PAGE $_pageSize");

        if ((init && rounds.length < length)) {
          _hasReachedMax = true;
          isLoading.value = true;
        } else if (init && rounds.length >= length) {
          final res = await getAllMyCampaignsUseCase
              .call(CampaignParams(page: _currentPage, limit: _limit));

          res.fold((l) {
            isLoading.value = false;
            emit(
              MyCampaignError(
                message: l.message.toString(),
              ),
            );
          }, (r) {
            print("ADICIONOU ${r.length}");
            _campaigns.addAll(r);
            if (r.isEmpty) {
              _hasReachedMax = true;
            }
            _pageSize = _pageSize + _currentPage;
          });
        }

        if (rounds.isEmpty) {
          _hasReachedMax = true;
        }

        init = false;
        emit(MyCampaignLoaded(
            campaigns: _campaigns, isLastPage: _hasReachedMax));
        isLoading.value = false;
      },
    );
  }
}
