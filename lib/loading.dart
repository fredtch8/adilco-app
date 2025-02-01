import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double _kSize = 50.0; // Define the size of the loading animation

    return Center(
      child: LoadingAnimationWidget.flickr(
        leftDotColor: Colors.red[900]!,
        rightDotColor: Colors.white,
        size: _kSize,
      ),
    );
  }
}
