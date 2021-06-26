import 'package:flutter/material.dart';
import 'package:titled_navigation_bar/titled_navigation_bar.dart';
import 'profile.dart';
import 'schedule.dart';
import 'home_page.dart';
import 'widgets/slide_right.dart';
import 'activities.dart';
import 'package:settings_ui/settings_ui.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  get value => false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: TitledBottomNavigationBar(
            currentIndex: 3,
            onTap: (index) {
              if (3 != index) {
                if (index == 1) {
                  Navigator.pushReplacement(
                      context, SlideRightRoute(page: Schedule()));
                }
                if (index == 0) {
                  Navigator.pushReplacement(
                      context, SlideRightRoute(page: HomePage()));
                }
                if (index == 2) {
                  Navigator.pushReplacement(
                      context, SlideRightRoute(page: Profile()));
                }
              }
            },
            items: [
              TitledNavigationBarItem(
                  title: Text('Homepage', style: TextStyle(fontSize: 12),), icon: Icons.home),
              TitledNavigationBarItem(
                  title: Text('Schedule'), icon: Icons.schedule),
              TitledNavigationBarItem(
                  title: Text('Profile'), icon: Icons.person_outline),
              TitledNavigationBarItem(
                  title: Text('Settings'), icon: Icons.settings),
            ]),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 5.0),
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Activities()),
              );
            },
            backgroundColor: Color(0xFFF17532),
            child: Icon(Icons.book),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: SettingsList(
          sections: [
            SettingsSection(
              tiles: [
                SettingsTile(
                  title: 'App infomation',
                  leading: Icon(Icons.info_outline),
                  onPressed: (BuildContext context) {},
                ),
              ],
            ),
            SettingsSection(
              title: "App settings",
              tiles: [
                SettingsTile(
                  title: 'Language',
                  subtitle: 'English',
                  leading: Icon(Icons.language),
                  onPressed: (BuildContext context) {},
                ),
                SettingsTile(
                  title: 'Theme',
                  leading: Icon(Icons.color_lens_outlined),
                  subtitle: 'System default',
                ),
                SettingsTile(
                  title: 'Sounds',
                  leading: Icon(Icons.music_note),
                ),
                SettingsTile(
                  title: 'Notifications',
                  leading: Icon(Icons.notifications),
                ),
                SettingsTile(
                  title: 'Advance',
                  leading: Icon(Icons.settings_applications_outlined),
                ),
              ],
            ),
            SettingsSection(
              title: "Bảo mật",
              tiles: [
                SettingsTile(
                  title: 'Accounts settings',
                  leading: Icon(Icons.account_box_rounded),
                ),
                SettingsTile.switchTile(
                  title: 'App lock',
                  leading: Icon(Icons.lock), switchValue: false, onToggle: (bool value) {  },
                ),
              ],
            ),
            SettingsSection(
              title: "Buy us a Sylas skin",
              tiles: [
                SettingsTile.switchTile(
                  title: 'Upgrade to premium',
                  subtitle: 'U have my attention',
                  leading: Icon(Icons.lock, color: Colors.redAccent,), switchValue: true, onToggle: (bool value) {  },
                ),
              ],
            ),
          ],
        ));
  }
}
