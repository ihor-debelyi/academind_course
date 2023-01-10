import 'package:flutter/material.dart';
import 'package:places_app/providers/user_places.dart';
import 'package:places_app/screens/add_place_screen.dart';
import 'package:places_app/screens/place_details_screen.dart';
import 'package:places_app/screens/places_list_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => UserPlacesProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          colorScheme:
              ColorScheme.fromSwatch().copyWith(secondary: Colors.amber),
        ),
        home: PlacesListScreen(),
        routes: {
          AddPlaceScreen.routeName: (context) => AddPlaceScreen(),
          PlaceDetailsScreen.routeName: (context) => PlaceDetailsScreen()
        },
      ),
    );
  }
}
