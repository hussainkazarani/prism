import 'package:flutter/material.dart';
import 'package:prism/colors.dart';
import 'package:prism/styles.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    const profileImage = 'assets/images/war_mouse.jpeg';
    const detailsImage = 'assets/images/arrow_top_right2.png';
    const box1Image = 'assets/images/graduation_cap.png';
    const box2Image = 'assets/images/dictionary.png';

    return Scaffold(
      body: SafeArea(
        minimum: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Header(profileImage),
                    SizedBox(height: 25),
                    //name
                    Headline(),
                    SizedBox(height: 30),
                    // marks
                    MarksRow(detailsImage),
                    SizedBox(height: 25),
                  ],
                ),
              ),
              // boxes - line 1
              TwoBoxRow(box1Image, box2Image),
              SizedBox(height: 10),
              //  final large box
              FinalBox(),
            ],
          ),
        ),
      ),
    );
  }

  Container FinalBox() {
    return Container(
      height: 250,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.text,
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Row(children: [Text('Headings')]),
            Text('Economics', style: AppStyles.headingSecondaryBlack),
            SizedBox(height: 15),
            //row 1
            Row(
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '3',
                        style: AppStyles.headingMainBlack.copyWith(height: 1),
                      ),
                      TextSpan(
                        text: 'h',
                        style: AppStyles.bodyBasicBlack.copyWith(height: 1),
                      ),
                      TextSpan(
                        text: '17',
                        style: AppStyles.headingMainBlack.copyWith(height: 1),
                      ),
                      TextSpan(
                        text: 'min',
                        style: AppStyles.bodyBasicBlack.copyWith(height: 1),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Text('Overall Time Spent', style: AppStyles.bodyBasicBlack),
              ],
            ),
            SizedBox(height: 10),
            //row 2
            Row(
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '6',
                        style: AppStyles.headingMainBlack.copyWith(height: 1),
                      ),
                      TextSpan(
                        text: '/ 20',
                        style: AppStyles.bodyBasicBlack.copyWith(height: 1),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Text('Variants Solved', style: AppStyles.bodyBasicBlack),
              ],
            ),
            SizedBox(height: 10),
            //row-3
            Row(
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '28',
                        style: AppStyles.headingMainBlack.copyWith(height: 1),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Text('Mistakes Made', style: AppStyles.bodyBasicBlack),
              ],
            ),
            SizedBox(height: 10),
            //row-4
            Row(
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '5',
                        style: AppStyles.headingMainBlack.copyWith(height: 1),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Text('Badges Earned', style: AppStyles.bodyBasicBlack),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Row TwoBoxRow(box1Image, box2Image) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 200,
          height: 180,
          decoration: BoxDecoration(
            color: AppColors.text,
            borderRadius: BorderRadius.all(Radius.circular(50)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(box1Image, width: 60),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(text: '3', style: AppStyles.headingMainBlack),
                    TextSpan(
                      text: ' / 5 topics',
                      style: AppStyles.bodyBasicLargeBlack,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          width: 200,
          height: 180,
          decoration: BoxDecoration(
            color: AppColors.text,
            borderRadius: BorderRadius.all(Radius.circular(50)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(box2Image, width: 60),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(text: '8', style: AppStyles.headingMainBlack),
                    TextSpan(
                      text: ' / 16 questions',
                      style: AppStyles.bodyBasicLargeBlack,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Row MarksRow(detailsImage) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //left side recent marks
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '58',
                    style: AppStyles.headingMain.copyWith(height: 0.8),
                  ),
                  TextSpan(
                    text: ' / 100',
                    style: AppStyles.bodyBasicLarge.copyWith(height: 0.8),
                  ),
                  TextSpan(
                    text: '\nYour recent score',
                    style: AppStyles.bodyBasicSmall.copyWith(height: 0.8),
                  ),
                ],
              ),
            ),
          ],
        ),
        //right side view details
        Container(
          width: 180,
          height: 70,
          decoration: BoxDecoration(
            color: AppStyles.boxColors,
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('More Details', style: AppStyles.bodyBasicWhite),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(detailsImage, width: 15),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Column Headline() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Social Studies',
          style: AppStyles.headingMain.copyWith(height: 1.2),
        ),
        Text(
          'Exam Preparation',
          style: AppStyles.headingSubMain.copyWith(height: 1),
        ),
      ],
    );
  }

  Row Header(String profileImage) {
    return Row(
      children: [
        Text(
          'Hello,\nHussain!',
          style: AppStyles.bodyBasic.copyWith(height: 1),
        ),
        Spacer(),
        CircleAvatar(radius: 30, backgroundImage: AssetImage(profileImage)),
      ],
    );
  }
}
