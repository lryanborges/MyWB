import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:my_wb/pages/chat.dart';
import 'package:my_wb/pages/init.dart';
import 'package:my_wb/pages/login.dart';
import 'package:my_wb/pages/profile.dart';
import 'package:my_wb/pages/profile_details.dart';
import 'package:my_wb/pages/register.dart';
part './app_routes.dart';

class AppPages {
  final List<GetPage> pages = [
    GetPage(name: Routes.home, page: () => const Init()),
    GetPage(name: Routes.login, page: () => const Login()),
    GetPage(name: Routes.register, page: () => const Register()),
    GetPage(name: Routes.chat, page: () => const Chat()),
    GetPage(name: Routes.profile, page: () => const Profile()),
    GetPage(name: Routes.profileDetails, page: () => const ProfileDetails())
  ];
}