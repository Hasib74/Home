import 'dart:async';

import 'package:campus_guide/src/Global/PostDisplay.dart';
import 'package:campus_guide/src/Guest/NavigationDrawer.dart';
import 'package:campus_guide/src/Student/Home.dart';
import 'package:campus_guide/src/Teacher/Home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

class GuestHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _width_animation;
  Animation<double> _height_animation;

  double collapsing_height_factor = 0.4;
  double expendated_height_factor = 1;

  VideoPlayerController _controller;
  VideoPlayerController _controller2;

  RenderObject _prevRenderObject;
  double _offsetToRevealBottom = double.infinity;
  double _offsetToRevealTop = double.negativeInfinity;

  bool isVideoPlay = false;
  bool isCardShowAble = false;

  bool isScroll = false;

  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();

    getlogInInfo().then((data) {
      print("Data number is ${data}");

      setState(() {
        isLoading = true;

        print("Loading ............ ");
      });

      if (data != null) {
           Navigator.of(context).pushReplacement(new MaterialPageRoute(
                builder: (BuildContext context) => Teacher_Home(number: data)));
      } else {
        return;
      }
    });

    getLogInInfo_for_student().then((data) {
      print("Student Data ${data}");

      setState(() {
        isLoading = true;

        print("Loading ............ ");
      });

      if (data != null) {
        Navigator.of(context).pushReplacement(new MaterialPageRoute(
            builder: (BuildContext context) => Student_Home(number: data)));
      } else {
        return;
      }
    });

    _animationController =
        AnimationController(duration: Duration(milliseconds: 500), vsync: this);

    _width_animation =
        Tween<double>(begin: 0.6, end: 1).animate(_animationController);
    _height_animation =
        Tween<double>(begin: 0.2, end: 1).animate(_animationController);

    _controller = VideoPlayerController.network(
      'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
    )..initialize().then((_) {
        setState(() {});
      });

    _controller2 = VideoPlayerController.network(
      'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
    )..initialize().then((_) {
        setState(() {});
      });

    _controller.setLooping(true);

    _controller.addListener(checkVideo);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _controller.dispose();

    _animationController.dispose();
  }

  Future<String> getlogInInfo() async {
    SharedPreferences sp = await SharedPreferences.getInstance();

    return sp.getString("log_in_info");
  }

