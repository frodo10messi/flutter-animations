import 'package:flutter/material.dart';

class Heart extends StatefulWidget {
  @override
  _HeartState createState() => _HeartState();
}

class _HeartState extends State<Heart> with SingleTickerProviderStateMixin {
  bool isFav = false;
  AnimationController _controller;
  Animation<Color> _colorAnimation;

  @override
  void initState() {
    super.initState();
    //EXPLICIT ANIMATION(WE CONTROL THE ANIMATION)
    //IMPLICIT ANIMATION(WE DON'T CONTROL ANIMATION,BUILT IN )

    //animation controller gives us fine graint control over animation
    //this runs a default tween from 0 to 1 in 2 ms.
    //vsync part actually is like a clock and makes our widget a ticker when its on screen . we need to use a mixin for this
    _controller = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
    );

    //a tween is basically which has a beg and end point . from 0 - 1 and it interpolates from 0 to 1
    //by default we only get a default tween from 0 to 1 which cannot be used for colors so we use a color tween and use animate methord so we actually get a controller 
    _colorAnimation = ColorTween(begin: Colors.grey[400], end: Colors.red).animate(_controller);

    //every time a controllers value changes we get thus call back
    //controller.forward makes the value go from 0 to 1 
    //controller.dismiss makes the value from 1 to 0
    _controller.addListener(() {
      // print(_controller.value);
      // print(_colorAnimation.value);
    });

    //we also get a animation status call back stating if its completed or reversed 
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          isFav = true;
        });
      }
      if (status == AnimationStatus.dismissed) {
        setState(() {
          isFav = false;
        });
      }
    }); 
  }

  // dismiss the animation when widgit exits screen
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  //we can use setstate to listen for animation changes in values or animated builder 
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, _){
        return IconButton(
          icon: Icon(
            Icons.favorite,
            color: _colorAnimation.value,
            size: 30,
          ),
          onPressed: () {
            isFav ? _controller.reverse() : _controller.forward();
          },
        );
      }
    );
  }
}
