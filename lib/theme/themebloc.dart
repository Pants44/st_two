import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:st_two/theme/colors.dart';

enum ThemeEvent {li, da}

class ThemeBloc extends Bloc<ThemeEvent, ThemeData>{
  @override
  ThemeData get initialState => ThemeData(
    brightness: Brightness.dark,
    buttonColor: colorSTBlue,
    accentColor: colorSTBlue,
    backgroundColor: colorSTbg,
    canvasColor: colorSTbg,
    primaryColor: colorSTother,
    bottomAppBarColor: colorSTother,
  );

  @override
  Stream<ThemeData> mapEventToState(ThemeEvent event) async* {
    switch (event) {
      case ThemeEvent.da:
        yield ThemeData(
          brightness: Brightness.dark,
          buttonColor: colorSTBlue,
          accentColor: colorSTBlue,
          backgroundColor: colorSTbg,
          canvasColor: colorSTbg,
          primaryColor: colorSTother,
          bottomAppBarColor: colorSTother,
        );
        break;
      case ThemeEvent.li:
        yield ThemeData(
          brightness: Brightness.light,
          buttonColor: colorSTBlue,
          accentColor: colorSTBlue,
          backgroundColor: colorSTbg,
          canvasColor: colorSTbg,
          primaryColor: colorSTother,
          bottomAppBarColor: colorSTother,
        );
        break;
    }
  }
}