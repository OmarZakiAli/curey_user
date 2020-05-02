import 'package:curey_user/models/medication_model.dart';
import 'package:curey_user/providers/favourites_provider.dart';
import 'package:curey_user/providers/medicatio_provider.dart';
import 'package:curey_user/screens/doctor_details_screen/doctor_details_screen.dart';
import 'package:curey_user/screens/favourites_screen.dart/favourite_item.dart';
import 'package:curey_user/screens/medication_details_screen/medication_details_screen.dart';
import 'package:curey_user/ui_widgets/custom_bold_text.dart';
import 'package:curey_user/ui_widgets/custom_normal_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:toast/toast.dart';

import '../../consts.dart';

class MedicationItem extends StatefulWidget {
  final Products pro;
  MedicationItem(this.pro);

  @override
  _MedicationItemState createState() => _MedicationItemState();
}

class _MedicationItemState extends State<MedicationItem> {
    bool isFav;
      bool isEnabled;
@override
  void initState() {
       isFav=widget.pro.isFavourite;
       isEnabled=true;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
  var width = MediaQuery.of(context).size.width;
  final fav=Provider.of<FavouritesProvider>(context,listen: false);
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
                    text: widget.pro.name.length > 25
                        ? widget.pro.name.substring(0, 18) + "..."
                        : widget.pro.name,
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
            customBoldText(text: "${double.parse(widget.pro.price)>1000?"1k>":widget.pro.price} \$", size: 14),
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
                  isFav?Icons.favorite:  Icons.favorite_border,
                  size: 16,
                ),
                onPressed:isEnabled? () {
                        setState(() {
                             isEnabled=false;

                        });
                       if(!isFav){
                             fav.addtoFavourites(widget.pro).then((onValue){
                        
                           setState(() {
                             isEnabled=true;
                           isFav=true;
                           widget.pro.isFavourite=true;
                           });
                         
                         
                       },onError: (e){
                         Toast.show(e.toString(), context);
                         setState(() {
                             isEnabled=true;
                         });
                       });
                     

                       }else{
                        fav.removeFromFavourites(widget.pro).then((_){
                           setState(() {
                              isEnabled=true;
                           isFav=false;
                       widget.pro.isFavourite=false;

                           });

                        },onError:(e){
                          Toast.show(e.toString(), context);
                          setState(() {
                            isEnabled=true;
                          });
                        } );
                        
                       }

                      

                }:null,
              ),
            ),
            Spacer(),
            InkWell(
               onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (con) {
                      return MedicationDetailsScreen(pro: widget.pro);
                    }));
                  },
                          child: Container(
                margin: const EdgeInsets.only(right: 8.0, bottom: 8),
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                decoration: BoxDecoration(
                  color: Color(0xff09CACB),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: customBoldText(
                      text: "Shop now",
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


