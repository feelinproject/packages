// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:go_router/go_router.dart';

@TypedGoRoute<RequiredExtraValueRoute>(path: '/default-value-route')
class RequiredExtraValueRoute extends GoRouteData {
  RequiredExtraValueRoute({required this.$extra});
  final int $extra;
}
