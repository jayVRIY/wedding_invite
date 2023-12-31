import 'dart:async';
import 'dart:html';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: WeddingInvitePage());
  }
}

class MusicManger {
  static final musicManger = MusicManger(url: "assets/audio/bgm.mp3");
  String url;
  final AudioPlayer player = AudioPlayer();

  MusicManger({required this.url, this.isPlay = true}) {
    setUrl(url);
  }

  bool isPlay;

  Future<void> setUrl(String url) async {
    await player.setAsset(url);
    player.setLoopMode(LoopMode.all);
  }
}

class WeddingInvitePage extends StatefulWidget {
  const WeddingInvitePage({super.key});

  @override
  State<WeddingInvitePage> createState() => _WeddingInvitePageState();
}

class _WeddingInvitePageState extends State<WeddingInvitePage> {
  var bgmManger = MusicManger.musicManger;
  late VideoPlayerController _controller;
  ScrollPhysics scrollPhysics = const ScrollPhysics();
  bool isShow = true;
  bool videoPage = true;
  bool isShow1 = true;
  String name = "";
  String number = "";
  bool showLoding = true;
  String loadingMsg = "请柬正在加载中...";
  Size size = const Size(0, 0);

  @override
  void initState() {
    _controller = VideoPlayerController.asset("assets/videos/inviteVideos.mp4")
      ..initialize().then((value) => () {
            setState(() {});
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
    int count = 0;
    Timer.periodic(const Duration(seconds: 1), (timer) {
      count++;
      if (count == 7) {
        setState(() {
          showLoding = false;
          timer.cancel();
        });
      }
    });
  }

  final TextStyle _textStyle = const TextStyle(
      color: Colors.white,
      fontSize: 14,
      fontWeight: FontWeight.w700,
      fontFamily: "NotoSerifSC");

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    if (size.width == 0) {
      print(screenSize.toString());
      size = screenSize;
    }
    ;
    print(size.width);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          width: size.width,
          height: size.height,
          decoration: const BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
                image: AssetImage(
                  "assets/images/AM2I7743.jpg",
                ),
                fit: BoxFit.cover,
                alignment: Alignment.topCenter),
          ),
          child: Stack(children: [
            PageView(scrollDirection: Axis.vertical, children: [
              HotelPageOne(textStyle: _textStyle),
              Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                      width: size.width,
                      height: size.height,
                      decoration: BoxDecoration(
                          color: Colors.black45,
                          border: Border.all(color: Colors.white)),
                      child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 30),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const AutoSizeText(
                                  "填写出席信息",
                                  style: TextStyle(
                                    fontSize: 60,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900,
                                    fontFamily: "NotoSerifSC",
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.visible,
                                ),
                                const SizedBox(height: 30),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "姓名",
                                      style: _textStyle.copyWith(fontSize: 18),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    TextField(
                                        onChanged: (text) {
                                          setState(() {
                                            name = text;
                                          });
                                        },
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontFamily: "NotoSerifSC",
                                        ),
                                        keyboardType: TextInputType.text,
                                        cursorColor: Colors.white,
                                        decoration: const InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.white),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(100.0)),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.white),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(100.0)),
                                          ),
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 4, horizontal: 20),
                                        )),
                                    const SizedBox(
                                      height: 25,
                                    ),
                                    Text(
                                      "家中出席人数",
                                      style: _textStyle.copyWith(fontSize: 18),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    TextField(
                                        onChanged: (text) {
                                          setState(() {
                                            number = text;
                                          });
                                        },
                                        keyboardType: TextInputType.number,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontFamily: "NotoSerifSC",
                                        ),
                                        cursorColor: Colors.white,
                                        decoration: const InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.white),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(100.0)),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.white),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(100.0)),
                                          ),
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 4, horizontal: 20),
                                        )),
                                    const SizedBox(
                                      height: 45,
                                    ),
                                    MaterialButton(
                                      onPressed: () async {
                                        Map<String, String> params = {
                                          "guestName": name,
                                          "guestPreventNum": number,
                                        };
                                        Map<String, String> headers = {
                                          'Content-Type': 'application/json',
                                          "Access-Control-Allow-Origin": '*',
                                        };
                                        String jsonParams = jsonEncode(params);

                                        http.Response response =
                                            await http.post(
                                          Uri.parse("/api/addguest"),
                                          headers: headers,
                                          body: jsonParams,
                                        );
                                        if (response.statusCode == 200) {
                                          // 请求成功
                                          Map<String, dynamic> responseData =
                                              jsonDecode(response.body);
                                          if (responseData["code"] == 200) {
                                            showDialog<void>(
                                              context: context,
                                              barrierDismissible: false,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  content:
                                                      SingleChildScrollView(
                                                          child: Text(
                                                    "登记成功，期待您的到来",
                                                    style: TextStyle(
                                                      fontFamily: "NotoSerifSC",
                                                    ),
                                                  )),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      child: const Text('确定',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                "NotoSerifSC",
                                                          )),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    ),
                                                  ],
                                                );
                                              },
                                            ).then((val) {});
                                          } else {
                                            showDialog<void>(
                                              context: context,
                                              barrierDismissible: false,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  content:
                                                      SingleChildScrollView(
                                                          child: Text(
                                                    "登记失败，请联系发请柬人登记\n${responseData.toString()}",
                                                    style: TextStyle(
                                                      fontFamily: "NotoSerifSC",
                                                    ),
                                                  )),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      child: const Text('确定',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                "NotoSerifSC",
                                                          )),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    ),
                                                  ],
                                                );
                                              },
                                            ).then((val) {});
                                          }
                                          // 处理响应数据
                                        } else {
                                          // 请求失败
                                          showDialog<void>(
                                            context: context,
                                            barrierDismissible: false,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                content: SingleChildScrollView(
                                                    child: Text(
                                                  "登记失败，请联系发请柬人登记\n${response.statusCode}",
                                                  style: TextStyle(
                                                    fontFamily: "NotoSerifSC",
                                                  ),
                                                )),
                                                actions: <Widget>[
                                                  TextButton(
                                                    child: const Text('确定',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              "NotoSerifSC",
                                                        )),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                ],
                                              );
                                            },
                                          ).then((val) {});
                                        }
                                      },
                                      minWidth: size.width,
                                      shape: const RoundedRectangleBorder(
                                          side: BorderSide(
                                              color: Colors.white, width: 1),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(200))),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 18),
                                      child: const Text(
                                        "提交",
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w900,
                                          fontFamily: "NotoSerifSC",
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 100,
                                          child: Text(
                                            "联系方式：",
                                            style: _textStyle,
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "冯嘉辉 15850230502",
                                                style: _textStyle,
                                              ),
                                              Text(
                                                "肖沛     18914971630",
                                                style: _textStyle,
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                )
                              ]))))
            ]),
            VideoPage(videoPage: videoPage, controller: _controller),
            isShow1 ? FirstInvitePage() : Container(),
            showLoding
                ? Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: const Color(0xfffffcfc),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/010-flamenco-dancers-sexy-couple-silhouettes.png",
                            width: 100,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            loadingMsg,
                            style: _textStyle.copyWith(
                                fontSize: 22, color: Colors.grey),
                          )
                        ],
                      ),
                    ),
                  )
                : Container(),
            Offstage(
              offstage: true,
              child: Column(
                children: [
                  Image.asset("assets/images/上花边.png"),
                  Image.asset("assets/images/下花边.png"),
                  Image.asset("assets/images/边框.png"),
                  Image.asset("assets/images/AM2I7660.jpg"),
                  Image.asset("assets/images/AM2I7743.jpg"),
                  Image.asset("assets/images/mapImage1.png"),
                  Image.asset("assets/images/ezgif-3-88a030c11b.gif"),
                ],
              ),
            )
          ]),
        ));
  }

  AnimatedOpacity FirstInvitePage() {
    return AnimatedOpacity(
      onEnd: () {
        setState(() {
          isShow1 = false;
        });
      },
      opacity: isShow ? 1.0 : 0,
      duration: const Duration(milliseconds: 800),
      child: Stack(children: [
        Image.asset(
          "assets/images/AM2I7743.jpg",
          fit: BoxFit.fitHeight,
          height: double.infinity,
        ),
        Padding(
          padding: const EdgeInsets.all(40),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black45,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const AutoSizeText(
                    "婚礼邀请函",
                    style: TextStyle(
                      fontSize: 90,
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontFamily: "NotoSerifSC",
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.visible,
                  ),
                  Container(
                    height: 3,
                    color: Colors.white,
                  ),
                  const AutoSizeText(
                    "INVITATION CARD",
                    style: TextStyle(
                      fontSize: 90,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontFamily: "NotoSerifSC",
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.visible,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Image.asset(
                    "assets/images/上花边.png",
                    color: Colors.white,
                  ),
                  const Text(
                    "冯嘉辉 & 肖沛",
                    style: TextStyle(
                      wordSpacing: 11.0,
                      fontSize: 26,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontFamily: "NotoSerifSC",
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.visible,
                  ),
                  Image.asset(
                    "assets/images/下花边.png",
                    color: Colors.white,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Expanded(
                      child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                      color: Colors.white,
                    )),
                    child: Image.asset("assets/images/AM2I7660.jpg"),
                  )),
                  Expanded(
                      child: GestureDetector(
                    onTap: () {
                      setState(() {
                        this.isShow = false;
                        bgmManger.player.play();
                        _controller.play();
                      });
                    },
                    child: Stack(
                      children: [
                        Center(
                          child: Image.asset(
                            "assets/images/边框.png",
                            color: Colors.white,
                          ),
                        ),
                        const Center(
                          child: Text(
                            "开启请柬",
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                                fontFamily: "NotoSerifSC",
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
      ]),
    );
  }
}

class HotelPageOne extends StatelessWidget {
  const HotelPageOne({
    super.key,
    required TextStyle textStyle,
  }) : _textStyle = textStyle;

  final TextStyle _textStyle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            color: Colors.black45, border: Border.all(color: Colors.white)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: Container()),
              const AutoSizeText(
                "宴会信息",
                style: TextStyle(
                  fontSize: 90,
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontFamily: "NotoSerifSC",
                ),
                maxLines: 1,
                overflow: TextOverflow.visible,
              ),
              const SizedBox(height: 20),
              Expanded(child: Container()),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 100,
                    child: Text(
                      "酒店名称：",
                      style: _textStyle,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "昆山隆祺建国饭店(顺帆北路地铁站店)",
                      style: _textStyle,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 100,
                    child: Text(
                      "宴会地址：",
                      style: _textStyle,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "苏州市昆山市玉山镇前进东路767号",
                      style: _textStyle,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 100,
                    child: Text(
                      "宴会时间：",
                      style: _textStyle,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "11月5日 下午5点18分",
                      style: _textStyle,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 100,
                    child: Text(
                      "交通工具：",
                      style: _textStyle,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "地铁11号线坐至顺帆北路2号口\n公交至同丰路黄浦江路站、军泽园站",
                      style: _textStyle,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              Expanded(child: Container()),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  RotatedBox(
                    quarterTurns: 2,
                    child: Image.asset(
                      "assets/images/ezgif-3-88a030c11b.gif",
                      height: 20,
                    ),
                  ),
                  const Text(
                    '点击图片仔细查看目标地点',
                    style: TextStyle(
                      color: Color(0xFFFFD3AB),
                      fontFamily: "NotoSerifSC",
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () async {
                  const url = 'https://surl.amap.com/da7Zcoz146B7';
                  if (await canLaunchUrl(Uri.parse(url))) {
                    await launchUrl(Uri.parse(url));
                  } else
                    // can't launch url, there is some error
                    throw "Could not launch $url";
                },
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 5)),
                  child: Image.asset(
                    "assets/images/mapImage1.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(child: Container()),
              Expanded(child: Container()),
              Expanded(child: Container()),
              Column(
                children: [
                  Image.asset(
                    "assets/images/ezgif-3-88a030c11b.gif",
                    height: 30,
                  ),
                  Text(
                    "上拉填写出席信息",
                    style: _textStyle.copyWith(fontSize: 20),
                  )
                ],
              ),
              const SizedBox(height: 10)
            ],
          ),
        ),
      ),
    );
  }
}

class VideoPage extends StatefulWidget {
  const VideoPage({
    super.key,
    required this.videoPage,
    required VideoPlayerController controller,
  }) : _controller = controller;

  final bool videoPage;
  final VideoPlayerController _controller;

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  bool videoPage1 = true;

  @override
  Widget build(BuildContext context) {
    return videoPage1
        ? AnimatedOpacity(
            onEnd: () {
              setState(() {
                videoPage1 = false;
              });
            },
            opacity: widget.videoPage ? 1.0 : 0,
            duration: const Duration(
              milliseconds: 800,
            ),
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.black,
              child: VideoPlayer(widget._controller),
            ),
          )
        : Container();
  }
}
