import 'package:animated_list/animated_list.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(MainPage());
}
class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Banner(
        message: 'Shebin',
        color: Colors.orange,
        location: BannerLocation.topEnd,
        child: AnimatedListScreen()),
      debugShowCheckedModeBanner: false,
      
    );
  }
}