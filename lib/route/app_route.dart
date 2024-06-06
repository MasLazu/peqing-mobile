import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:peqing/presentation/screens/admin/admin_detail_subject.dart';
import 'package:peqing/presentation/screens/admin/admin_subject_screen.dart';
import 'package:peqing/presentation/screens/lecturer/lecturer_add_grade_page.dart';
import 'package:peqing/presentation/screens/lecturer/lecturer_home_page.dart';
import 'package:peqing/presentation/screens/lecturer/lecturer_profile_screen.dart';
import 'package:peqing/presentation/screens/lecturer/lecturer_scan_page.dart';
import 'package:peqing/bloc/auth/auth_bloc.dart';
import 'package:peqing/presentation/screens/admin/admin_civitas_screen.dart';
import 'package:peqing/presentation/screens/admin/admin_home_screen.dart';
import 'package:peqing/presentation/screens/admin/admin_profile_screen.dart';
import 'package:peqing/presentation/screens/lecturer/lecturer_subject_screen.dart';
import 'package:peqing/presentation/screens/login_screen.dart';
import 'package:peqing/presentation/screens/onboarding_screen.dart';
import 'package:peqing/presentation/screens/splash_screen.dart';
import 'package:peqing/presentation/screens/student/student_home_screen.dart';
import 'package:peqing/presentation/screens/student/student_profile_screen.dart';
import 'package:peqing/presentation/screens/student/student_subject_screen.dart';
import 'package:peqing/presentation/widgets/navbar/admin_navbar.dart';
import 'package:peqing/presentation/widgets/navbar/lecturer_navbar.dart';
import 'package:peqing/presentation/widgets/navbar/student_navbar.dart';

import 'package:peqing/route/route_names.dart';

GoRouter appRoute = GoRouter(
  initialLocation: RouteNames.root,
  routes: [
    GoRoute(
      path: RouteNames.root,
      redirect: _initialRedirect,
      pageBuilder: (context, state) => CupertinoPage(
        key: state.pageKey,
        child: const SplashScreen(),
      ),
    ),
    GoRoute(
      path: RouteNames.onBoarding,
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        transitionsBuilder: _fadeTransition,
        child: const OnboardingScreen(),
      ),
    ),
    GoRoute(
      path: RouteNames.login,
      pageBuilder: (context, state) => CupertinoPage(
        key: state.pageKey,
        child: const LoginScreen(),
      ),
    ),
    ShellRoute(
      navigatorKey: GlobalKey<NavigatorState>(),
      pageBuilder: (context, state, child) => CustomTransitionPage(
        transitionsBuilder: _fadeTransition,
        child: AdminNavbar(page: child, state: state),
      ),
      routes: [
        GoRoute(
          path: RouteNames.adminHome,
          pageBuilder: (context, state) => CustomTransitionPage(
            key: state.pageKey,
            transitionsBuilder: _fadeTransition,
            child: const AdminHomeScreen(),
          ),
        ),
        GoRoute(
          path: RouteNames.adminCivitas,
          pageBuilder: (context, state) => CustomTransitionPage(
            key: state.pageKey,
            transitionsBuilder: _fadeTransition,
            child: const AdminCivitasScreen(),
          ),
        ),
        GoRoute(
          path: RouteNames.adminSubjects,
          pageBuilder: (context, state) => CustomTransitionPage(
            key: state.pageKey,
            transitionsBuilder: _fadeTransition,
            child: const AdminSubjectScreen(),
          ),
        ),
        GoRoute(
          path: '${RouteNames.adminDetailSubject}/:id',
          pageBuilder: (context, state) => CupertinoPage(
            key: state.pageKey,
            child: const AdminDetailSubject(
              subjectId: state.pathParameters['id']!,
            ),
          ),
        ),
      ],
    ),
    GoRoute(
      path: '${RouteNames.adminDetailSubject}/:id',
      pageBuilder: (context, state) => const CustomTransitionPage(
        transitionsBuilder: _fadeTransition,
        child: AdminProfileScreen(),
      ),
    ),
    ShellRoute(
        navigatorKey: GlobalKey<NavigatorState>(),
        pageBuilder: (context, state, child) => CustomTransitionPage(
              transitionsBuilder: _fadeTransition,
              child: LecturerNavbar(page: child, state: state),
            ),
        routes: [
          GoRoute(
            path: RouteNames.lecturerHome,
            pageBuilder: (context, state) => CustomTransitionPage(
                key: state.pageKey,
                transitionsBuilder: _fadeTransition,
                child: const LecturerHomePage()),
          ),
          GoRoute(
            path: RouteNames.lecturerProfile,
            pageBuilder: (context, state) => CustomTransitionPage(
                key: state.pageKey,
                transitionsBuilder: _fadeTransition,
                child: const LecturerProfileScreen()),
          ),
          GoRoute(
            path: RouteNames.lecturerSubject,
            pageBuilder: (context, state) => CustomTransitionPage(
                key: state.pageKey,
                transitionsBuilder: _fadeTransition,
                child: const LecturerSubjectScreen()),
          ),
        ]),
    GoRoute(
      path: RouteNames.lecturerScanQR,
      pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          transitionsBuilder: _fadeTransition,
          child: const LecturerScanPage()),
    ),
    GoRoute(
      path: '${RouteNames.lecturerAddGrade}/:studentId',
      pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          transitionsBuilder: _fadeTransition,
          child: LecturerAddGradePage(
            studentId: int.parse(state.pathParameters['studentId']!),
          )),
    ),
    ShellRoute(
        pageBuilder: (context, state, child) => CustomTransitionPage(
              transitionsBuilder: _fadeTransition,
              child: StudentNavbar(page: child, state: state),
            ),
        routes: [
          GoRoute(
            path: RouteNames.studentHome,
            pageBuilder: (context, state) => CustomTransitionPage(
                key: state.pageKey,
                transitionsBuilder: _fadeTransition,
                child: const StudentHomeScreen()),
          ),
          GoRoute(
            path: RouteNames.studentSubject,
            pageBuilder: (context, state) => CustomTransitionPage(
                key: state.pageKey,
                transitionsBuilder: _fadeTransition,
                child: const StudentSubjectScreen()),
          ),
          GoRoute(
            path: RouteNames.studentProfile,
            pageBuilder: (context, state) => CustomTransitionPage(
                key: state.pageKey,
                transitionsBuilder: _fadeTransition,
                child: const StudentProfileScreen()),
          ),
        ]),
  ],
);

Widget _fadeTransition(BuildContext context, Animation<double> animation,
    Animation<double> secondaryAnimation, Widget child) {
  return FadeTransition(
    opacity: animation,
    child: child,
  );
}

Future<String?> _initialRedirect(
    BuildContext context, GoRouterState state) async {
  final authBloc = BlocProvider.of<AuthBloc>(context);

  var state = authBloc.state;

  if (state is AuthAuthenticated) {
    if (state is AuthAdmin) {
      return RouteNames.adminHome;
    } else if (state is AuthLecturer) {
      return RouteNames.lecturerHome;
    } else if (state is AuthStudent) {
      return RouteNames.studentHome;
    }
    throw Exception('Unknown role');
  }
  return null;
}
