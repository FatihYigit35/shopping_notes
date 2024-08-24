import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

AppLocalizations get appLocalizations =>
    _appLocalizations!; // helper function to avoid typing '!' all the time
AppLocalizations? _appLocalizations; // global variable

class AppTranslations {
  static init(BuildContext context) {
    _appLocalizations = AppLocalizations.of(context);
  }
}
