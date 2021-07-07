import 'package:flutter/material.dart';

import '../../../../../constants.dart';

class ArticleItem extends StatelessWidget {
  final Function onTap;
  const ArticleItem({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap as void Function()?,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 14),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 180,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: ExactAssetImage('assets/images/muslim-pray.jpg'),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Bagaimana Cara Kita Menghadapi Musibah",
                textAlign: TextAlign.left,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: TEXT_COLOR_DARK,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Lorem ipsum dolor sit amet consectetur, adipisicing elit. Mollitia culpa asperiores doloremque rem. Fuga quaerat ipsum, voluptatibus, eum, illo optio nesciunt corrupti aliquam at asperiores molestias eveniet aperiam blanditiis fugit.",
                textAlign: TextAlign.justify,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
