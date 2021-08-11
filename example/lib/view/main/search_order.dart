import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_library/flutter_library.dart';


class SearchOrder extends StatefulWidget {
  const SearchOrder({Key? key}) : super(key: key);

  @override
  _SearchOrderState createState() => _SearchOrderState();
}

class _SearchOrderState
    extends TbBaseWidgetState<TbBaseLogic, TbBaseViewState, SearchOrder> {
  @override
  Widget buildWidget(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
      child: Text(
      "search",
      style: TextStyle(color: Colors.red),
      ),
    ),
    );
  }

  @override
  void initViewState() {}
}
