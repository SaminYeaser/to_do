import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:todo/app/modules/home/view.dart';
class Onboarding extends StatefulWidget {
  const Onboarding({Key? key}) : super(key: key);

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final PageController controller = PageController();
  bool isLastPage = false;
  final _onBoarding = GetStorage('onBoarding');

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller,
        onPageChanged: (index){
          setState(() {
            isLastPage = index == 2;
          });
        },
        children: [
          Container(
            color: Colors.grey,
            child: const Center(
              child: Text('ToDo Application'),
            ),
          ),
          Container(
            color: Colors.grey,
            child: const Center(
              child: Text('Done with GetX'),
            ),
          ),
          Container(
            color: Colors.grey,
            child: const Center(
              child: Text('Welcome'),
            ),
          )
        ],
      ),
      bottomSheet: isLastPage ? Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 40,
          child: TextButton(
            child: const Text(
              'Get Started'
            ),
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0)
              ),
              primary: Colors.white,
              backgroundColor: Colors.teal,
              maximumSize: const Size.fromHeight(80)
            ),
            onPressed: ()async{
              _onBoarding.write('onBoarding', false);
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context)=> Home())
              );
            },
          ),
        ),
      ): Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
                onPressed: ()=>controller.jumpToPage(2),
                child: const Text('SKIP')),
            Center(
              child: SmoothPageIndicator(
                controller: controller,
                count: 3,

              ),
            ),
            TextButton(
                onPressed: ()=>controller.nextPage(
                    duration: Duration(microseconds: 500),
                    curve: Curves.easeInOut),
                child: const Text('NEXT')),
          ],
        ),
      ),
    );
  }
}
