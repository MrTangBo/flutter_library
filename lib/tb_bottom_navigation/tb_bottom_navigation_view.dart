part of flutter_library;

class TbBottomNavigationWidget extends StatefulWidget {
  final Widget Function(BuildContext?, int)? builderPage;

  final ScrollPhysics? physics; //PageView是可手动滑动设置
  final bool animateToPage; //PageView切换是否开启动画效果
  final Color? bottomNavigationBarBgColor; //PageView切换是否又动画效果
  List<Widget>? pages;
  final Map<String, String>? iconPath; //这里方便在一个地方配置图标 (key代表未选中，value代表选中图标的路径)
  final List<String>? titles;
  final double? selectIconSize;
  final double? unSelectIconSize;
  final double? bottomNavigationBarHeight;
  final BottomNavigationBarThemeData? bottomNavigationBarTheme;
  final Duration? pageDuration;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final Decoration? decoration;
  final bool wantKeepAlive;

  TbBottomNavigationWidget(
      {Key? key,
      this.builderPage,
      this.physics,
      this.animateToPage = true,
      this.bottomNavigationBarBgColor,
      this.pages,
      this.titles,
      this.selectIconSize,
      this.unSelectIconSize,
      this.bottomNavigationBarTheme,
      this.iconPath,
      this.bottomNavigationBarHeight,
      this.pageDuration,
      this.margin,
      this.padding,
      this.decoration,
      this.wantKeepAlive = true})
      : super(key: key);

  @override
  _TbBottomNavigationPageState createState() => _TbBottomNavigationPageState();
}

class _TbBottomNavigationPageState extends TbBaseView<TbBottomNavigationLogic,
    TbBottomNavigationState, TbBottomNavigationWidget> {
  @override
  Widget build(BuildContext context) => buildWidget(context);

  String tag ="0";

  @override
  void initViewState() {
    super.initViewState();
    tag =DateTime.now().millisecondsSinceEpoch.toString();
    setViewState(TbBottomNavigationLogic(), TbBottomNavigationState(),
        logicTag: tag);
  }

  @override
  bool get wantKeepAlive => widget.wantKeepAlive;

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.pages!.length; i++) {
      mState!.mBottomTabList.add(BottomNavigationBarItem(
          icon: Visibility(
            visible: widget.iconPath != null,
            child: Image.asset(
              widget.iconPath == null ? "" : widget.iconPath!.keys.elementAt(i),
              width: widget.unSelectIconSize ?? 20.px,
              height: widget.unSelectIconSize ?? 20.px,
            ),
          ),
          activeIcon: Visibility(
            visible: widget.iconPath != null,
            child: Image.asset(
              widget.iconPath == null
                  ? ""
                  : widget.iconPath!.values.elementAt(i),
              width: widget.selectIconSize ?? 20.px,
              height: widget.selectIconSize ?? 20.px,
            ),
          ),
          label: widget.titles == null ? "" : widget.titles![i],
          tooltip: ""));
    }
  }

  @override
  Widget buildWidget(BuildContext context) {
    return GetBuilder<TbBottomNavigationLogic>(
      id: "TbBottomNavigationWidget",
      tag: tag,
      builder: (logic) {
        return Column(
          children: [
            Expanded(
                child: PageView.builder(
              physics: widget.physics,
              itemBuilder: (_, index) {
                return widget.pages![index];
              },
              onPageChanged: (index) {
                mState!.mCurrentIndex = index;
                mLogic?.update(["TbBottomNavigationWidget"]);
              },
              controller: mState!.mController,
              itemCount: widget.pages!.length,
            )),
            Theme(
              data: TbAppTheme.mThemeData.copyWith(
                  bottomNavigationBarTheme: widget.bottomNavigationBarTheme),
              child: Container(
                margin: widget.margin,
                padding: widget.padding,
                decoration: widget.decoration,
                height: widget.bottomNavigationBarHeight,
                child: BottomNavigationBar(
                    backgroundColor: widget.bottomNavigationBarBgColor ??
                        Theme.of(context).primaryColor,
                    elevation: 0,
                    items: mState!.mBottomTabList,
                    currentIndex: mState!.mCurrentIndex,
                    onTap: (index) {
                      mState!.mCurrentIndex = index;
                      mLogic?.update(["TbBottomNavigationWidget"]);
                      if (widget.animateToPage) {
                        mState!.mController.animateToPage(index,
                            duration: widget.pageDuration ??
                                Duration(milliseconds: 300),
                            curve: Curves.linear);
                      } else {
                        mState!.mController.jumpToPage(index);
                      }
                    }),
              ),
            )
          ],
        );
      },
    );
  }
}
