import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:task_manager_client/prepare_screen.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: IntroductionScreen(
        pages: [
          PageViewModel(
            title: 'Time Management',
            body:
                'Learn how to organize your tasks, set priorities, and make the most of your time to achieve your goals efficiently.',
            image: Image(image: AssetImage('assets/intro/slide-1.png')),
          ),
          PageViewModel(
            title: 'Team Management',
            body:
                'Discover effective strategies for collaborating with your team, delegating tasks, and communicating clearly to achieve shared objectives.',
            image: Image(image: AssetImage('assets/intro/slide-2.png')),
          ),
          PageViewModel(
            title: 'Evaluation',
            body:
                'Understand how to assess your progress, review completed tasks, and reflect on your productivity to continuously improve your workflow.',
            image: Image(image: AssetImage('assets/intro/slide-3.png')),
          ),
        ],
        next: Text('Next'),
        showBackButton: true,
        showNextButton: true,
        back: Text('Back'),
        done: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => PrepareScreen(),
              ),
            );
          },
          child: Text('Done'),
        ),
        onDone: () {},
        skip: IconButton(onPressed: () {}, icon: Icon(Icons.skip_next_rounded)),
      ),
    );
  }
}
