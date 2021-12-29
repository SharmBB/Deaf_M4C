import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String bacKText;
  final String username;
  final AppBar? appBar;
  final List<Widget>? widgets;

  /// you can add more fields that meet your needs

  const BaseAppBar(
      {Key? key,
      required this.bacKText,
      required this.username,
      this.appBar,
      this.widgets})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return AppBar(
      title: Text(
              bacKText,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
              ),
            ),
            centerTitle: false,
      automaticallyImplyLeading: false,
      leadingWidth: 30,
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: Row(
        children: [
          Expanded(
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          // Expanded(
          //   child: Text(
          //     bacKText,
          //     style: TextStyle(
          //       color: Colors.black,
          //       fontSize: 16.0,
          //     ),
          //   ),
          // ),
        ],
      ),

      actions: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                username,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(right: 30.0, top: 0.0),
              child: GestureDetector(
                onTap: () {},
                child: new SvgPicture.asset(
                  'assets/svg/Group 86.svg',
                  width: 40.0,
                  height: 40.0,
                  allowDrawingOutsideViewBox: true,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(appBar!.preferredSize.height);
}
