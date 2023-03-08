// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:in_app_purchase_platform_interface/in_app_purchase_platform_interface.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';

import 'fakes/fake_storekit_platform.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final FakeStoreKitPlatform fakeStoreKitPlatform = FakeStoreKitPlatform();

  setUpAll(() {
    _ambiguate(TestDefaultBinaryMessengerBinding.instance)!
        .defaultBinaryMessenger
        .setMockMethodCallHandler(
            SystemChannels.platform, fakeStoreKitPlatform.onMethodCall);
  });

  group('present code redemption sheet', () {
    test('null', () async {
      expect(
          InAppPurchaseStoreKitPlatformAddition().presentCodeRedemptionSheet(),
          completes);
    });
  });

  group('refresh receipt data', () {
    test('should refresh receipt data', () async {
      final PurchaseVerificationData? receiptData =
          await InAppPurchaseStoreKitPlatformAddition()
              .refreshPurchaseVerificationData();
      expect(receiptData, isNotNull);
      expect(receiptData!.source, kIAPSource);
      expect(receiptData.localVerificationData, 'refreshed receipt data');
      expect(receiptData.serverVerificationData, 'refreshed receipt data');
    });
  });
}

/// This allows a value of type T or T? to be treated as a value of type T?.
///
/// We use this so that APIs that have become non-nullable can still be used
/// with `!` and `?` on the stable branch.
T? _ambiguate<T>(T? value) => value;