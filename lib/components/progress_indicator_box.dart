
import 'package:flutter/material.dart';

import '../utils/widget_functions.dart';

class ProgressIndicatorBox extends StatelessWidget {
  const ProgressIndicatorBox({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: DeviceSize.width,
      height: DeviceSize.height,
      color: Colors.black.withOpacity(0.2),
      child: Center(
        child: Container(
          width: 180,
          height: 110,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(),
                addVerticalSpace(12),
                const Text("... aguarde")
              ],
            ),
          ),
        ),
      ),
    );
  }
}