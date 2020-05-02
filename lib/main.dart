import 'package:curey_user/models/appointments_model.dart';
import 'package:curey_user/providers/appointments_provider.dart';
import 'package:curey_user/providers/auth_provider.dart';
import 'package:curey_user/providers/cart_provider.dart';
import 'package:curey_user/providers/orders_provider.dart';
import 'package:curey_user/providers/prescriptionProvider.dart';
import 'package:curey_user/providers/doc_details_provider.dart';
import 'package:curey_user/providers/favourites_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'screens/splash_sceen/splash_screen.dart';
import 'package:curey_user/providers/doctor_provider.dart';
import 'package:curey_user/providers/medicatio_provider.dart';
import 'package:curey_user/providers/med_details_provider.dart';

void main() async{
    WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        ),
             ChangeNotifierProvider(
          create: (_) => DoctorsProvider(),
        ),
         ChangeNotifierProvider(
          create: (_) => MedicationProvider(),
        ),
         ChangeNotifierProvider(
          create: (_) => MedicationDetailsProvider(),
        ),
          ChangeNotifierProvider(
          create: (_) => DoctorDetailsProvider(),
        ),
          ChangeNotifierProvider(
          create: (_) => FavouritesProvider(),
        ),
         ChangeNotifierProvider(
          create: (_) => AppointmentsProvider(),
        ),
          ChangeNotifierProvider(
          create: (_) => PrescriptionProvider(),
        ),
          ChangeNotifierProvider(
          create: (_) => CartProvider(),
        ),
         ChangeNotifierProvider(
          create: (_) => OrdersProvider(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(),
        home: SplashScreen(),
      ),
    );
  }
}
