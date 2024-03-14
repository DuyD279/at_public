import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ScreenWrapper extends StatefulWidget {
  ScreenWrapper({super.key});

  @override
  State<ScreenWrapper> createState() => _ScreenWrapperState();
}

class _ScreenWrapperState extends State<ScreenWrapper> {
// Method to set the status bar brightness based on the theme
  /*void updateStatusBarBrightness() {
    Brightness statusBarBrightness = Theme.of(context).brightness;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarBrightness: statusBarBrightness,
      statusBarIconBrightness: statusBarBrightness == Brightness.dark
          ? Brightness.light
          : Brightness.dark,
    ));}*/

  /*void setStatusColor (bool theme) {
     if (theme) {
          print(Text('Dark'));


        // Changing "status bar" and "navigation bar" color
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          statusBarColor: Colors.black,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: Colors.black,
          systemNavigationBarIconBrightness: Brightness.dark,
        ));
        print(SystemUiOverlayStyle.dark.statusBarColor.toString());

        }
        else {
          print(Text('Light'));

        // Changing "status bar" and "navigation bar" color
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarColor: Colors.white,
          systemNavigationBarIconBrightness: Brightness.light,

        ));
       

        }
  }*/

  int _currentIndex = 0;

  final _bottomNavigationBarItems = [
    const BottomNavigationBarItem(
      icon: Icon(
        FeatherIcons.home,
      ),
      activeIcon: Icon(
        FeatherIcons.home,
        color: Colors.pink,
      ),
      label: '',
      backgroundColor: null,
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        FeatherIcons.users,
      ),
      activeIcon: Icon(
        FeatherIcons.users,
        color: Colors.blue,
      ),
      label: '',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        FeatherIcons.plusCircle,
      ),
      activeIcon: Icon(
        FeatherIcons.plusCircle,
        color: Colors.orange,
      ),
      label: '',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        FeatherIcons.heart,
      ),
      activeIcon: Icon(
        FeatherIcons.heart,
        color: Colors.purple,
      ),
      label: '',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        FeatherIcons.bookmark,
      ),
      label: '',
      activeIcon: Icon(
        FeatherIcons.bookmark,
        color: Colors.yellow,
      ),
    ),
  ];

  //display profile sheet
  /*Future _displayProfileSheet(BuildContext context) {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => ProfilePage()()
    );
  }*/

  void supaBaseSignOut(SupabaseClient supaBase){
    supaBase.auth.signOut();
  }
  final supabase = Supabase.instance.client;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (newIndex) {
              setState(() {
                _currentIndex = newIndex;
              });
            },
            children: const [
              //HomePage(),
              /*FollowingPostPage(),
              CameraExampleHome(),
              NotificationPage(),
              SavedPage(),*/
            ],
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              //systemOverlayStyle: SystemUiOverlayStyle(
              //statusBarColor: Theme.of(context).colorScheme.primary,
              //statusBarBrightness: Brightness.light,
              //systemStatusBarContrastEnforced: true,
              //),

              backgroundColor: Color.fromARGB(0, 0, 0, 0),
              leadingWidth: 50,
              leading: Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.05),

                //to add profile picture
                child: GestureDetector(
                    onTap: () {
                      //_displayProfileSheet(context);
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.grey,
                    )),
              ),
              elevation: 0,
              actions: [
                //to add feedback funtion
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Icon(
                      Icons.circle,
                      color: Colors.red.withOpacity(0.7),
                      size: 40,
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.flag_outlined,
                          size: 20,
                          color: Colors.white,
                        )),
                    Padding(
                      padding: const EdgeInsets.only(right: 100),
                      child: IconButton(
                        onPressed: (){
                          supaBaseSignOut(supabase);
                          
                        },
                        icon: Icon(
                          Icons.abc,
                        )
                        ),
                    ),
                  ],
                ),

                //to add search function
                Padding(
                  padding: EdgeInsets.only(
                      right: MediaQuery.of(context).size.width * 0.03),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Icon(
                        Icons.circle,
                        color: Colors.yellow.withOpacity(0.7),
                        size: 40,
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.search,
                            color: Colors.white,
                            size: 20,
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: MediaQuery.of(context).size.height * 0.08,
        child: BottomNavigationBar(
          unselectedFontSize: 0,
          selectedFontSize: 0,
          iconSize: 30,
          backgroundColor: Theme.of(context).colorScheme.background,
          fixedColor: null,
          currentIndex: _currentIndex,
          items: _bottomNavigationBarItems,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            setState(() {
              _pageController.animateToPage(
                index,
                duration: const Duration(milliseconds: 10),
                curve: Curves.ease,
              );
            });
          },
        ),
      ),
    );
  }
}
