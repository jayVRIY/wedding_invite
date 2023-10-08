import 'dart:io';
import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false, home: WeddingInvitePage());
  }
}

class WeddingInvitePage extends StatefulWidget {
  WeddingInvitePage({super.key});

  @override
  State<WeddingInvitePage> createState() => _WeddingInvitePageState();
}

class _WeddingInvitePageState extends State<WeddingInvitePage> {
  late VideoPlayerController _controller;
  ScrollPhysics scrollPhysics = ScrollPhysics();
  bool isShow = true;
  bool videoPage = true;
  TextStyle textStyle = TextStyle(
      color: Colors.white,
      fontSize: 14,
      fontWeight: FontWeight.w700,
      fontFamily: "NotoSerifSC");

  @override
  void initState() {
    _controller = VideoPlayerController.asset("assets/videos/inviteVideos.mp4")
      ..initialize().then((value) => () {
            setState(() {
              _controller.play();
            });
          });
    _controller.addListener(() {
      VideoPlayerValue value = _controller.value;
      if (value.isCompleted) {
        setState(() {
          videoPage = false;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Stack(
            children: [
              Image.asset(
                "assets/images/AM2I7743.jpg",
                fit: BoxFit.fitHeight,
                height: double.infinity,
              ),
              Padding(
                padding: const EdgeInsets.all(40),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.black45,
                      border: Border.all(color: Colors.white)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 40, horizontal: 30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AutoSizeText(
                          "宴会信息",
                          style: TextStyle(
                            fontSize: 90,
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontFamily: "NotoSerifSC",
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 30),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 100,
                              child: Text(
                                "宴会酒店名称：",
                                style: textStyle,
                              ),
                            ),
                            Expanded(
                              child: Text("昆山隆祺建国饭店(顺帆北路地铁站店)",style: textStyle,),
                            )
                          ],
                        ),Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 100,
                              child: Text(
                                "宴会地址：",
                                style: textStyle,
                              ),
                            ),
                            Expanded(
                              child: Text("苏州市昆山市玉山镇前进东路767号",style: textStyle,),
                            )
                          ],
                        ),Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 100,
                              child: Text(
                                "联系方式：",
                                style: textStyle,
                              ),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("冯嘉辉 15850230502",style: textStyle,),
                                  Text("肖沛     18914971630",style: textStyle,),
                                ],
                              ),
                            )
                          ],
                        ),Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 100,
                              child: Text(
                                "宴会时间：",
                                style: textStyle,
                              ),
                            ),
                            Expanded(
                              child: Text("11月5日 下午5点18分",style: textStyle,),
                            )
                          ],
                        ),
                        SizedBox(height: 60),
                        Container(
                          decoration: BoxDecoration(
                              border:
                              Border.all(color: Colors.white, width: 5)),
                          child: Image.asset(
                            "assets/images/mapImage1.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/images/ezgif-3-88a030c11b.gif",
                              height: 30,
                            ),
                            const Text(
                              '点击图片仔细查看目标地点',
                              style: TextStyle(color: Color(0xFFFFD3AB)),
                            )
                          ],
                        ),
                        SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

          videoPage
              ? Stack(
                  children: [
                    Container(
                      color: Colors.black,
                      child: VideoPlayer(_controller),
                    ),
                    isShow
                        ? Stack(children: [
                            Image(
                              image: AssetImage("images/AM2I7745.jpg"),
                              fit: BoxFit.fitHeight,
                              height: double.infinity,
                            ),
                            Padding(
                              padding: EdgeInsets.all(40),
                              child: Container(
                                width: double.infinity,
                                height: double.infinity,
                                color: Colors.black45,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 80),
                                  child: Column(
                                    children: [
                                      AutoSizeText(
                                        "婚礼邀请函",
                                        style: TextStyle(
                                          fontSize: 90,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w900,
                                          fontFamily: "NotoSerifSC",
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Container(
                                        height: 3,
                                        color: Colors.white,
                                      ),
                                      AutoSizeText(
                                        "INVITATION CARD",
                                        style: TextStyle(
                                          fontSize: 90,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: "NotoSerifSC",
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(
                                        height: 40,
                                      ),
                                      SvgPicture.asset(
                                        "assets/images/上花边.svg",
                                        color: Colors.white,
                                      ),
                                      Text(
                                        "冯嘉辉 & 肖沛",
                                        style: TextStyle(
                                          wordSpacing: 11.0,
                                          fontSize: 26,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: "NotoSerifSC",
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SvgPicture.asset(
                                        "assets/images/下花边.svg",
                                        color: Colors.white,
                                      ),
                                      Expanded(
                                          child: Container(
                                        child: Image.asset(
                                            "assets/images/AM2I7660.jpg"),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                          color: Colors.white,
                                        )),
                                      )),
                                      Expanded(
                                          child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            this.isShow = false;
                                            _controller.play();
                                          });
                                        },
                                        child: Stack(
                                          children: [
                                            Center(
                                              child: SvgPicture.asset(
                                                "assets/images/边框.svg",
                                                color: Colors.white,
                                              ),
                                            ),
                                            Center(
                                              child: Text(
                                                "点击开始",
                                                style: TextStyle(
                                                    fontSize: 22,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white),
                                              ),
                                            )
                                          ],
                                        ),
                                      ))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ])
                        : Container(),
                  ],
                )
              : Container(),
        ],
      ),
    );
  }
}
