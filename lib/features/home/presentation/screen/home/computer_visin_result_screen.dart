import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hack_talk/core/theming/app_colors.dart';
import 'package:hack_talk/core/widgets/text_widgets.dart';
import 'package:hack_talk/features/home/data/repo/computer_vision_result.dart';
import 'package:hack_talk/features/home/logic/cubit/computervisionresult_cubit.dart';
import 'package:hack_talk/features/home/presentation/screen/home/Computer_vision_screen.dart';
import 'package:video_player/video_player.dart';

class CVResultScreen extends StatefulWidget {
  const CVResultScreen({super.key, required this.video});
  final File video;

  @override
  State<CVResultScreen> createState() => _CVResultScreenState();
}

class _CVResultScreenState extends State<CVResultScreen> {
  late VideoPlayerController videoController;

  @override
  void initState() {
    super.initState();
    videoController = VideoPlayerController.file(widget.video)
      ..initialize().then((_) {
        setState(() {
          videoController.play();
        });
      });
  }

  @override
  void dispose() {
    videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ComputervisionresultCubit(ComputerVisionRepository())
        ..showComputerVisionResult(widget.video),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.0,
            leading: IconButton(
              color: Colors.black,
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back),
            ),
            title: const TextWidget('Result',
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
            centerTitle: true,
            actions: const [
              Padding(
                padding: EdgeInsets.all(18.0),
                child: TextWidget(
                  "Done",
                  color: AppColors.mainColor,
                ),
              ),
            ],
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(28.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 200,
                      width: 350,
                      child: VideoPlayer(videoController),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 41,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(90),
                            ),
                            child: TextButton(
                              onPressed: () {
                                videoController.play();
                              },
                              style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text(
                                'play',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 41,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(90),
                          ),
                          child: TextButton(
                            onPressed: () {
                              videoController.pause();
                            },
                            style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text(
                              'stop',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    BlocBuilder<ComputervisionresultCubit, ComputervisionresultState>(
                      builder: (context, state) {
                        if (state is ComputervisionresultLoading) {
                          return const CircularProgressIndicator(
                            color: AppColors.mainColor,
                          );
                        } else if (state is ComputervisionresultLoaded) {
                          final cubit = context.read<ComputervisionresultCubit>();
                          return Column(
                            children: [
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.homeButtonColor,
                                      borderRadius: BorderRadius.circular(40),
                                    ),
                                    height: 100,
                                    width: 100,
                                    child: CircularProgressIndicator(
                                      value: cubit.score! / 100,
                                      backgroundColor: AppColors.homeButtonColor,
                                      valueColor: const AlwaysStoppedAnimation<Color>(
                                          AppColors.mainColor),
                                      strokeWidth: 10,
                                    ),
                                  ),
                                  Text(
                                    "${cubit.score}",
                                    style: const TextStyle(
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.mainColor),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              const TextWidget(
                                "Wonderful! It's not a bad ratio.",
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                              const TextWidget(
                                "It's possible to try again to increase the ratio even more and achieve more efficient performance.",
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                maxLines: 3,
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 12),
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  TextWidget(
                                    'Performance Analysis:',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: DataTable(
                                    columns: const [
                                      DataColumn(label: Text('Second')),
                                      DataColumn(label: Text('Performance')),
                                    ],
                                    rows: List<DataRow>.generate(
                                      cubit.cVResultModel.length,
                                      (index) => DataRow(
                                        color: WidgetStateProperty.resolveWith<Color?>(
                                          (Set<WidgetState> states) {
                                            return index.isEven ? Colors.white : Colors.grey[200];
                                          },
                                        ),
                                        cells: [
                                          DataCell(Text(cubit.cVResultModel[index].time.toString())),
                                          DataCell(Text(cubit.cVResultModel[index].bodyLanguageClass.toString())),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        } else if (state is ComputervisionresultError) {
                          return Text(state.error.toString());
                        } else {
                          return const Text('Press the button to show the result');
                        }
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ComputerVisionScreen(),
                              ),
                            );
                          },
                          style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: const BorderSide(color: AppColors.mainColor),
                            ),
                          ),
                          child: const Text(
                            '          Rate us          ',
                            style: TextStyle(color: AppColors.mainColor),
                          ),
                        ),
                        Container(
                          height: 41,
                          decoration: BoxDecoration(
                            color: AppColors.mainColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ComputerVisionScreen(),
                                ),
                              );
                            },
                            style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text(
                              '          Try again          ',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
