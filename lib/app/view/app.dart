// Copyright (c) 2022, Very Good Ventures
// https://price.tracker
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:price_repository/price_repository.dart';
import 'package:price_tracker/l10n/l10n.dart';
import 'package:price_tracker/price/price.dart';

class App extends StatelessWidget {
  const App({
    super.key,
    required PriceRepository priceRepository,
  }) : _priceRepository = priceRepository;

  final PriceRepository _priceRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _priceRepository,
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(color: Color(0xFF13B9FF)),
        colorScheme: ColorScheme.fromSwatch(
          accentColor: const Color(0xFF13B9FF),
        ),
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const PricePage(),
    );
  }
}
