part of flutter_library;

/*TabBar+TabBarView的使用*/
class TbTabLayoutWidget extends StatefulWidget {
  final Function(TabController controller, int index)? onSelectListener;
  final Function(TbTabLayoutWidgetLogic? logic)? logic;
  final Widget Function(BuildContext?, int)? builder;

  final bool onlyTabBar; //是否只需要Tab 默认为false

  final double? tabBarHeight;
  final Alignment tabBarAlignment;

  final int? defaultIndex; //默认选中位置

  final Color? tabBarBgColor; //tabBar背景色
  final Color? labelColor;
  final TextStyle? labelStyle;
  final TextStyle? unselectedLabelStyle;
  final Color? unselectedLabelColor;
  final double? indicatorWeight;
  final bool isScrollable;
  final ScrollPhysics? physicsView; //TabBarView是否可手动滑动设置
  final EdgeInsetsGeometry? labelPadding;
  final EdgeInsetsGeometry? indicatorPadding;
  final Decoration? indicator;
  final Color? indicatorColor;

  final List<Text>? tabs;

  final bool? indicatorFullTab; //指示器是否充满Tab 默认和文字对齐

  final bool wantKeepAlive;

  TbTabLayoutWidget(
      {Key? key,
      this.tabs,
      this.builder,
      this.onSelectListener,
      this.onlyTabBar = false,
      this.tabBarHeight,
      this.defaultIndex,
      this.tabBarBgColor,
      this.labelColor,
      this.labelStyle,
      this.unselectedLabelColor,
      this.unselectedLabelStyle,
      this.labelPadding,
      this.indicatorWeight,
      this.isScrollable = true,
      this.physicsView,
      this.indicator,
      this.indicatorColor,
      this.indicatorPadding,
      this.tabBarAlignment = Alignment.center,
      this.indicatorFullTab = false,
      this.wantKeepAlive = true, this.logic})
      : super(key: key);

  @override
  _TbTabLayoutWidgetPageState createState() => _TbTabLayoutWidgetPageState();
}

class _TbTabLayoutWidgetPageState extends TbBaseView<TbTabLayoutWidgetLogic,
    TbTabLayoutWidgetState, TbTabLayoutWidget> with TickerProviderStateMixin {
  TabController? _tabController;

  int _currentIndex = 0;

  TabBarIndicatorSize _tabBarIndicatorSize = TabBarIndicatorSize.label;

  @override
  bool get wantKeepAlive => widget.wantKeepAlive;

  String tag ="0";

  @override
  void initState() {
    super.initState();
    if (widget.tabs != null) {
      mState!.tabList.addAll(widget.tabs!);
    }
    _tabController = TabController(length: mState!.tabList.length, vsync: this);
    mLogic!.addListenerId("tabLayout", () {
      setState(() {
        _tabController = TabController(
            initialIndex: 1, length: mState!.tabList.length, vsync: this)
          ..addListener(() {
            if (_tabController!.index == _tabController!.animation!.value) {
              _currentIndex = _tabController!.index;
              widget.onSelectListener!(_tabController!, _tabController!.index);
            }
          });
        _tabController?.animateTo(widget.defaultIndex ?? _currentIndex);
      });
    });
    if (widget.indicatorFullTab != null && widget.indicatorFullTab!) {
      _tabBarIndicatorSize = TabBarIndicatorSize.tab;
    }
  }

  @override
  void initViewState() {
    tag =DateTime.now().millisecondsSinceEpoch.toString();
    setViewState(TbTabLayoutWidgetLogic(), TbTabLayoutWidgetState(), logicTag:tag);
    if(widget.logic!=null){
      widget.logic!(mLogic);
    }
  }

  @override
  Widget build(BuildContext context) => buildWidget(context);

  @override
  Widget buildWidget(BuildContext context) {
    return GetBuilder<TbTabLayoutWidgetLogic>(
      id: "tabLayout",
      tag: tag,
      builder: (logic) {
        return widget.onlyTabBar
            ? UnconstrainedBox(
                constrainedAxis: Axis.horizontal,
                child: Container(
                  alignment: widget.tabBarAlignment,
                  color: widget.tabBarBgColor ?? Colors.white,
                  height: widget.tabBarHeight ?? 58.px,
                  child: TabBar(
                    indicator: widget.indicator,
                    indicatorColor: widget.indicatorColor,
                    indicatorPadding:
                        widget.indicatorPadding ?? EdgeInsets.zero,
                    controller: _tabController,
                    labelPadding: widget.labelPadding,
                    isScrollable: widget.isScrollable,
                    indicatorWeight: widget.indicatorWeight ?? 2,
                    indicatorSize: _tabBarIndicatorSize,
                    labelColor: widget.labelColor ?? Colors.red,
                    unselectedLabelColor:
                        widget.unselectedLabelColor ?? Color(0xff333333),
                    labelStyle:
                        widget.labelStyle ?? TextStyle(fontSize: 16.0.px),
                    unselectedLabelStyle: widget.unselectedLabelStyle ??
                        TextStyle(fontSize: 16.0.px),
                    tabs: mState!.tabList.map((item) {
                      return Tab(
                        text: item.data,
                      );
                    }).toList(),
                  ),
                ),
              )
            : Column(
                children: [
                  Container(
                    alignment: widget.tabBarAlignment,
                    color: widget.tabBarBgColor ?? Colors.white,
                    height: widget.tabBarHeight ?? 58.px,
                    child: TabBar(
                      controller: _tabController,
                      indicator: widget.indicator,
                      indicatorPadding:
                          widget.indicatorPadding ?? EdgeInsets.zero,
                      indicatorColor: widget.indicatorColor,
                      isScrollable: widget.isScrollable,
                      labelPadding: widget.labelPadding,
                      indicatorWeight: widget.indicatorWeight ?? 2,
                      indicatorSize: _tabBarIndicatorSize,
                      labelColor: widget.labelColor ?? Colors.red,
                      unselectedLabelColor:
                          widget.unselectedLabelColor ?? Color(0xff333333),
                      labelStyle:
                          widget.labelStyle ?? TextStyle(fontSize: 16.0.px),
                      unselectedLabelStyle: widget.unselectedLabelStyle ??
                          TextStyle(fontSize: 16.0.px),
                      tabs: mState!.tabList.map((item) {
                        return Tab(
                          text: item.data,
                        );
                      }).toList(),
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      physics: widget.physicsView,
                      children: List.generate(
                        mState!.tabList.length,
                        (index) {
                          return widget.builder!(context, index);
                        },
                      ),
                    ),
                  )
                ],
              );
      },
    );
  }
}
