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
                  title: Text('Trang chủ'), icon: Icons.home),
              TitledNavigationBarItem(
                  title: Text('Lịch trình'), icon: Icons.schedule),
              TitledNavigationBarItem(
                  title: Text('Hồ sơ'), icon: Icons.person_outline),
              TitledNavigationBarItem(
                  title: Text('Cài đặt'), icon: Icons.settings),
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
                  title: 'Thông tin về ứng dụng',
                  leading: Icon(Icons.info_outline),
                  onPressed: (BuildContext context) {},
                ),
              ],
            ),
            SettingsSection(
              title: "Thiết lập ứng dụng",
              tiles: [
                SettingsTile(
                  title: 'Ngôn ngữ',
                  subtitle: 'Tiếng Việt',
                  leading: Icon(Icons.language),
                  onPressed: (BuildContext context) {},
                ),
                SettingsTile(
                  title: 'Theme',
                  leading: Icon(Icons.color_lens_outlined),
                  subtitle: 'Mặc định hệ thống',
                ),
                SettingsTile(
                  title: 'Âm thanh',
                  leading: Icon(Icons.music_note),
                ),
                SettingsTile(
                  title: 'Thông báo',
                  leading: Icon(Icons.notifications),
                ),
                SettingsTile(
                  title: 'Nâng cao',
                  leading: Icon(Icons.settings_applications_outlined),
                ),
              ],
            ),
            SettingsSection(
              title: "Bảo mật",
              tiles: [
                SettingsTile(
                  title: 'Cài đặt tài khoản',
                  leading: Icon(Icons.account_box_rounded),
                ),
                SettingsTile.switchTile(
                  title: 'Khóa ứng dụng',
                  leading: Icon(Icons.lock), switchValue: false, onToggle: (bool value) {  },
                ),
              ],
            ),
            SettingsSection(
              title: "Mua cho chúng tôi 1 cái skin Sylas",
              tiles: [
                SettingsTile.switchTile(
                  title: 'Nâng cấp bản premium',
                  subtitle: 'Nhận được lòng biết ơn của chúng tôi',
                  leading: Icon(Icons.lock, color: Colors.redAccent,), switchValue: true, onToggle: (bool value) {  },
                ),
              ],
            ),
          ],
        ));
  }
}
