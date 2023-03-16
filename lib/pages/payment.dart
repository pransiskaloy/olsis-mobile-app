import 'package:flutter/material.dart';
import 'package:olsis/widgets/sidebar.dart';

class Payments extends StatefulWidget {
  const Payments({Key? key}) : super(key: key);

  @override
  State<Payments> createState() => _PaymentsState();
}

class _PaymentsState extends State<Payments> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SidebarMenu(),
    );
  }
}
