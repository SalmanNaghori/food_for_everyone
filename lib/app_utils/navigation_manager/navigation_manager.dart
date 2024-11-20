import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_for_everyone/app_utils/basic_import.dart';

Future<dynamic> navigateToPageAndRemoveAllPage(Widget routePage,
    {Widget? currentWidget}) {
  return Navigator.of(GlobalVariable.appContext).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => routePage), (route) => false);
}

Future<dynamic> navigateToPageAndRemoveAllPageAnim(Widget routePage,
    {Widget? currentWidget}) {
  return Navigator.of(GlobalVariable.appContext)
      .pushAndRemoveUntil(_createRoute(routePage), (route) => false);
}

Future<dynamic> navigateToPageAnim(Widget routePage, {Widget? currentWidget}) {
  try {
    FocusManager.instance.primaryFocus!.unfocus();
  } catch (e) {
    //  FirebaseCrashlytics.instance.recordError(e, s);
  }
  return Platform.isIOS
      ? Navigator.push(
          GlobalVariable.appContext,
          CupertinoPageRoute(builder: (context) => routePage),
        )
      : Navigator.push(
          GlobalVariable.appContext,
          _createRoute(routePage),
        );
}

Future<dynamic> navigateToPage(Widget routePage, {Widget? currentWidget}) {
  try {
    FocusManager.instance.primaryFocus!.unfocus();
  } catch (e) {
    //  FirebaseCrashlytics.instance.recordError(e, s);
  }
  return Navigator.push(
    GlobalVariable.appContext,
    CupertinoPageRoute(builder: (context) => routePage),
  );
}

Future<dynamic> navigateWithMaterialToPage(Widget routePage,
    {Widget? currentWidget}) {
  try {
    FocusManager.instance.primaryFocus!.unfocus();
  } catch (e) {
    //  FirebaseCrashlytics.instance.recordError(e, s);
  }
  return Navigator.push(
    GlobalVariable.appContext,
    MaterialPageRoute(builder: (context) => routePage),
  );
}

Future<dynamic> navigateToPageAndRemoveCurrentPage(Widget routePage,
    {Widget? currentWidget}) {
  return Navigator.pushReplacement(
    GlobalVariable.appContext,
    CupertinoPageRoute(builder: (context) => routePage),
  );
}

class EnterExitRoute extends PageRouteBuilder {
  final Widget? enterPage;
  final Widget? exitPage;

  EnterExitRoute({this.exitPage, this.enterPage})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              enterPage!,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              Stack(
            children: <Widget>[
              SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0.0, 0.0),
                  end: const Offset(-1.0, 0.0),
                ).animate(animation),
                child: exitPage,
              ),
              SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(1.0, 0.0),
                  end: Offset.zero,
                ).animate(animation),
                child: enterPage,
              )
            ],
          ),
        );
}

Route _createRoute(Widget screen) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => screen,
    transitionDuration: const Duration(milliseconds: 250),
    reverseTransitionDuration: const Duration(milliseconds: 250),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = 0.0;
      const end = 1.0;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return FadeTransition(
        opacity: animation.drive(tween),
        child: child,
      );
    },
  );
}
