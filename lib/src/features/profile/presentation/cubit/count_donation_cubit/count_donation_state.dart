part of 'count_donation_cubit.dart';

sealed class CountDonationState extends Equatable {
  const CountDonationState();

  @override
  List<Object> get props => [];
}

final class CountDonationInitial extends CountDonationState {}

final class CountDonationLoading extends CountDonationState {}

final class CountDonationSuccess extends CountDonationState {
  final int counter;

  CountDonationSuccess({required this.counter});
}
