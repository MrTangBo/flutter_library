import 'dart:io';
import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_library/flutter_library.dart';
import 'banner_info.dart';

class HomeState extends TbBaseViewState {
  var bannerInfo =
      BannerInfo(list: List.generate(1, (index) => UrlInfo(title: "")));
}

class HomeLogic extends TbBaseLogic<HomeState> {
  getData() {
    var data = {
      "articleType": "1",
      "typeId": "1",
      "pageSize": "30",
      "pageNo": "1"
    };
    var url = "/contentManagement/getBannerByType";
    questMix([QuestListInfo(url, QuestMethod.post, data: data, taskId: 3)]);
  }

  @override
  resultData(result, int taskId) {
    mState?.bannerInfo = BannerInfo.fromJson(result);
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends TbBaseWidgetState<HomeLogic, HomeState, HomePage> {
  TabController? tabController;
  List<Text> tabList = [];

  initTabData() {
    tabList = [
      Text("推荐"),
    ];
  }

  final FijkPlayer player = FijkPlayer();

  @override
  void initState() {
    super.initState();
    initTabData();
    tabController = TabController(length: tabList.length, vsync: this);
    startPlay();
  }

  void startPlay() async {
    await player.setOption(FijkOption.hostCategory, "request-screen-on", 1);
    await player.setOption(FijkOption.hostCategory, "request-audio-focus", 1);
    await player
        .setDataSource(
            "https://video.pearvideo.com/mp4/adshort/20210804/cont-1737636-15737879_adpkg-ad_hd.mp4",
            autoPlay: true)
        .catchError((e) {
      print("setDataSource error: $e");
    });
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
      child: Column(
        children: [
          ElevatedButton(
              onPressed: () async {
                // player.start();
                // var image = await ImagePicker().pickMultiImage(maxHeight: 80);
                // imageUrls.clear();
                // setState(() {
                //   imageUrls.addAll(image);
                // });
                setState(() {
                  tabList = [
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
                  ];
                  tabController = TabController(
                      initialIndex: 1, length: tabList.length, vsync: this);
                  tabController?.animateTo(0);
                });
              },
              child: Text("add")),
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
            color: new Color(0xfff4f5f6),
            height: 38.0,
            child: TabBar(
              controller: tabController,
              isScrollable: true,
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
    extends TbBaseWidgetState<HomeLogic, HomeState, MyTabBarView> {
  @override
  void initState() {
    super.initState();
    mLogic?.getData();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget buildWidget(BuildContext context) {
    return GetBuilder<HomeLogic>(
      tag: mLogicTag,
      builder: (logic) {
        return CustomScrollView(
          slivers: [
            SliverAppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              expandedHeight: 200,
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
                  "${logic.mState?.bannerInfo.list?[0].title}",
                  style: TextStyle(color: Colors.black87, fontSize: 20),
                );
              }, childCount: 30),
            ),
            SliverToBoxAdapter(
              child: Text(
                "${logic.mState?.bannerInfo.list?[0].title}",
                style: TextStyle(color: Colors.black87, fontSize: 50),
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
