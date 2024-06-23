import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hack_talk/core/helpers/extension.dart';
import 'package:hack_talk/core/theming/app_colors.dart';
import 'package:hack_talk/core/widgets/text_widgets.dart';


class FeaturesScreen extends StatelessWidget {
  const FeaturesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: AppColors.mainColor),
        forceMaterialTransparency: true,
        title: SvgPicture.asset('hacktalk'.getSvgAsset),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SvgPicture.asset('feature1'.getSvgAsset),
            const FeaturesColumn(
              title: 'Computer vision ',
              description:
                  'computer vision can offer in-depth analysis and feedback on users presentations .This might include insights into pacing, tone, body language and overall presentation structure.',
            ),
            SvgPicture.asset('feature2'.getSvgAsset),
            const FeaturesColumn(
                title: 'Speech analysis',
                description:
                    'Speech analysis feature Providing constructive feedback to the speaker based on the analysis, highlighting areas of strength and suggesting areas for improving presentation performance,'),
            SvgPicture.asset('feature3'.getSvgAsset),
            const FeaturesColumn(
              title: 'Virtual reality ',
              description:
                  'virtual reality feature aim to overcome your fear of public speaking  by placing you in an almost real environment so you can practice and get notices about your performance so you can work to improve it  ',
            ),
          
          ],
        ),
      ),
    );
  }
}

class FeaturesColumn extends StatelessWidget {
  const FeaturesColumn(
      {super.key, required this.title, required this.description});
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(22.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
                color: AppColors.mainColor,
                fontWeight: FontWeight.w700,
                fontSize: 20),
          ),
          TextWidget(
            description,
            maxLines: 4,
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.textBodyColor,
          ),
        ],
      ),
    );
  }
}
