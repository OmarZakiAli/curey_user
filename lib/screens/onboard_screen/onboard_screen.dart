import 'package:curey_user/models/localization_model.dart';
import 'package:curey_user/providers/auth_provider.dart';
import 'package:curey_user/screens/sign_in_screen/sign_in_screen.dart';
import 'package:curey_user/screens/sign_up_screen/sign_up_form.dart';
import 'package:curey_user/ui_widgets/custom_bold_text.dart';
import 'package:curey_user/ui_widgets/custom_botton.dart';
import 'package:curey_user/ui_widgets/custom_normal_text.dart';
import 'package:flutter/material.dart';
import 'package:curey_user/consts.dart';
import 'package:provider/provider.dart';
import 'package:transformer_page_view/transformer_page_view.dart';

class OnboardSceen extends StatefulWidget {
  @override
  _OnboardSceenState createState() => _OnboardSceenState();
}

class _OnboardSceenState extends State<OnboardSceen> {
  int _pageNumber = 0;

  List<AssetImage> _onboardImages = [
    AssetImage("assets/images/doctors_onboard.png"),
    AssetImage("assets/images/medicine_illustration.png"),
    AssetImage("assets/images/phone_illustration.png")
  ];

  List<String> _onboardMainText = [];
    

  List<String> _onboardHintText = [];

  List<Image> _groubIcons = [
    Image.asset("assets/images/groub1.png", height: 8),
    Image.asset("assets/images/groub2.png", height: 8),
    Image.asset("assets/images/groub3.png", height: 8)
  ];


      final IndexController controller = IndexController();


  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
      LocalizationModel local=Provider.of<AuthProvider>(context).local;
      _onboardMainText.add(local.onboard1Main);
      _onboardMainText.add(local.onboard2Main);
      _onboardMainText.add(local.onboard3Main);
      _onboardHintText.add(local.onboard1Para);
     _onboardHintText.add(local.onboard2Para);
     _onboardHintText.add(local.onboard3Para);



    print("onboard");
    
    
        TransformerPageView transformerPageView = TransformerPageView(
            pageSnapping: true,
            duration: Duration(milliseconds: 100),
            onPageChanged: (index) {
              setState(() {
                this._pageNumber = index;
              });
            },
          
            loop: false,
            controller: controller,
            itemCount: 3,
            transformer: PageTransformerBuilder(
              
              builder: (Widget child,TransformInfo  info){
return    Container(
          color: _pageNumber == 2 ? Color(0xff09CACB) : Colors.white,
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: 70,
              ),
              Container(
                height: 220,
                width: w,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: _onboardImages[_pageNumber],
                )),
              ),
              SizedBox(
                height: 100,
              ),
              Center(
                child:   customBoldText(
                  text: _onboardMainText[_pageNumber],
                   color:_pageNumber==2?Colors.white: Color(0xff07A3A4),
                    size: 30,
                  weight: FontWeight.w900),
              ),
              SizedBox(
                height: 8,
              ),
              Center(
                child: Container(
                  // height: Sizes.getHeight(56) * h,
                  width: Sizes.getWidth(300) * w,
                  child: customNormalText(
                      color: _pageNumber == 2 ? Colors.white : Colors.black,
                      text: _onboardHintText[_pageNumber],
                      size: 12),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Center(
                child: _groubIcons[_pageNumber],
              ),
              SizedBox(
                height: 24,
              ),
              Center(
                child: _pageNumber < 2
                    ? customBotton(context, text: local.next, colorSchema: 1,
                        onTap: () {
                                                    _pageNumber += 1;

                        setState(() {
                        });
                      })
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          customBotton(context, text: local.signup                          , colorSchema: 2,
                              onTap: () {
                            Navigator.of(context).pushReplacement(MaterialPageRoute(
                              builder: (con) => SignUpForm(),
                            ));
                            print("sign up");
                          }),
                          SizedBox(
                            height: 12,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context)
                                  .pushReplacement(MaterialPageRoute(builder: (con) {
                                return SignInScreen();
                              }));
                            },
                            child: customBoldText(
                                text: local.signin, size: 14, color: Colors.white),
                          )
                        ],
                      ),
              ),
              SizedBox(
                height: 16,
              ),
              _pageNumber == 2
                  ? Container()
                  : Center(
                      child: InkWell(

                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal:10,vertical:10),
                          child: Image.asset("assets/images/skip.png")),
                        onTap: () {
                          Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (con) => SignInScreen(),
                          ));
                        },
                      ),
                    )
            ],
          ),
        );     
              }
            ),
            );
       
       
      
      return Scaffold(
          backgroundColor: Colors.white,
          body: transformerPageView,
        );
      
      
    
  }
}
