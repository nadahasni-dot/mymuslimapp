import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_muslim_app/components/snackbar_helper.dart';
import 'package:my_muslim_app/constants.dart';
import 'package:my_muslim_app/screens/main/page/pengaturan/components/pengaturan_list_item.dart';

class PengaturanPage extends StatelessWidget {
  const PengaturanPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Container(          
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(height: 20),
              Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(
                        'https://scrumapp.tamif2021.my.id/assets/img/user-no-image.jpg'),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Nada Hasni",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 18,
                            color: TEXT_COLOR_DARK,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "nadasthing@gmail.com",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: TEXT_COLOR_LIGHT),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Divider(),
              PengaturanListItem(
                onTap: () {
                  SnackBarHelper.displaySnackBar(
                      context, "Fitur ini sedang dalam pengembangan");
                },
                icon: Icon(Icons.notifications_none_rounded),
                text: "Notifikasi",
              ),
              Divider(),
              PengaturanListItem(
                onTap: () {
                  SnackBarHelper.displaySnackBar(
                      context, "Fitur ini sedang dalam pengembangan");
                },
                icon: Icon(Icons.mail_outline_rounded),
                text: "Bantuan",
              ),
              Divider(),
              PengaturanListItem(
                onTap: () {
                  SnackBarHelper.displaySnackBar(
                      context, "Fitur ini sedang dalam pengembangan");
                },
                icon: Icon(Icons.info_outline_rounded),
                text: "Tentang",
              ),
              Divider(),
              PengaturanListItem(
                onTap: () {
                  SnackBarHelper.displaySnackBar(
                      context, "Fitur ini sedang dalam pengembangan");
                },
                icon: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: SvgPicture.asset(
                    'assets/icons/globe.svg',
                    color: TEXT_COLOR_LIGHT,
                    width: 20,
                    height: 20,
                  ),
                ),
                text: "nadahasnim.github.io",
              ),              
            ],
          ),
        ),
      ),
    );
  }
}
