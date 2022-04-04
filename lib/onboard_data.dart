import 'package:flutter/material.dart';
import 'package:njawani/constant.dart';

class OnboardingItem {
  final String title;
  final String subtitle;
  final String image;
  final Color color;

  const OnboardingItem({
    required this.title,
    required this.subtitle,
    required this.image,
    required this.color,
  });
}

class OnboardingItems {
  static List<OnboardingItem> loadOnboardingItem() {
    const fi = <OnboardingItem>[
      OnboardingItem(
        title: "Jadilah Berbudaya",
        subtitle:
            "Mari bersama belajar Aksara Jawa untuk menjadi generasi muda masa depan yang berbudaya",
        image: "assets/img/onboard1.png",
        color: prblue,
      ),
      OnboardingItem(
        title: "Fleksibel",
        subtitle:
            "Yeay! dengan Njawani, kamu bisa belajar di manapun dan kapanpun",
        image: "assets/img/onboard2.png",
        color: prred,
      ),
      OnboardingItem(
        title: "Katakan Halo",
        subtitle:
            "Njawani menghubungkanmu dengan pemuda-pemuda yang peduli dengan budaya",
        image: "assets/img/onboard3.png",
        color: prgreen,
      ),
    ];
    return fi;
  }
}
