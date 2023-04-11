import 'dart:io';

import 'package:example/constant/api_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_library/flutter_library.dart';

import 'banner_info.dart';

class HomeState extends TbBaseState {
  var bannerInfo =
      BannerInfo(list: List.generate(1, (index) => UrlInfo(title: "")));
}

class HomeLogic extends TbBaseLogic<HomeState> {

  getData() {
    get(
      Api.idCardAnalysis,
      onSuccess: (result, taskId) {},
    );
  }

  @override
  resultData(result, int taskId) {

  }

  @override
  void tbRefreshQuest() {
    // TODO: implement tbRefreshQuest
    super.tbRefreshQuest();
    getData();
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends TbBaseView<HomeLogic, HomeState, HomePage>
    with TickerProviderStateMixin {
  TabController? tabController;
  List<Text> tabList = [];

  initTabData() {
    tabList = [
      Text("推荐"),
    ];
  }

  // final FijkPlayer player = FijkPlayer();

  @override
  void initState() {
    super.initState();
    initTabData();
    tabController = TabController(length: tabList.length, vsync: this);
    startPlay();
  }

  void startPlay() async {
    // await player.setOption(FijkOption.hostCategory, "request-screen-on", 1);
    // await player.setOption(FijkOption.hostCategory, "request-audio-focus", 1);
    // await player
    //     .setDataSource(
    //         "https://video.pearvideo.com/mp4/adshort/20210804/cont-1737636-15737879_adpkg-ad_hd.mp4",
    //         autoPlay: true)
    //     .catchError((e) {
    //   print("setDataSource error: $e");
    // });
  }

  @override
  bool get mShowExitTips => true;

  @override
  void dispose() {
    super.dispose();
    tabController?.dispose();
  }

  @override
  initViewState() {
    setViewState(HomeLogic(), HomeState());
  }

  @override
  void onResume() {
    super.onResume();
    HomeLogic mContriller = Get.find(tag: "home_${tabController?.index}");
    mContriller.mIsShowLoading = false;
    mContriller.getData();

    tabController?.addListener(() {});
  }

  List<XFile> imageUrls = [];

  @override
  Widget buildWidget(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.blue,statusBarBrightness: Brightness.dark,statusBarIconBrightness: Brightness.light),
            title: Text("dsa"),
            centerTitle: false,
            backgroundColor: Colors.white,
          ),
        body: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  // player.start();
                  // var image = await ImagePicker().pickMultiImage(maxHeight: 80);
                  // imageUrls.clear();
                  // setState(() {
                  //   imageUrls.addAll(image);
                  // });
                  setState(() {
                    tabList.addAll([
                      Text(
                          "${DateTime.parse("2018-02-03").difference(DateTime.parse("2018-02-01")).inMinutes}"),
                      Text('热点'),
                      Text('社会'),
                      Text('娱乐'),
                      Text('体育'),
                      Text('美文'),
                      Text('科技'),
                      Text('财经'),
                      Text('时尚')
                    ]);
                    tabController = TabController(
                        initialIndex: 1, length: tabList.length, vsync: this);
                    tabController?.animateTo(0);

                    // showTopSnackBar(
                    //     context,
                    //     CustomSnackBar.info(
                    //       icon: Icon(Icons.sentiment_neutral,
                    //           color: const Color(0x15000000), size: 0),
                    //       message: "no_internet".tr,
                    //       backgroundColor:
                    //           TbSystemConfig.instance.mSnackbarBackground,
                    //       textStyle: TextStyle(
                    //           color: Colors.white,
                    //           fontSize: TbSystemConfig.mSnackbarTextSize),
                    //     ));
                  });
                },
                child: Text(
                  "添加",
                  style: TextStyle(fontSize: 16.px),
                )),
            Visibility(
              child: imageUrls.isEmpty
                  ? Placeholder()
                  : Image.file(File(imageUrls[1].path)),
              visible: imageUrls.isNotEmpty,
            ),

            // FijkView(
            //   player: player,
            //   height: 300,
            //
            // ),
            Container(
              color: Color(0xfff4f5f6),
              height: 38.0,
              child: TabBar(
                controller: tabController,
                isScrollable: true,
                indicatorWeight: 2,
                indicatorSize: TabBarIndicatorSize.tab,
                labelColor: Colors.red,
                unselectedLabelColor: Color(0xff666666),
                labelStyle: TextStyle(fontSize: 16.0),
                tabs: tabList.map((item) {
                  return Tab(
                    text: item.data,
                  );
                }).toList(),
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: List.generate(
                  tabList.length,
                  (index) {
                    return Stack(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.topCenter,
                          child: MyTabBarView(
                            mLogicTag: "home_$index",
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class MyTabBarView extends StatefulWidget {
  String? mLogicTag;

  MyTabBarView({this.mLogicTag, Key? key}) : super(key: key);

  @override
  _MyTabBarViewState createState() => _MyTabBarViewState();
}

class _MyTabBarViewState
    extends TbBaseView<HomeLogic, HomeState, MyTabBarView> {
  @override
  void firstFrameComplete() {
    // TODO: implement firstFrameComplete
    super.firstFrameComplete();
    mLogic?.getData();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget buildWidget(BuildContext context) {
    return tbGetBuilder<HomeLogic>(
      tag: mLogicTag,
      builder: () {
        return tbRefreshCustomWidget(
          logic: mLogic,
          slivers: [
            SliverAppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              expandedHeight: 200.px,
              stretch: true,
              flexibleSpace: FlexibleSpaceBar(
                background: FlutterLogo(),
                stretchModes: [
                  StretchMode.zoomBackground,
                  StretchMode.blurBackground
                ],
              ),
            ),
            SliverPersistentHeader(
              delegate: MyDelegate(),
              pinned: true,
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return Text(
                  "${mState?.bannerInfo.list?[0].title}",
                  style: TextStyle(color: Colors.black87, fontSize: 20),
                );
              }, childCount: 30),
            ),
            SliverToBoxAdapter(
              child: Text(
                "${mState?.bannerInfo.list?[0].title}",
                style: TextStyle(color: Colors.black87, fontSize: 25.px),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void initViewState() {
    setViewState(HomeLogic(), HomeState(), logicTag: widget.mLogicTag);
  }
}

class MyDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      child: FittedBox(child: Text("dsada")),
      height: 50,
      color: Colors.red,
    );
  }

  @override
  double get maxExtent => 50;

  @override
  double get minExtent => 50;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
