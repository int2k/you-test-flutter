import 'package:flutter/material.dart';
import 'package:youappflutter/components/appbar.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          gradient: const RadialGradient(
            center: Alignment(0.58, 0.83),
            radius: 0.35,
            colors: [Color(0xFF1F4247), Color(0xFF0D1C22), Color(0xFF09141A)],
          ),
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
        ),
        child: Scaffold(
          appBar: CustomAppBar(
            isHome: true,
          ),
          body: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Home View', style: TextStyle(fontSize: 24)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
