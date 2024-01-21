// change between  page  in same row or colum
import 'package:flutter/material.dart';

class PageViewPage extends StatefulWidget {
  const PageViewPage({super.key});

  @override
  State<PageViewPage> createState() => _PageViewPageState();
}

class _PageViewPageState extends State<PageViewPage> {
  late PageController pageController;
  bool showBtns = false;

  @override
  void initState() {
    pageController = PageController(initialPage: 0);
    initLister();
    showBtnsFunc();
    super.initState();
  }

  //todo 3ala ay  ?? to open
  void initLister() async {
    await Future.delayed(const Duration(milliseconds: 100));
    pageController.addListener(() {
      setState(() {});
    });
  }

  void showBtnsFunc() async {
    await Future.delayed(const Duration(milliseconds: 120));
    showBtns = true;
    setState(() {});
  }

  //function  Button 3alsha el  zararaa
  ButtonStyle? buttonStyle(int index) {
    return (index == pageController.page?.toInt())
        ? TextButton.styleFrom(
      shadowColor: Colors.indigoAccent,
    )
        : null;
  }

//function Button 3alsha el tangal between el page + futer(await , async) +
// a3adada build of page
  void onTapOnBtn(int index) async {
    await pageController.animateToPage(index,
        duration: const Duration(milliseconds: 200),
        curve: Curves.fastOutSlowIn);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            if (showBtns)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      style: buttonStyle(0),
                      onPressed: () {
                        onTapOnBtn(0);
                      },
                      child: const Text('First Page')),
                  TextButton(
                      style: buttonStyle(1),
                      onPressed: () {
                        onTapOnBtn(1);

                        // pageController.animateToPage(1,
                        //     duration: Duration(milliseconds: 200),
                        //     curve: Curves.fastEaseInToSlowEaseOut);
                      },
                      child: const Text('Second Page')),
                  TextButton(
                      style: buttonStyle(2),
                      onPressed: () {
                        onTapOnBtn(2);
                      },
                      child: const Text('Third Page')),
                ],
              ),
            Expanded(
              child: PageView(
                //todo el page atkown scorel paltawal
                scrollDirection: Axis.vertical,
                // physics: const NeverScrollableScrollPhysics(),
                controller: pageController,
                children: [
                  // BlocBUILDER get set
                  // BlocConsumer<CounterCubit,CounterState>
                  // //state el howa bata3a counter state statera 103  //todo 3asha el 3ad
                  //   (builder: (context,state){
                  //   return Column(children: [
                  //     Text(state.counterValue.toString()),
                  //     ElevatedButton(onPressed:()=> BlocProvider.of <CounterCubit>(context).increment(),
                  //         child: Text('+')),
                  //     ElevatedButton(onPressed: ()=> BlocProvider.of <CounterCubit>(context).decrement(), child: Text('-')),
                  //   ],
                  //   );
                  //
                  // },
                  //     listener: (_, ___){}),
                  Container(
                    color: Colors.cyan,
                  ),
                  Container(
                    color: Colors.indigoAccent,
                  ),
                  Container(color: Colors.lime),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
//3:47