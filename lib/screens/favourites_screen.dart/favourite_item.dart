import 'package:curey_user/providers/favourites_provider.dart';
import 'package:flutter/material.dart';

import 'package:curey_user/models/medication_model.dart';
import 'package:curey_user/providers/medicatio_provider.dart';
import 'package:curey_user/screens/doctor_details_screen/doctor_details_screen.dart';
import 'package:curey_user/screens/medication_details_screen/medication_details_screen.dart';
import 'package:curey_user/ui_widgets/custom_bold_text.dart';
import 'package:curey_user/ui_widgets/custom_normal_text.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:toast/toast.dart';

import '../../consts.dart';

class FavouriteItem extends StatefulWidget {
  final Products pro;
  FavouriteItem({Key key,this.pro}):super(key:key);
  @override
  _FavouriteItemState createState() => _FavouriteItemState();
}

class _FavouriteItemState extends State<FavouriteItem> {
  bool isEnabled=true;
  @override
  Widget build(BuildContext context) {
      Products pro=widget.pro;
     var fav = Provider.of<FavouritesProvider>(context);
  var width = MediaQuery.of(context).size.width;
  return Container(
    height: 110,
    width: MediaQuery.of(context).size.width,
    margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Color(0x42AEAEAE), width: 1),
    ),
    child: Row(
      children: <Widget>[
        Container(
          child: Image.asset(
            "assets/images/asprin.png",
            width: Sizes.getWidth(100) * width,
            fit: BoxFit.contain,
          ),
          width: Sizes.getWidth(100) * width,
          height: 105,
        ),
        SizedBox(
          width: Sizes.getWidth(18) * width,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 8,
            ),
            Center(
                child: customBoldText(
                    text: pro.name.length > 25
                        ? pro.name.substring(0, 18) + "..."
                        : pro.name,
                    size: 14,
                    color: Color(0xff07A3A4))),
            SizedBox(
              height: 4,
            ),
            SizedBox(
              width: Sizes.getWidth(140) * width,
              height: 30,
              child: customNormalText(
                  text: "antibacterial + anaesthetic 16 tablets ",
                  size: 12,
                  color: Color(0xffAEAEAE),
                  textAlign: TextAlign.left),
            ),
            SizedBox(
              height: 20,
            ),
            customBoldText(
                text:
                    "${double.parse(pro.price) > 1000 ? "1k>" : pro.price} \$",
                size: 14),
          ],
        ),
        Spacer(),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: Icon(
                  Icons.favorite,
                  color: Colors.black,
                  size: 16,
                ),
                onPressed: isEnabled
                    ? () {
                      setState(() {
                      isEnabled=false;
                      });
                        fav.removeFromFavourites(pro).then((onValue) {
                          setState(() {
                            isEnabled=true;
                          });
                        }, onError: (e) {
                          

                          Toast.show(e.toString(), context);
                          setState(() {
                            isEnabled=true;
                          });
                        });
                      }
                    : null,
              ),
            ),
            Spacer(),
            Container(
              margin: const EdgeInsets.only(right: 8.0, bottom: 8),
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
              decoration: BoxDecoration(
                color: Color(0xff09CACB),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (con) {
                      return MedicationDetailsScreen(pro: pro,);
                    }));
                  },
                  child: customBoldText(
                      text: "Buy now",
                      size: 14,
                      weight: FontWeight.w600,
                      color: Colors.white),
                ),
              ),
            ),
          ],
        )
      ],
    ),
  );
  }
}
