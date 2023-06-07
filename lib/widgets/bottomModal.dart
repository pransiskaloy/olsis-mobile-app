import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ShowBottomModal {
  void bottomModal(BuildContext context, lottie, title, info) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          child: Container(
            padding: const EdgeInsets.only(top: 35, left: 20, right: 20),
            height: 330,
            color: Colors.white,
            child: Column(
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Lottie.asset(lottie, height: 210, width: 210),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  info,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.red),
                ),
                // ListTile(
                //   leading: Icon(Icons.share),
                //   title: Text(str),
                //   onTap: () {
                //     // Handle the share action
                //     Navigator.pop(context);
                //   },
                // ),
                // ListTile(
                //   leading: Icon(Icons.delete),
                //   title: Text(str),
                //   onTap: () {
                //     // Handle the delete action
                //     Navigator.pop(context);
                //   },
                // ),
              ],
            ),
          ),
        );
      },
    );
  }
}
