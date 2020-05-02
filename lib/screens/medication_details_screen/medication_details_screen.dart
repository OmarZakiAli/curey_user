import 'package:curey_user/models/med_details_model.dart';
import 'package:curey_user/models/medication_model.dart';
import 'package:curey_user/providers/med_details_provider.dart';
import 'package:curey_user/screens/medication_details_screen/pharmacy_item.dart';
import 'package:curey_user/ui_widgets/app_drawer.dart';
import 'package:curey_user/ui_widgets/custom_bold_text.dart';
import 'package:curey_user/ui_widgets/custom_normal_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MedicationDetailsScreen extends StatelessWidget {
  final Products pro;
  MedicationDetailsScreen({Key key, this.pro}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _medDetailsPro = Provider.of<MedicationDetailsProvider>(context);

    var width = MediaQuery.of(context).size.width;
        print( "id: ${pro.id.toString()}");
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title:
            customBoldText(text: "Medication", color: Colors.black, size: 20),
        centerTitle: true,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        backgroundColor: Colors.white,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: CircleAvatar(
              child: Icon(
                Icons.camera_alt,
                color: Colors.white,
              ),
              backgroundColor: Color(0xff09CACB),
            ),
          )
        ],
      ),
      body: FutureBuilder(
          future: _medDetailsPro.getProductDetails(pro.id),
          builder: (context, AsyncSnapshot<MedicationDetailModel> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Center(child: Text("${snapshot.error.toString()}"));
              } else if (snapshot.hasData) {
                var med = snapshot.data.product;
                print(med.name);
                List<Pharmacies> pharms = snapshot.data.pharmacies;
               
                return CustomScrollView(
                  slivers: <Widget>[
                    SliverPersistentHeader(
                      delegate: HeaderDelegate(),
                      pinned: false,
                      floating: true,
                    ),
                    SliverFillRemaining(
                      child: Container(
                        padding: EdgeInsets.only(top: 12, right: 16, left: 16),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20)),
                            border:
                                Border.all(color: Color(0x5D5D5D4D), width: 1)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                customBoldText(
                                    text: med.name,
                                    max: 25,
                                    size: 24,
                                    color: Color(0xff07A3A4)),
                                customBoldText(
                                    text: med.price,
                                    color: Colors.black,
                                    max: 7,
                                    size: 16),
                              ],
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            customNormalText(
                                text: med.description==null?"null":med.description,
                                maxlines: 3,
                                max: 200,
                                textAlign: TextAlign.left,
                                color: Color(0xffAEAEAE)),
                            SizedBox(
                              height: 20,
                            ),
                            customNormalText(
                                text:
                                    "Dilevary cost :${med.deliveryFees} Le",
                                size: 14,
                                max: 27,
                                textAlign: TextAlign.left),
                            SizedBox(
                              height: 6,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                customNormalText(
                                    text: "based on your address",
                                    color: Color(0xffAEAEAE),
                                    textAlign: TextAlign.left),
                                InkWell(
                                  child: customNormalText(
                                      text: "Change Address",
                                      color: Color(0xff09CACB)),
                                  onTap: () {
                                    print("change address");
                                  },
                                )
                              ],
                            ),
                            SizedBox(height: 4),
                            Row(
                              children: <Widget>[
                                Icon(
                                  Icons.location_on,
                                  size: 12,
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                customNormalText(
                                    text: "Mansoura, Gehan ST",
                                    size: 11,
                                    color: Color(0xffAEAEAE)),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            customBoldText(
                              text: "Pharmacies List",
                              size: 14,
                              color: Color(0xff242A37),
                            ),
                            pharms == null
                                ? Container()
                                : Expanded(
                                    child: ListView.builder(
                                      itemCount: pharms.length,
                                      itemBuilder: (con, index) {
                                        return PharmacyItem(
                                            pharm: pharms[index],pro: Products(id: pro.id,name: snapshot.data.product.name,price: snapshot.data.product.price,image: snapshot.data.product.image,isFavourite: snapshot.data.product.isFavourite));
                                      },
                                    ),
                                  )
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }
            }
          }),
    );
  }
}

class HeaderDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      width: width * 7,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(
              "assets/images/asprin.png",
            ),
            fit: BoxFit.contain),
      ),
    );
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => 200;

  @override
  // TODO: implement minExtent
  double get minExtent => 100;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    // TODO: implement shouldRebuild
    return true;
  }
}
