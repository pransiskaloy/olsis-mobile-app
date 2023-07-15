import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:olsis/widgets/splash.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../pages/login.dart';
import 'constants.dart';

class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({Key? key}) : super(key: key);

  @override
  State<GetStartedScreen> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStartedScreen> {
  final controller = CarouselController();
  int activeIndex = 0;
  final urlImages = [
    'images/welcome.png',
    'images/attendance2.png',
    'images/announcement.png',
    'images/billing.png',
    'images/grades.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('images/carousel_background.png'),
            ),
          ),
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 80),
                CarouselSlider.builder(
                  carouselController: controller,
                  options: CarouselOptions(
                    height: 500,
                    initialPage: 0,
                    viewportFraction: 1,
                    enlargeCenterPage: true,
                    enlargeFactor: 0.5,
                    autoPlay: false,
                    enableInfiniteScroll: false,
                    onPageChanged: (index, reason) {
                      setState(() => activeIndex = index);
                      print(activeIndex);
                    },
                  ),
                  itemCount: urlImages.length,
                  itemBuilder:
                      (BuildContext context, int index, int realIndex) {
                    final urlImage = urlImages[index];

                    return buildImage(urlImage, index);
                  },
                ),
                const SizedBox(height: 30),
                buildIndicator(),
                const SizedBox(height: 20),
                buidButtons(activeIndex),
              ],
            ),
          )),
    );
  }

  Widget buildImage(String urlImage, int index) => SizedBox(
        height: MediaQuery.of(context).size.height,
        // margin: const EdgeInsets.symmetric(horizontal: 12),
        child: Image.asset(
          urlImage,
          fit: BoxFit.cover,
        ),
      );
  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: urlImages.length,
        onDotClicked: animateToSlide,
        effect: ExpandingDotsEffect(
          activeDotColor: UiConstants.qrColor,
          dotColor: Colors.white,
        ),
      );
  Widget buidButtons(int index, {bool stretch = false}) => Container(
        child: index < (urlImages.length - 1)
            ? Container()
            : ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (c) => const LoginPage()));
                },
                style: ElevatedButton.styleFrom(
                  primary: const Color(0xFF4F6CAD),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50), // <-- Radius
                  ),
                ),
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width * .3,
                  padding: const EdgeInsets.symmetric(vertical: 7.0),
                  child: Text(
                    "Proceed",
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        letterSpacing: 1,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
      );

  proceed() {}
  void animateToSlide(int index) => controller.animateToPage(index);
}
