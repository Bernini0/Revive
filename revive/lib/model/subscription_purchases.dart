import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:revive/model/purchasable_product.dart';
import 'package:revive/model/store_state.dart';

import '../core/IAPConnection.dart';

const storeKeyConsumable = 'dash_consumable_2k';
const storeKeyUpgrade = 'dash_upgrade_3d';
const storeKeySubscriptionLite = 'lite_plan';
const storeKeySubscriptionPro = "pro_plan";

class SubscriptionPurchases extends ChangeNotifier {
  StoreState storeState = StoreState.loading;
  late StreamSubscription<List<PurchaseDetails>> _subscription;
  List<PurchasableProduct> products = [];

  final iapConnection = IAPConnection.instance;

  SubscriptionPurchases() {
    final purchaseUpdated = iapConnection.purchaseStream;
    _subscription = purchaseUpdated.listen(
      _onPurchaseUpdate,
      onDone: _updateStreamOnDone,
      onError: _updateStreamOnError,
    );
    loadPurchases();
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  Future<void> buy(PurchasableProduct product) async {
    final purchaseParam = PurchaseParam(productDetails: product.productDetails);
    switch (product.id) {
      case storeKeyConsumable:
        await iapConnection.buyConsumable(purchaseParam: purchaseParam);
      case storeKeySubscriptionLite:
      case storeKeyUpgrade:
      case storeKeySubscriptionPro:
        await iapConnection.buyNonConsumable(purchaseParam: purchaseParam);
      default:
        throw ArgumentError.value(
            product.productDetails, '${product.id} is not a known product');
    }
  }

  Future<void> _onPurchaseUpdate(
      List<PurchaseDetails> purchaseDetailsList) async {
    for (var purchaseDetails in purchaseDetailsList) {
      await _handlePurchase(purchaseDetails);
    }
    notifyListeners();
  }

  Future<void> _handlePurchase(PurchaseDetails purchaseDetails) async {
    if (purchaseDetails.status == PurchaseStatus.purchased) {
      switch (purchaseDetails.productID) {
        case storeKeySubscriptionLite:
        case storeKeySubscriptionPro:
          print("haha works, I got all your money suckerrrrr");
      }
    }

    if (purchaseDetails.pendingCompletePurchase) {
      await iapConnection.completePurchase(purchaseDetails);
    }
  }

  void _updateStreamOnDone() {
    _subscription.cancel();
  }

  void _updateStreamOnError(dynamic error) {
    //Handle error here
  }

  Future<void> loadPurchases() async {
    final available = await iapConnection.isAvailable();
    if (!available) {
      storeState = StoreState.notAvailable;
      notifyListeners();
      return;
    }
    const ids = <String>{
      storeKeyConsumable,
      storeKeySubscriptionLite,
      storeKeySubscriptionPro,
      storeKeyUpgrade,
    };
    final response = await iapConnection.queryProductDetails(ids);
    products =
        response.productDetails.map((e) => PurchasableProduct(e)).toList();
    storeState = StoreState.available;
    for (var i in products) {
      print(i.productDetails.title);
    }
    notifyListeners();
  }
}
