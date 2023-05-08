
import 'package:flutter/material.dart';
import 'package:navbar_router/navbar_router.dart';
import 'package:simpletodo/product_comments.dart';

class ProductDetail extends StatelessWidget {
  final String id;
  const ProductDetail({Key? key, this.id = '1'}) : super(key: key);
  static const String route = '/products/detail';
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    final argsId = args['id'];
    return Scaffold(
      appBar: AppBar(
        title: Text('Product $argsId'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('My AWESOME Product $argsId'),
          const Center(
            child: Placeholder(
              fallbackHeight: 200,
              fallbackWidth: 300,
            ),
          ),
          TextButton(
              onPressed: () {
                NavbarNotifier.hideBottomNavBar = false;
                navigate(context, ProductComments.route,
                    isRootNavigator: false,
                    arguments: {'id': argsId.toString()});
              },
              child: const Text('show comments'))
        ],
      ),
    );
  }
}