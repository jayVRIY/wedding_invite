import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:soundpool/soundpool.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';
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
  ScrollPhysics scrollPhysics = const ScrollPhysics();
  bool isShow = true;
  bool videoPage = true;
  bool isShow1 = true;
  String name = "";
  String number = "";


  AudioPlayer player = AudioPlayer();


  @override
  void initState() {
    _controller = VideoPlayerController.asset("assets/videos/inviteVideos.mp4")
      ..initialize().then((value) => () {
            setState(() async {
              _controller.play();
              await player.play(AssetSource('assets/audio/bgm.mp3'));
            });
          });
    _controller.addListener(() {
      VideoPlayerValue value = _controller.value;
      if (value.isCompleted) {
        setState(() {
          print("object");
          videoPage = false;
        });
      }
    });
    super.initState();
  }

  TextStyle _textStyle = const TextStyle(
      color: Colors.white,
      fontSize: 14,
      fontWeight: FontWeight.w700,
      fontFamily: "NotoSerifSC");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      Image.asset(
        "assets/images/AM2I7743.jpg",
        fit: BoxFit.fitHeight,
        height: double.infinity,
      ),
      PageView(scrollDirection: Axis.vertical, children: [
        HotelPageOne(textStyle: _textStyle),
        Padding(
            padding: const EdgeInsets.all(40),
            child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.black45,
                    border: Border.all(color: Colors.white)),
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 40, horizontal: 30),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const AutoSizeText(
                            "填写出席信息",
                            style: TextStyle(
                              fontSize: 90,
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                              fontFamily: "NotoSerifSC",
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
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
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "NotoSerifSC",
                                  ),
                                  keyboardType: TextInputType.text,
                                  cursorColor: Colors.white,
                                  decoration: InputDecoration(
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
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "NotoSerifSC",
                                  ),
                                  cursorColor: Colors.white,
                                  decoration: InputDecoration(
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

                                  http.Response response = await http.post(
                                    Uri.parse("/api/addguest"),
                                    headers: headers,
                                    body: jsonParams,
                                  );
                                  if (response.statusCode == 200) {
                                    // 请求成功
                                    Map<String, dynamic> responseData =
                                        jsonDecode(response.body);
                                    print(responseData.toString());
                                    // 处理响应数据
                                  } else {
                                    // 请求失败
                                    print('请求失败：${response.statusCode}');
                                  }
                                  showDialog<Null>(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        content: SingleChildScrollView(
                                            child: Text(
                                          "提交完成",
                                          style: TextStyle(
                                            fontFamily: "NotoSerifSC",
                                          ),
                                        )),
                                        actions: <Widget>[
                                          TextButton(
                                            child: Text('确定',
                                                style: TextStyle(
                                                  fontFamily: "NotoSerifSC",
                                                )),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  ).then((val) {
                                    print(val);
                                  });
                                },
                                minWidth: double.infinity,
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: Colors.white, width: 1),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(200))),
                                padding: EdgeInsets.symmetric(vertical: 18),
                                child: Text(
                                  "提交",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900,
                                    fontFamily: "NotoSerifSC",
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
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
      Offstage(
        offstage: true,
        child: Column(
          children: [
            Image.asset("assets/images/AM2I7837.jpg"),
            Image.asset("assets/images/AM2I7837.jpg"),
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
    ]));
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
          "assets/images/AM2I7745.jpg",
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
                    overflow: TextOverflow.ellipsis,
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
                    overflow: TextOverflow.ellipsis,
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
                    overflow: TextOverflow.ellipsis,
                  ),
                  Image.asset(
                    "assets/images/下花边.png",
                    color: Colors.white,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Expanded(
                      child: Container(
                    child: Image.asset("assets/images/AM2I7660.jpg"),
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
      padding: const EdgeInsets.all(40),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.black45, border: Border.all(color: Colors.white)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const AutoSizeText(
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
              const SizedBox(height: 30),
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
                      "地铁11号线坐至顺帆北路2号口 或 公交至同丰路黄浦江路站、军泽园站",
                      style: _textStyle,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 60),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  RotatedBox(
                    quarterTurns: 2,
                    child: Image.asset(
                      "assets/images/ezgif-3-88a030c11b.gif",
                      height: 30,
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
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 5)),
                child: Image.asset(
                  "assets/images/mapImage1.png",
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 30),
              Column(
                children: [
                  Image.asset(
                    "assets/images/ezgif-3-88a030c11b.gif",
                    height: 50,
                  ),
                  Text(
                    "上拉填写出席信息",
                    style: _textStyle.copyWith(fontSize: 20),
                  )
                ],
              )
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
