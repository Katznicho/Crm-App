import 'package:crm_app/screens/AuthNavigator.dart';
import 'package:crm_app/screens/DefaultScreen.dart';

import 'package:crm_app/screens/home_screen.dart';
import 'package:crm_app/screens/layout/admin_panel_layout.dart';
import 'package:crm_app/screens/signin.dart';

import '../../screens/dashboard.dart';

import '../../screens/tickets/view_ticket.dart';
import '../../utils/constants/app_routes.dart';

class Routes {
  static var rout = {
    AppRoutes.DEFAULT: (context) => const AuthNavigator(),
    AppRoutes.SIGN_IN: (context) => const SignIn(),
    AppRoutes.SIGN_OUT: (context) => const SignIn(),
    AppRoutes.TEST: (context) => AdminPanelLayout(child: HomeScreen()),
    AppRoutes.ONE: (context) => AdminPanelLayout(child: HomeScreen()),
    AppRoutes.HOME: (context) => AdminPanelLayout(child: FcDashboard()),
    AppRoutes.VIEWTICKETS: (context) => AdminPanelLayout(child: ViewTickets())
  };
}
