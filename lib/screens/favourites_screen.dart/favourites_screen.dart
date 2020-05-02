import 'package:curey_user/dialogs/medication_filter.dart';
import 'package:curey_user/models/medication_model.dart';
import 'package:curey_user/providers/favourites_provider.dart';
import 'package:curey_user/providers/medicatio_provider.dart';
import 'package:curey_user/screens/doctors_screen/doctor_item.dart';
import 'package:curey_user/ui_widgets/app_drawer.dart';
import 'package:curey_user/ui_widgets/custom_bold_text.dart';
import 'package:curey_user/ui_widgets/custom_normal_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:curey_user/dialogs/warning_dialog.dart';

import '../../consts.dart';
import 'favourite_item.dart';

class FavouritesScreen extends StatefulWidget {
  @override
  _FavouritesScreenState createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  @override
  void initState() {
        final _favProvider = Provider.of<FavouritesProvider>(context,listen: false);
_favProvider.getFavourites();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final _favProvider = Provider.of<FavouritesProvider>(context);

    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        title:
            customBoldText(text: "Saves", color: Colors.black, size: 20),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top:20.0),
        child:_favProvider.isLoading?Center(child: CircularProgressIndicator()):
        _favProvider.favourites.isEmpty?Center(child: customNormalText(text:"No favourites added yet"),) :
        ListView.builder(
          itemCount: _favProvider.favourites.length,
          itemBuilder: (con,index){
            return FavouriteItem(pro: _favProvider.favourites[index],);
          }),
              
                
              
            



      ),
    );
  }
}
