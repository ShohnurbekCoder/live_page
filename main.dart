import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(MaterialApp(home: BeforeLiveMatchPage(), debugShowCheckedModeBanner: false));
}

class AppColors {
  static final colorEA = Color(0xFFEA4335);
  static final grey = Color(0xFF7C7C7C);
  static final CBackground = Color(0xFF0C0C0C);
  static final CSide = Color(0xFF1F1F1F);
}

class AppStyles {
  static final tapbar = TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white);
  static final Text1 = TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black);
  static final Text2 = TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white);
}

class AppImages {
  static final football = 'assets/images/football.png';
  static final girl = 'assets/images/girl.png';
}

class BeforeLiveMatchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      child: Scaffold(
        backgroundColor: AppColors.CBackground,
        appBar: AppBar(
          backgroundColor: AppColors.CBackground,
          leading: Icon(Icons.arrow_back, color: Colors.white),
          centerTitle: true,
          title: Text("Premier League", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: Colors.white)),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              BeforeLiveImage(),
              SizedBox(height: 24.h),
              Newtapbar(),
            ],
          ),
        ),
      ),
    );
  }
}

class BeforeLiveImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 230.h,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(AppImages.football), fit: BoxFit.cover),
          ),
        ),
        Container(
          height: 230.h,
          width: double.infinity,
          decoration: BoxDecoration(gradient: BeforeLiveMatchPageGradient()),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 12,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(radius: 18, backgroundImage: AssetImage(AppImages.girl)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4),
                child: Text('VS', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Colors.white)),
              ),
              CircleAvatar(radius: 18, backgroundImage: AssetImage(AppImages.girl)),
            ],
          ),
        ),
      ],
    );
  }
}

class BeforeLiveMatchPageGradient extends Gradient {
  BeforeLiveMatchPageGradient()
      : super.linear(
          colors: [Color(0xFF0C0C0C).withOpacity(0.6), Color(0xFF0C0C0C).withOpacity(0.6)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );
}

class Newtapbar extends StatefulWidget {
  @override
  State<Newtapbar> createState() => _NewtapbarState();
}

class _NewtapbarState extends State<Newtapbar> with SingleTickerProviderStateMixin {
  bool IsTap = false;
  late final TabController controller;

  @override
  void initState() {
    controller = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String text1 =
        "Inter will face Roberto D’Aversa and his new look Sampdoria side on Sunday afternoon. Though only on one point so far this season, Sampdoria have provided two decent showings against strong competition in Sassuolo and AC Milan. They drew 0-0 away to Sassuolo then suffered a narrow 1-0 defeat at home to Milan. The Ligurian side also added a substantial striking presence to supplement Fabio Quagliarella in another veteran, Francesco Caputo";

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          SizedBox(
            height: 28.h,
            child: TabBar(
              controller: controller,
              indicatorColor: AppColors.colorEA,
              dividerHeight: 0.4,
              dividerColor: Color(0xFF343434),
              tabs: [
                Text('Description', style: AppStyles.tapbar),
                Text('Match Schedule', style: AppStyles.tapbar),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          SizedBox(
            height: 330.h,
            child: TabBarView(
              controller: controller,
              children: [
                RichText(
                  text: TextSpan(
                    text: IsTap ? text1 : (text1.length > 100 ? text1.substring(0, 100) + '...' : text1),
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 13, color: AppColors.grey),
                    children: [
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            IsTap = !IsTap;
                            setState(() {});
                          },
                        text: IsTap ? ' read less' : ' Read More',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF5C5C5C),
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
                Minicontainer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Minicontainer extends StatefulWidget {
  @override
  State<Minicontainer> createState() => _MinicontainerState();
}

class _MinicontainerState extends State<Minicontainer> {
  int ActiveInx = 0;
  List title = ["Today, 12 Sep", "Mon, 13 Sep", "Tue, 14 Sep", "We, 15 Sep"];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(title.length, (index) {
          return GestureDetector(
            onTap: () {
              ActiveInx = index;
              setState(() {});
            },
            child: Container(
              alignment: Alignment.center,
              height: 32,
              margin: EdgeInsets.all(5),
              padding: EdgeInsets.symmetric(horizontal: 10.5),
              decoration: BoxDecoration(
                border: Border.all(
                  color: ActiveInx == index ? Colors.white : AppColors.CSide,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(6),
                color: ActiveInx == index ? Colors.white : AppColors.CBackground,
              ),
              child: Text(
                title[index],
                style: ActiveInx == index ? AppStyles.Text1 : AppStyles.Text2,
              ),
            ),
          );
        }),
      ),
    );
  }
}