//log_in_info_as_student

  Future<String> getLogInInfo_for_student() async {
    SharedPreferences sp = await SharedPreferences.getInstance();

    return sp.getString("log_in_info_as_student");
  }

  final List image_video_list = new List();

  List home_content_title = [
    "DIU hands over Insurance Risk Coverage Claim to 2 Students and 2 Guardians Daffodil International University authority handed over 4 cheques of Prime Islami Life Insurance Ltd. and Pragati Life Insurance Ltd. under Students’ life insurance risk coverage and Guardian’s life insurance coverage yesterday on 25 September 2019.Md. Naiem Uddin, student of Software Engineering Department received the cheque due to sudden death of his mother (Guardian) and Najiat Shahaba Shiromony, student of English Department received the cheque due to sudden death of her father (Guardian). On the other hand Mr. Md. Abdul Wahid (Father) received the cheque due to sudden death of his son Md. Nazimuddin, a student of Pharmacy Department and Mr. Md. Abdur Rahim (Father) received the cheque due to accidental death of his son Md. Shahadat Hossain Sany, a student of Computer Science & Engineering (CSE) Department of the university .It may be mentioned here that Daffodil International University has brought all of its students and guardians under insurance risk coverage of Prime Islami Life Insurance Ltd. and Pragati Life Insurance Ltd.",
    "DIU Indo-Bangla T20 Cricket Tournament - 2019 Kicks off today at the cricket ground of Daffodil International University Permanent Campus, Ashulia, Savar, Dhaka.Daffodil International University organized this tournament for the 2nd time at the permanent campus play ground, Ashulia, Savar, Dhaka. PC: Emdadul Hoq Milon",
    "DIU Indo-Bangla T20 Cricket Tournament - 2019 Kicks off today at the cricket ground of Daffodil International University Permanent Campus, Ashulia, Savar, Dhaka.Daffodil International University organized this tournament for the 2nd time at the permanent campus play ground, Ashulia, Savar, Dhaka. PC: Emdadul Hoq Milon",
    "DIU Indo-Bangla T20 Cricket Tournament - 2019 Kicks off today at the cricket ground of Daffodil International University Permanent Campus, Ashulia, Savar, Dhaka.Daffodil International University organized this tournament for the 2nd time at the permanent campus play ground, Ashulia, Savar, Dhaka. PC: Emdadul Hoq Milon",
    "DIU Indo-Bangla T20 Cricket Tournament - 2019 Kicks off today at the cricket ground of Daffodil International University Permanent Campus, Ashulia, Savar, Dhaka.Daffodil International University organized this tournament for the 2nd time at the permanent campus play ground, Ashulia, Savar, Dhaka. PC: Emdadul Hoq Milon",
    "DIU Indo-Bangla T20 Cricket Tournament - 2019 Kicks off today at the cricket ground of Daffodil International University Permanent Campus, Ashulia, Savar, Dhaka.Daffodil International University organized this tournament for the 2nd time at the permanent campus play ground, Ashulia, Savar, Dhaka. PC: Emdadul Hoq Milon",
  ];

  List home_content_image_or_video = [
    "https://scontent.fdac14-1.fna.fbcdn.net/v/t1.0-9/71146356_10157044371582203_7170527701164359680_o.jpg?_nc_cat=101&_nc_oc=AQmqaJysMVKwOOaL1iaDWWYh_uGzjwxYrl_5cUaJ72MiPTmjXfRc6e3rZzpRV_IMYpo&_nc_ht=scontent.fdac14-1.fna&oh=cc3aea846b4af17f003483ee7b62001d&oe=5E37AAD1",
    "https://scontent.fdac14-1.fna.fbcdn.net/v/t1.0-9/71146356_10157044371582203_7170527701164359680_o.jpg?_nc_cat=101&_nc_oc=AQmqaJysMVKwOOaL1iaDWWYh_uGzjwxYrl_5cUaJ72MiPTmjXfRc6e3rZzpRV_IMYpo&_nc_ht=scontent.fdac14-1.fna&oh=cc3aea846b4af17f003483ee7b62001d&oe=5E37AAD1",
    "https://scontent.fdac14-1.fna.fbcdn.net/v/t1.0-9/71669838_10157044068207203_1876150927321202688_n.jpg?_nc_cat=102&_nc_oc=AQnIxVrfAiuDmF5-q3T1FLJVuxEFIhczXm9AUPZM6kcdEXulTPZKQiJE_nS5xSelhJY&_nc_ht=scontent.fdac14-1.fna&oh=73910c4a364cd9d6b71fed503dc2e8da&oe=5DF62E27",
    "https://scontent.fdac14-1.fna.fbcdn.net/v/t1.0-9/71669838_10157044068207203_1876150927321202688_n.jpg?_nc_cat=102&_nc_oc=AQnIxVrfAiuDmF5-q3T1FLJVuxEFIhczXm9AUPZM6kcdEXulTPZKQiJE_nS5xSelhJY&_nc_ht=scontent.fdac14-1.fna&oh=73910c4a364cd9d6b71fed503dc2e8da&oe=5DF62E27",
    "https://scontent.fdac14-1.fna.fbcdn.net/v/t1.0-9/71669838_10157044068207203_1876150927321202688_n.jpg?_nc_cat=102&_nc_oc=AQnIxVrfAiuDmF5-q3T1FLJVuxEFIhczXm9AUPZM6kcdEXulTPZKQiJE_nS5xSelhJY&_nc_ht=scontent.fdac14-1.fna&oh=73910c4a364cd9d6b71fed503dc2e8da&oe=5DF62E27",
    "https://scontent.fdac14-1.fna.fbcdn.net/v/t1.0-9/71669838_10157044068207203_1876150927321202688_n.jpg?_nc_cat=102&_nc_oc=AQnIxVrfAiuDmF5-q3T1FLJVuxEFIhczXm9AUPZM6kcdEXulTPZKQiJE_nS5xSelhJY&_nc_ht=scontent.fdac14-1.fna&oh=73910c4a364cd9d6b71fed503dc2e8da&oe=5DF62E27",
  ];

  List home_content_image_ = [
    "https://daffodilvarsity.edu.bd/photos/slider/transport.png",
    "https://media.licdn.com/dms/image/C511BAQHTFabjw7TiVw/company-background_10000/0?e=2159024400&v=beta&t=mIjtvN_NQGpHL-VyTACD6MHspswzHXtEW1jFbvooFIc",
    "http://photo.daffodilvarsity.edu.bd/albums/userpics/10008/normal_DSC_0611.JPG"
  ];

  List home_content_image_2 = [
    "https://daffodilvarsity.edu.bd/photos/international/dsf.jpg",
    "https://www.google.com/url?sa=i&rct=j&q=&esrc=s&source=images&cd=&ved=2ahUKEwjNxOWoi_nkAhUCcCsKHeCuDWYQjRx6BAgBEAQ&url=https%3A%2F%2Fbd.usembassy.gov%2Fambassador-bernicat-daffodil-international-university-foundation-day-ceremony%2F&psig=AOvVaw3sjDjDDlPbcs7MNFRXfqAa&ust=1569951518951559",
  ];

  List home_content_image_6 = [
    "http://photo.daffodilvarsity.edu.bd/albums/userpics/10004/normal_Jr_-Science-Olympiad_1.jpg",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRop_PTHkgcQwcElX5fZN6jVfcFJovjwxV3twHyap1-pbJfn22c",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRBGfgjED4HSUTvk0F3jOUBjj4O7l8Mq_YhR7WIljc3n5p1Idka9A"
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTSrXWJ5A_Dcp9chDiAVn-XSAQxeosfKHw8LxsMh0KzuGxABAiS"
  ];

  List home_content_image_1 = [
    //"http://faculty.daffodilvarsity.edu.bd/images/teacher/a9db387ba2a795b09f880a0f1392d8f3.JPG",
    "http://faculty.daffodilvarsity.edu.bd/images/teacher/a9db387ba2a795b09f880a0f1392d8f3",
  ];

  List profile_image_list = [
    "http://faculty.daffodilvarsity.edu.bd/images/teacher/a9db387ba2a795b09f880a0f1392d8f3.JPG",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSZ5mXOda16GJTRN_lEaDMBGk4aV6WT5qtdFMb50Xb0BFcHTFft",
    "http://faculty.daffodilvarsity.edu.bd/images/teacher/c05d1e45e5b13dfda27f31641ead6085.JPG",
    "http://faculty.daffodilvarsity.edu.bd/images/teacher/c05d1e45e5b13dfda27f31641ead6085.JPG",
    "http://faculty.daffodilvarsity.edu.bd/images/teacher/c05d1e45e5b13dfda27f31641ead6085.JPG",
    "http://faculty.daffodilvarsity.edu.bd/images/teacher/c05d1e45e5b13dfda27f31641ead6085.JPG",
  ];

  List pro_type = [
    "Admin",
    "Student",
    "Teacher",
    "Admin",
    "CR",
    "Deen",
  ];

  GlobalKey<ScaffoldState> _key = new GlobalKey();

  GlobalKey _homeKey = GlobalKey();

  bool isPlaying = false;

  var possition;

  @override
  Widget build(BuildContext context) {
    image_video_list.add(home_content_image_or_video);
    image_video_list.add(home_content_image_or_video);
    image_video_list.add(home_content_image_1);
    image_video_list.add(home_content_image_2);
    image_video_list.add(home_content_image_);
    image_video_list.add(home_content_image_or_video);
    image_video_list.add(home_content_image_6);

    return isLoading
        ? MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
                key: _key,
                appBar: AppBar(
                  leading: IconButton(
                      onPressed: () {
                        if (_key.currentState.isDrawerOpen) {
                          _key.currentState.openEndDrawer();
                        } else {
                          _key.currentState.openDrawer();
                        }
                      },
                      icon: Icon(
                        Icons.menu,
                        color: Colors.white,
                      )),
                  title: new Text("Campus Guide"),
                ),
                drawer: Drawer(child: NavigationDrawer()),
                body: AnimatedBuilder(
                  animation: _animationController,
                  builder: (BuildContext context, Widget child) {
                    return Stack(
                      children: <Widget>[
                        NotificationListener<ScrollNotification>(
                          child: _list_home(),
                          onNotification: (ScrollNotification scroll) {
                            var currentContext = _homeKey.currentContext;
                            if (currentContext == null) return false;

                            var renderObject =
                                currentContext.findRenderObject();

                            print(
                                "Reeeeeeeeeeeeeeeeeeeeeeeeee  ${renderObject}");

                            if (renderObject != _prevRenderObject) {
                              RenderAbstractViewport viewport =
                                  RenderAbstractViewport.of(renderObject);
                              _offsetToRevealBottom = viewport
                                  .getOffsetToReveal(renderObject, 1.0)
                                  .offset;
                              _offsetToRevealTop = viewport
                                  .getOffsetToReveal(renderObject, 0.0)
                                  .offset;
                            }

                            final offset = scroll.metrics.pixels;

                            if (_offsetToRevealBottom < offset &&
                                offset < _offsetToRevealTop) {
                              print(
                                  "Showing......................................................");

                              setState(() {
                                isCardShowAble = false;
                              });
                            } else {
                              print(
                                  " No     Showing......................................................");

                              setState(() {
                                isCardShowAble = true;
                              });
                            }

                            return false;

                            //////////////
                          },
                        ),
                        Padding(
                          padding: isScroll
                              ? const EdgeInsets.only(right: 0.0)
                              : const EdgeInsets.only(right: 10.0),
                          child: isVideoPlay == true && isCardShowAble == true
                              ? Align(
                                  alignment: Alignment.bottomRight,
                                  child: _overlly_container(),
                                )
                              : Container(),
                        ),
                      ],
                    );
                  },
                )),
          )
        : CircularProgressIndicator();
  }

  Widget _list_home() {
    return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: home_content_title.length,
        itemBuilder: (BuildContext context, int index) {
          print(home_content_title.length);

          print(image_video_list[index][0].toString().contains("jpg"));

          return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  //    print("Clickeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeed");
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (context) => PostDisply(
                            title: home_content_title[index],
                            image_list: image_video_list[index],
                          )));
                },
                child: Card(
                  elevation: 8,
                  //borderOnForeground: false,

                  child: Column(
                    children: <Widget>[
                      _header(index),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          home_content_title[index].toString().length > 200
                              ? home_content_title[index]
                                      .toString()
                                      .substring(0, 200) +
                                  "   ..."
                              : home_content_title[index].toString(),
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              letterSpacing: 0.5),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      design_for_image_or_video(image_video_list[index], index)
                    ],
                  ),
                ),
              ));
        });
  }

  Widget design_for_image_or_video(List image_list, int index) {
    if (image_list.length == 1) {
      return image_list[0].toString().contains(".png") ||
              image_list[0].toString().contains(".JPG")
          ? Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: new NetworkImage(image_list[0]),
                      fit: BoxFit.cover)),
            )
          : _play_video();
    } else if (image_list.length == 2) {
      return Container(
        height: 200,
        width: double.infinity,
        child: Row(
          children: <Widget>[
            Expanded(
                flex: 1,
                child: Image.network(
                  image_list[0],
                  fit: BoxFit.cover,
                  height: double.infinity,
                )),
            Expanded(
                flex: 1,
                child: Image.network(
                  image_list[1],
                  fit: BoxFit.cover,
                  height: double.infinity,
                )),
          ],
        ),
      );
    } else {
      return Container(
        height: 200,
        width: double.infinity,
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Expanded(
                    flex: 1,
                    child: Image.network(image_list[0],
                        height: double.infinity,
                        width: double.infinity,
                        fit: BoxFit.cover)),
                Expanded(
                  flex: 1,
                  child: new Row(
                    children: <Widget>[
                      Expanded(
                          child: Image.network(image_list[1],
                              height: double.infinity,
                              width: double.infinity,
                              fit: BoxFit.cover)),
                      Expanded(
                        child: Stack(
                          children: <Widget>[
                            Image.network(
                              image_list[2],
                              height: double.infinity,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                            Align(
                                alignment: Alignment.center,
                                child: image_list.length != 3
                                    ? Text(
                                        "${image_list.length - 3}  +",
                                        style: TextStyle(
                                            fontSize: 35, color: Colors.white),
                                      )
                                    : new Container())
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }
  }

  Widget _header(int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    profile_image_list[index],
                  ),
                )),
          ),
          SizedBox(
            width: 13,
          ),
          Container(
            width: 80,
            height: 20,
            decoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 2.0,
                  ),
                ]),
            child: Text(
              "${pro_type[index].toString()}",
              style: TextStyle(color: Colors.white),
            ),
            alignment: Alignment.center,
          ),
        ],
      ),
    );
  }

  Widget _overlly_container() {
    return GestureDetector(
      onVerticalDragUpdate: (v) {
        print(v.primaryDelta);

        double fragction_drag =
            v.primaryDelta / MediaQuery.of(context).size.height;

        _animationController.value =
            _animationController.value - 5 * fragction_drag;
      },
      onVerticalDragEnd: vertical_darag_end,
      child: FractionallySizedBox(
        heightFactor: _height_animation.value,
        widthFactor: _width_animation.value,
        child: Container(
          /*width: 100,
          height: 100,*/

          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 10.0,
            ),
          ]),
          child: Stack(
            /*      key: _homeKey,*/

            children: <Widget>[
              VideoPlayer(_controller),
              Align(
                alignment: Alignment(0, 0),
                child: isPlaying
                    ? InkWell(
                        onTap: _play_button_controll,
                        child: new Icon(
                          Icons.pause,
                          size: 70,
                        ))
                    : InkWell(
                        onTap: _play_button_controll,
                        child: new Icon(
                          Icons.play_circle_filled,
                          size: 70,
                        )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  vertical_darag_end(DragEndDetails v) {
    if (_animationController.value > 0.5) {
      _animationController.forward();

      setState(() {
        isScroll = true;
      });
    } else {
      _animationController.reverse();

      setState(() {
        isScroll = false;
      });
    }
  }

  Widget _play_video() {
    return Container(
      height: 230,
      child: Stack(
        key: _homeKey,
        children: <Widget>[
          VideoPlayer(_controller),
          Align(
            alignment: Alignment(0, 0),
            child: isPlaying
                ? InkWell(
                    onTap: _play_button_controll,
                    child: new Icon(
                      Icons.pause,
                      size: 70,
                    ))
                : InkWell(
                    onTap: _play_button_controll,
                    child: new Icon(
                      Icons.play_circle_filled,
                      size: 70,
                    )),
          ),
        ],
      ),
    );
  }

  Widget _play_video2() {
    return Container(
      height: 230,
      child: Stack(
        // key: _homeKey,

        children: <Widget>[
          VideoPlayer(_controller2),
          Align(
            alignment: Alignment(0, 0),
            child: isPlaying
                ? InkWell(
                    onTap: _play_button_controll,
                    child: new Icon(
                      Icons.pause,
                      size: 70,
                    ))
                : InkWell(
                    onTap: _play_button_controll,
                    child: new Icon(
                      Icons.play_circle_filled,
                      size: 70,
                    )),
          ),
        ],
      ),
    );
  }

  _play_button_controll() {
    setState(() {
      isVideoPlay = true;
    });

    if (isPlaying) {
      _controller.pause();
      setState(() {
        isPlaying = false;
      });
    } else {
      _controller.play();
      setState(() {
        isPlaying = true;
      });
    }
  }

  void checkVideo() {
    // Implement your calls inside these conditions' bodies :
    if (_controller.value.position ==
        Duration(seconds: 0, minutes: 0, hours: 0)) {
      print('video Started');
    }

    if (_controller.value.position == _controller.value.duration) {
      print("End Video ");
    }
  }
}
