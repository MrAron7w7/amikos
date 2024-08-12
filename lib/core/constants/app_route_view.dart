import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:twitter_clone/features/models/post.dart';

import '/features/services/auth/auth_gate.dart';
import '/features/views/views.dart';

final appRoute = GoRouter(
  initialLocation: '/',
  routes: <RouteBase>[
    GoRoute(
      path: '/${LoginView.name}',
      builder: (context, state) => const LoginView(),
    ),
    GoRoute(
      path: '/${RegisterView.name}',
      builder: (context, state) => const RegisterView(),
    ),
    GoRoute(
      path: '/${HomeView.name}',
      builder: (context, state) => const HomeView(),
    ),
    GoRoute(
      path: '/${ProfileView.name}/:uid',
      builder: (context, state) {
        final uid = state.pathParameters['uid']!;
        return ProfileView(uid);
      },
    ),
    GoRoute(
      path: '/${SearchView.name}',
      builder: (context, state) => const SearchView(),
    ),
    GoRoute(
      path: '/${SettingView.name}',
      builder: (context, state) => const SettingView(),
    ),
    GoRoute(
      path: '/',
      builder: (context, state) => const AuthGate(),
    ),
    GoRoute(
      path: '/${PostView.name}/:post',
      builder: (context, state) {
        final post = state.extra as Post?;
        if (post == null) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Error"),
            ),
            body: const Center(
              child: Text("Post data not available."),
            ),
          );
        }

        return PostView(post: post);
      },
    ),
  ],
);
