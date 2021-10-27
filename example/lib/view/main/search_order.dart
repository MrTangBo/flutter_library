import 'package:example/view/main/square_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_library/flutter_library.dart';

import 'home_page.dart';

class SearchOrder extends StatefulWidget {
  const SearchOrder({Key? key}) : super(key: key);

  @override
  _SearchOrderState createState() => _SearchOrderState();
}

class _SearchOrderState
    extends TbBaseWidgetState<TbBaseLogic, TbBaseViewState, SearchOrder>
    with SingleTickerProviderStateMixin {
  var num = 1.0;

  AnimationController? animationController;

  @override
  void initState() {
    animationController =
        AnimationController(duration: Duration(seconds: 1), vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Container(
      color: Colors.white,
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              title: const Text('嵌套ListView'),
              pinned: true, // 固定在顶部
              forceElevated: innerBoxIsScrolled,
            ),
            //构建一个 sliverList
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return Text(
                  "dsadadad",
                  style: TextStyle(color: Colors.black87, fontSize: 20),
                );
              }, childCount: 30),
            ),
            SliverPersistentHeader(
              delegate: MyDelegate(),
              pinned: true,
            ),

            SliverToBoxAdapter(
              child: ElevatedButton(
                  onPressed: () {
                    SharedPreferencesUtils.savePreference<String>( "test", "存了一个值");
                    Get.to(SquarePage());
                  },

                  child: Text("guan")),
            )
          ];
        },
        body: ListView.builder(
          padding: const EdgeInsets.all(8),
          physics: const ClampingScrollPhysics(), //重要
          itemCount: 30,
          itemBuilder: (BuildContext context, int index) {
            return SizedBox(
              height: 50,
              child: Center(child: Text('Item $index',style: TextStyle(color: Colors.deepPurple),)),
            );
          },
        ),
      ),
    );
  }

  @override
  void initViewState() {}
}
