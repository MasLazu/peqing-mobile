import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:peqing/bloc/auth/auth_bloc.dart';
import 'package:peqing/bloc/lecturer/lecturer_bloc.dart';
import 'package:peqing/bloc/student/student_bloc.dart';
import 'package:peqing/bloc/suject/subject_bloc.dart';
import 'package:peqing/core/theme/app_theme.dart';
import 'package:peqing/data/repositories/auth_repository.dart';
import 'package:peqing/data/repositories/lecturer_repository.dart';
import 'package:peqing/data/repositories/student_repository.dart';
import 'package:peqing/data/repositories/subject_repository.dart';
import 'package:peqing/route/app_route.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialize();
  runApp(const App());
}

Future<void> initialize() async {
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getApplicationDocumentsDirectory(),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize bloc and repository
    var authBloc = AuthBloc();
    var authRepository = AuthRepository(authBloc: authBloc);
    var studentRepository = StudentRepository(authBloc: authBloc);
    var lecturerRepository = LecturerRepository(authBloc: authBloc);
    var subjectRepository = SubjectRepository(authBloc);
    authBloc.setAuthRepository(
      authRepository: authRepository,
      studentRepository: studentRepository,
      lecturerRepository: lecturerRepository,
    );
    var studentBloc = StudentBloc(studentRepository);
    var lecturerBloc = LecturerBloc(lecturerRepository);
    var subjectBloc = SubjectBloc(subjectRepository);

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (context) => authRepository,
        ),
        RepositoryProvider<StudentRepository>(
          create: (context) => studentRepository,
        ),
        RepositoryProvider<LecturerRepository>(
          create: (context) => lecturerRepository,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => authBloc,
          ),
          BlocProvider<StudentBloc>(create: (context) => studentBloc),
          BlocProvider<LecturerBloc>(create: (context) => lecturerBloc),
          BlocProvider<SubjectBloc>(create: (context) => subjectBloc),
        ],
        child: MaterialApp.router(
          title: 'peqing',
          theme: AppTheme().theme,
          themeMode: ThemeMode.light,
          debugShowCheckedModeBanner: false,
          routerConfig: appRoute,
        ),
      ),
    );
  }
}
