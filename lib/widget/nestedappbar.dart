import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../constant/colors.dart';

class NestedAppBar extends StatelessWidget with PreferredSizeWidget {
  const NestedAppBar({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      // backgroundColor: AppColors.white,
      leading: IconButton(
        onPressed: () => {Navigator.pop(context)},
        icon: Icon(Icons.arrow_back_ios_new,
            color: Theme.of(context).textTheme.bodyText1?.color),
      ),
      title: Text(
        title,
        style: TextStyle(
            fontSize: 28, color: Theme.of(context).textTheme.bodyText1?.color),
      ),
      bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Container(
            color: Theme.of(context).textTheme.bodyText1?.color,
            height: 2.0,
          )),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
