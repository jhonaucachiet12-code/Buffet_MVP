// ignore: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../presentation/screens/login_screen.dart';
import '../../presentation/screens/home_screen.dart';
import '../../presentation/screens/admin/admin_login_screen.dart';
import '../../presentation/screens/admin/admin_layout.dart';
import '../../presentation/screens/admin/admin_orders_screen.dart';
import '../../presentation/screens/admin/admin_products_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) =>  LoginScreen()),
      GoRoute(path: '/tienda', builder: (context, state) =>  HomeScreen()),
      GoRoute(path: '/admin', builder: (context, state) => const AdminLoginScreen()),
      
      // Panel Privado con Layout persistente (menú arriba o abajo)
      ShellRoute(
        builder: (context, state, child) => AdminLayout(child: child, currentRoute: state.uri.toString()),
        routes: [
          GoRoute(path: '/admin/panel', builder: (context, state) => const AdminOrdersScreen()),
          GoRoute(path: '/admin/productos', builder: (context, state) => const AdminProductsScreen()),
        ],
      ),
    ],
  );
}