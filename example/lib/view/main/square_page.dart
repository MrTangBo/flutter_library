import 'package:flutter/material.dart';
import 'package:flutter_library/flutter_library.dart';

class SquarePage extends StatefulWidget {
  const SquarePage({Key? key}) : super(key: key);

  @override
  _SquarePageState createState() => _SquarePageState();
}

class _SquarePageState extends State<SquarePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: ElevatedButton(
          child: Text("SquarePage"),
          onPressed: () async {
          var s=  await  SharedPreferencesUtils.getPreference<String>(
                "test", "dsadad");
            showTopSnackBar(context,CustomSnackBar.info(
              icon: Icon(Icons.sentiment_neutral,
                  color: const Color(0x15000000), size: 0),
              message: s,
              backgroundColor:
              TbSystemConfig.instance.mSnackbarBackground,
              textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: TbSystemConfig.mSnackbarTextSize),
            ));
          },
        ),
      ),
    );
  }
}
