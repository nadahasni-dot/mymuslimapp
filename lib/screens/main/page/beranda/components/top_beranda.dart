import 'package:flutter/material.dart';
import 'package:my_muslim_app/components/snackbar_helper.dart';

class TopBeranda extends StatelessWidget {
  const TopBeranda({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Assalamu'alaikum",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w300),
              ),
              Text(
                "Nada Hasni",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ],
          ),
        ),
        Spacer(),
        IconButton(
          iconSize: 30,
          color: Colors.white,
          icon: Icon(Icons.search_rounded),
          onPressed: () {
            SnackBarHelper.displaySnackBar(context, "Fitur ini sedang dalam pengembangan");
          },
        ),
        SizedBox(
          width: 8,
        ),
        CircleAvatar(
          radius: 20,
          backgroundImage: NetworkImage(
              'https://scrumapp.tamif2021.my.id/assets/img/user-no-image.jpg'),
        ),
      ],
    );
  }
}
