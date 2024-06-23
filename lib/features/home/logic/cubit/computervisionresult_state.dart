part of 'computervisionresult_cubit.dart';

@immutable
sealed class ComputervisionresultState {}

final class ComputervisionresultInitial extends ComputervisionresultState {}

final class ComputervisionresultLoading extends ComputervisionresultState {}

final class ComputervisionresultLoaded extends ComputervisionresultState {}

final class ComputervisionresultError extends ComputervisionresultState {
final String? error;
ComputervisionresultError({required this.error});
}
