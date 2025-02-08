import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jet_framework/helpers/extensions/text_extensions.dart';
import 'package:jet_framework/resources/widgets/jet_button.dart';

mixin OtpTimerMixin {
  var remainingTime = 0.obs; // Remaining time in seconds
  Timer? _timer;

  void startTimer(int ttl) {
    remainingTime.value = ttl;

    _timer?.cancel(); // Cancel existing timer if any
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (remainingTime.value > 0) {
        remainingTime.value--; // Decrement timer
      } else {
        timer.cancel();
      }
    });
  }

  void cancelTimer() {
    _timer?.cancel();
  }
}

class OtpTimerWidget extends StatelessWidget {
  const OtpTimerWidget({
    super.key,
    required this.remainingTime,
    required this.resendOtp,
  });

  final RxInt remainingTime;
  final Function() resendOtp;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Do not receive code?'.tr,
            ).bold(),
            JetButton.text(
              label: remainingTime.value > 0
                  ? '${'Resend code after'.tr} $formattedTime'
                  : 'Resend code'.tr,
              onPressed: remainingTime.value == 0
                  ? () async {
                      await resendOtp();
                    }
                  : null,
            ),
          ],
        ).paddingOnly(
          top: 20,
        );
      },
    );
  }

  String get formattedTime {
    int minutes = remainingTime.value ~/ 60;
    int seconds = remainingTime.value % 60;
    return "$minutes:${seconds.toString().padLeft(2, '0')}"; // Ensures two-digit seconds
  }
}
