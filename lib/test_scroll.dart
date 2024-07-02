import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class TestScroll extends StatelessWidget {
  const TestScroll({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.red,
        body: Center(child: MyWidget()),
      ),
    );
  }
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text('press'),
      onPressed: () {
        showBottomSheet(
            context: context,
            builder: (e) {
              return Container(
                height: 300,
                child: Scrollbar(
                  // child: ListView.builder(
                  //   itemCount: 50,
                  //   itemBuilder: (context, index) {
                  //     return Text(
                  //       'truong hhehehhe ehheeh',
                  //       style: TextStyle(color: Colors.red),
                  //     );
                  //   },
                  // ),
                  child: SingleChildScrollView(
                      child: ReadMoreText(
                    'truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong truong ',
                    trimMode: TrimMode.Line,
                    trimLines: 5,
                    style: const TextStyle(
                        fontSize: 13,
                        height: 1.2,
                        color: Colors.red,
                        fontWeight: FontWeight.w500),
                    trimCollapsedText: ' ${'show_more'}',
                    trimExpandedText: ' ${'show_less'}',
                  )),
                ),
              );
            });
      },
    );
  }
}
