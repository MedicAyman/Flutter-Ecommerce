import 'package:ecommerce_app/src/features/account/account_screen.dart';
import 'package:ecommerce_app/src/features/checkout/checkout_screen.dart';
import 'package:ecommerce_app/src/features/leave_review_page/leave_review_screen.dart';
import 'package:ecommerce_app/src/features/not_found/not_found_screen.dart';
import 'package:ecommerce_app/src/features/orders_list/orders_list_screen.dart';
import 'package:ecommerce_app/src/features/product_page/product_screen.dart';
import 'package:ecommerce_app/src/features/products_list/products_list_screen.dart';
import 'package:ecommerce_app/src/features/shopping_cart/shopping_cart_screen.dart';
import 'package:ecommerce_app/src/features/sign_in/email_password_sign_in_screen.dart';
import 'package:ecommerce_app/src/features/sign_in/email_password_sign_in_state.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum AppRoutes {
  home,
  product,
  cart,
  orders,
  account,
  signIn,
  leaveReview,
  checkout
}

final goRouter = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: false,
  routes: [
    GoRoute(
      path: '/',
      name: AppRoutes.home.name,
      builder: (context, state) => const ProductsListScreen(),
      routes: [
        GoRoute(
            path: 'product/:id',
            name: AppRoutes.product.name,
            builder: (context, state) {
              final productId = state.params['id']!;
              return ProductScreen(productId: productId);
            },
            routes: [
              GoRoute(
                path: 'leaveReview',
                name: AppRoutes.leaveReview.name,
                pageBuilder: (context, state) {
                  final productId = state.params['id']!;
                  return MaterialPage(
                      key: state.pageKey,
                      fullscreenDialog: true,
                      child: LeaveReviewScreen(productId: productId));
                },
              )
            ]),
        GoRoute(
            path: 'cart',
            name: AppRoutes.cart.name,
            //builder: (context, state) => const ShoppingCartScreen(),
            pageBuilder: (context, state) => MaterialPage(
                  key: state.pageKey,
                  child: const ShoppingCartScreen(),
                  fullscreenDialog: true,
                ),
            routes: [
              GoRoute(
                path: 'checkout',
                name: AppRoutes.checkout.name,
                pageBuilder: (context, state) => MaterialPage(
                  key: state.pageKey,
                  child: const CheckoutScreen(),
                  fullscreenDialog: true,
                ),
              ),
            ]),
        GoRoute(
          path: 'orders',
          name: AppRoutes.orders.name,
          pageBuilder: (context, state) => MaterialPage(
              key: state.pageKey,
              child: const OrdersListScreen(),
              fullscreenDialog: true),
        ),
        GoRoute(
          path: 'account',
          name: AppRoutes.account.name,
          //builder: (context, state) => const ShoppingCartScreen(),
          pageBuilder: (context, state) => MaterialPage(
              key: state.pageKey,
              child: const AccountScreen(),
              fullscreenDialog: true),
        ),
        GoRoute(
          path: 'signIn',
          name: AppRoutes.signIn.name,
          //builder: (context, state) => const ShoppingCartScreen(),
          pageBuilder: (context, state) => MaterialPage(
              key: state.pageKey,
              child: const EmailPasswordSignInScreen(
                  formType: EmailPasswordSignInFormType.signIn),
              fullscreenDialog: true),
        ),
      ],
    )
  ],
  errorBuilder: (context, state) => const NotFoundScreen(),
);
