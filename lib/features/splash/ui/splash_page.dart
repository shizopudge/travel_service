import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../../animations/fade_animation_x.dart';
import '../../../animations/fade_animation_y.dart';
import '../../../constants/constants.dart';
import '../../home/ui/home_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _scaleController;
  late final Animation<double> _scaleAnimation;
  late final ValueNotifier<bool> _isShowedNotifier;

  @override
  void initState() {
    _isShowedNotifier = ValueNotifier<bool>(true);
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 300,
      ),
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 30.0,
    ).animate(_scaleController)
      ..addStatusListener(
        (status) {
          if (status == AnimationStatus.completed) {
            Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.fade,
                child: const HomePage(),
              ),
            );
          }
        },
      );
    super.initState();
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _isShowedNotifier.dispose();
    super.dispose();
  }

  void _onTap() {
    _isShowedNotifier.value = false;
    _scaleController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/splash-bg.jpg',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              colors: [
                Colors.black.withOpacity(.7),
                Colors.black.withOpacity(.6),
                Colors.black.withOpacity(.2),
              ],
            ),
          ),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FadeAnimationY(
                  delay: 1,
                  child: Container(
                    height: 50,
                    width: 50,
                    margin: const EdgeInsets.all(30.0),
                    alignment: Alignment.topLeft,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/icons/lotus.png',
                        ),
                        isAntiAlias: true,
                        colorFilter: ColorFilter.mode(
                          Colors.white,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                ),
                const FadeAnimationY(
                  delay: 1.1,
                  child: Padding(
                    padding: EdgeInsets.all(30.0),
                    child: Text(
                      'Hidden\nTresures\nof Ceylone',
                      style: Styles.header,
                    ),
                  ),
                ),
                FadeAnimationX(
                  delay: 1.5,
                  child: AnimatedBuilder(
                    animation: _scaleAnimation,
                    builder: (context, child) => Transform.scale(
                      scale: _scaleAnimation.value,
                      child: Container(
                        margin: const EdgeInsets.only(left: 50),
                        padding: const EdgeInsets.all(20),
                        decoration: const BoxDecoration(
                          color: Styles.mainColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(
                              150,
                            ),
                          ),
                        ),
                        height: 150,
                        child: ValueListenableBuilder(
                          valueListenable: _isShowedNotifier,
                          builder: (context, isShowed, child) => isShowed
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: _onTap,
                                      borderRadius: BorderRadius.circular(50),
                                      child: Container(
                                        height: 100,
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.transparent,
                                          border: Border.all(
                                            width: 2,
                                            color: Colors.white,
                                          ),
                                        ),
                                        child: Container(
                                          padding: const EdgeInsets.all(21),
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white,
                                          ),
                                          child: Container(
                                            padding: const EdgeInsets.all(12),
                                            decoration: const BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage(
                                                  'assets/icons/right-arrow.png',
                                                ),
                                                colorFilter: ColorFilter.mode(
                                                  Styles.actionColor,
                                                  BlendMode.srcIn,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Text(
                                      'Explore Now',
                                      style: Styles.small.copyWith(
                                        color: Colors.grey.shade900,
                                      ),
                                    ),
                                  ],
                                )
                              : const Center(),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
