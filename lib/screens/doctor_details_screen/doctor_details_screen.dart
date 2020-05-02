import 'package:curey_user/providers/doc_details_provider.dart';
import 'package:curey_user/screens/doctor_details_screen/profile_tab.dart';
import 'package:curey_user/ui_widgets/custom_normal_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:curey_user/models/doctor_detail_model.dart';
import 'doctor_header.dart';
import 'review_item.dart';

class DoctorDetailsScreen extends StatefulWidget {
  final int docId;
  DoctorDetailsScreen({Key key, this.docId}) : super(key: key);
  @override
  _DoctorDetailsScreenState createState() => _DoctorDetailsScreenState();
}

class _DoctorDetailsScreenState extends State<DoctorDetailsScreen> {
  
  @override
  Widget build(BuildContext context) {
    print(widget.docId.toString());
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ),
        backgroundColor: Color(0xffF1F2F6),
        body: FutureBuilder(
            future: Provider.of<DoctorDetailsProvider>(context,listen: false)
                .getDoctDetails(widget.docId),
            builder: (_,AsyncSnapshot<DoctorDetailModel> snap) {
              if (snap.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator(),);
              } else if (snap.connectionState == ConnectionState.done) {
                if (snap.hasError) {
                  print(snap.error.toString());
                  return Center(
                    child: Text(snap.error.toString()),
                  );
                } else {
                  return CustomScrollView(
                    slivers: <Widget>[
                      SliverPersistentHeader(
                        delegate: DoctorHeader(snap.data),
                        floating: true,
                      ),
                      SliverToBoxAdapter(
                        child: SizedBox(
                          height: 16,
                        ),
                      ),
                      SliverFillRemaining(   
                        child: NestedTabBar( docDetails: snap.data,),
                      )
                    ],
                  );
                }
              }
            }));
  }
}

class NestedTabBar extends StatefulWidget {
  final DoctorDetailModel docDetails;
  NestedTabBar({Key key,this.docDetails}):super(key:key);
  @override
  _NestedTabBarState createState() => _NestedTabBarState();
}

class _NestedTabBarState extends State<NestedTabBar>
    with TickerProviderStateMixin {
  TabController _nestedTabController;

  @override
  void initState() {
    super.initState();

    _nestedTabController = new TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _nestedTabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        TabBar(
          labelPadding: EdgeInsets.symmetric(horizontal: 50),
          controller: _nestedTabController,
          indicatorColor: Colors.teal,
          labelColor: Colors.teal,
          unselectedLabelColor: Colors.black54,
          isScrollable: true,
          tabs: <Widget>[
            Tab(
              text: "Profile",
            ),
            Tab(
              text: "Reviews",
            ),
          ],
        ),
        SizedBox(
          height: 16,
        ),
        Expanded(
          child: TabBarView(
            controller: _nestedTabController,
            children: <Widget>[
              ProfileTab(widget.docDetails),
               widget.docDetails.reviews.length==0? Center(
                  child: Text("no reviews added yet"),
               )    :ListView.builder(
                itemCount: widget.docDetails.reviews.length,
                itemBuilder: (con, index) {
                  return buildReviewItem(con, widget.docDetails.reviews[index]);
                },
              )
            ],
          ),
        )
      ],
    );
  }
}
