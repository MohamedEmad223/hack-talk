import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:hack_talk/features/home/data/models/Computer_vision_model.dart';
import 'package:hack_talk/features/home/data/repo/computer_vision_result.dart';
import 'package:meta/meta.dart';

part 'computervisionresult_state.dart';

class ComputervisionresultCubit extends Cubit<ComputervisionresultState> {
  ComputervisionresultCubit(this.computerVisionRepository) : super(ComputervisionresultInitial());
  List<ComputerVisionModel> cVResultModel = [];
  late ComputerVisionRepository computerVisionRepository;
  double? score;

  Future<void> showComputerVisionResult(File file) async {
    emit(ComputervisionresultLoading());

    try {
      final result = await computerVisionRepository.getComputerVisionResult(file);
      cVResultModel = result["models"];
      score = result["score"];
      emit(ComputervisionresultLoaded());
    } catch (error) {
      emit(ComputervisionresultError(
        error: error.toString(),
      ));
    }
  }
}
