import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_scaffold/account/coupons_page.dart';
import 'package:flutter_scaffold/auth/auth.dart';
import 'package:flutter_scaffold/blocks/auth_block.dart';
import 'package:flutter_scaffold/cart.dart';
import 'package:flutter_scaffold/categorise.dart';
import 'package:flutter_scaffold/checkout/checkout.dart';
import 'package:flutter_scaffold/checkout/shipping_address.dart';
import 'package:flutter_scaffold/home/home.dart';
import 'package:flutter_scaffold/localizations.dart';
import 'package:flutter_scaffold/product_detail.dart';
import 'package:flutter_scaffold/settings.dart';
import 'package:flutter_scaffold/shop/shop.dart';
import 'package:flutter_scaffold/wallet_page.dart';
import 'package:flutter_scaffold/wishlist.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final Locale locale = Locale('en');
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider<AuthBlock>.value(value: AuthBlock())],
    child: MaterialApp(
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: [Locale('en'), Locale('ar')],
      locale: locale,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Color(0xffF07539),
          accentColor: Color(0xff00ada7),
          fontFamily: locale.languageCode == 'ar' ? 'Dubai' : 'Lato'),
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => Home(),
        '/auth': (BuildContext context) => Auth(),
        '/shop': (BuildContext context) => Shop(minPrice: 0.0,maxPrice: 0.0,toFilter: false,),
        '/categorise': (BuildContext context) => Categorise(),
        '/wishlist': (BuildContext context) => WishList(),
        '/cart': (BuildContext context) => CartList(),
        '/settings': (BuildContext context) => Settings(),
        '/products': (BuildContext context) => Products(productId: 1,),
        '/wallet':(BuildContext context) => WalletPage(),
        '/coupons':(BuildContext context) => CouponPage(),
        '/shipping_address':(BuildContext context) => ShippingAddressPage(),
        '/checkout':(BuildContext context) => CheckoutPage(),
      },
    ),
  ));
}
