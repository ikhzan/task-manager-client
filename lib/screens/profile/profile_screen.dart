import 'package:flutter/material.dart';
import 'package:task_manager_client/commons/constants.dart';
import 'package:task_manager_client/core/local_storage.dart';

class ProfileScreen extends StatelessWidget {
  final double coverHeight = 200;
  final double profileHeight = 144;
  double get top => coverHeight - profileHeight / 2;

  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: 7,
          itemBuilder: (context, index) {
            switch (index) {
              case 0:
          return ProfileTop(coverHeight: coverHeight, profileHeight: profileHeight);
              case 1:
          return ProfileContent();
              case 2:
          return ProfileAccounts();
              case 3:
          return SizedBox(height: 20);
              case 4:
          return Column(
            children: [
              Divider(height: 2),
              SizedBox(height: 10),
              ProfileStats(),
              SizedBox(height: 10),
              Divider(height: 2),
              SizedBox(height: 20),
            ],
          );
              case 5:
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
            'About',
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
                Text(
            'Hi, I\'m Mohammad Ikhsan and I create android app, integrate with restful API, fix bugs, android app reverse engineer expert, can inject code and read binary code android.',
                ),
              ],
            ),
          );
              default:
          return SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}

class ProfileStats extends StatelessWidget {
  const ProfileStats({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Text(
                '39',
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 17),
              ),
              Text('Projects'),
            ],
          ),
          SizedBox(width: 12),
          Column(
            children: [
              Text(
                '526',
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 17),
              ),
              Text('Followings'),
            ],
          ),
          SizedBox(width: 12),
          Column(
            children: [
              Text(
                '5834',
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 17),
              ),
              Text('Followers'),
            ],
          ),
        ],
      ),
    );
  }
}

class ProfileAccounts extends StatelessWidget {
  const ProfileAccounts({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 25,
          child: Center(
            child: Image(image: AssetImage('assets/icons/github.png')),
          ),
        ),
        SizedBox(width: 12),
        CircleAvatar(
          radius: 25,
          child: Center(
            child: Image(image: AssetImage('assets/icons/telegram.png')),
          ),
        ),
        SizedBox(width: 12),
        CircleAvatar(
          radius: 25,
          child: Center(
            child: Image(image: AssetImage('assets/icons/twitter.png')),
          ),
        ),
        SizedBox(width: 12),
        CircleAvatar(
          radius: 25,
          child: Center(
            child: Image(image: AssetImage('assets/icons/linkedin.png')),
          ),
        ),
      ],
    );
  }
}

class ProfileContent extends StatelessWidget {
  const ProfileContent({super.key});

  Future<Map<String, dynamic>> _loadProfileData() async {
    final username = await LocalStorage.getData(Constants.username);
    final fullName = await LocalStorage.getData(Constants.fullName);
    final taskCount = await LocalStorage.getData(
      Constants.taskCount,
    ); // optional: parseInt
    final teamCount = await LocalStorage.getData(Constants.teamCount);
    return {
      'username': username ?? '',
      'fullName': fullName ?? '',
      'taskCount': taskCount ?? '0',
      'teamCount': teamCount ?? '0',
    };
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: FutureBuilder<Map<String, dynamic>>(
        future: _loadProfileData(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final data = snapshot.data!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                data['fullName'] == null ||
                        data['fullName'].toString().trim().isEmpty
                    ? 'Unknown Name'
                    : data['fullName'],
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
              ),
              Text('Full-Stack Developer', style: TextStyle(fontSize: 20)),
              SizedBox(height: 16),
            ],
          );
        },
      ),
    );
  }
}

class ProfileTop extends StatelessWidget {
  const ProfileTop({
    super.key,
    required this.coverHeight,
    required this.profileHeight,
  });

  final double coverHeight;
  final double profileHeight;
  double get top => coverHeight - profileHeight / 2;
  double get bottom => profileHeight / 2;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
      Container(
        margin: EdgeInsets.only(bottom: bottom),
        child: CoverImage(coverHeight: coverHeight),
      ),
      // IconButton at top left
      Positioned(
        top: 16,
        left: 16,
        child: IconButton(
        icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
        onPressed: () {
          Navigator.of(context).maybePop();
        },
        ),
      ),
      Positioned(
        top: top,
        child: ProfileImage(profileHeight: profileHeight),
      ),
      ],
    );
  }
}

class ProfileImage extends StatelessWidget {
  const ProfileImage({super.key, required this.profileHeight});

  final double profileHeight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CircleAvatar(
        radius: profileHeight / 2,
        backgroundColor: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ClipOval(child: Image.asset('assets/images/profile.webp')),
        ),
      ),
    );
  }
}

class CoverImage extends StatelessWidget {
  const CoverImage({super.key, required this.coverHeight});

  final double coverHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      width: double.infinity,
      height: coverHeight,
      child: Image.asset('assets/images/bg.jpg', fit: BoxFit.cover),
    );
  }
}
