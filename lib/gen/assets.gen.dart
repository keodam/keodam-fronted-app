// dart format width=80

/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,directives_ordering,implicit_dynamic_list_literal,unnecessary_import

import 'package:flutter/widgets.dart';

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/apple.png
  AssetGenImage get apple => const AssetGenImage('assets/icons/apple.png');

  /// File path: assets/icons/back.svg
  String get back => 'assets/icons/back.svg';

  /// File path: assets/icons/google.png
  AssetGenImage get google => const AssetGenImage('assets/icons/google.png');

  /// File path: assets/icons/home_logo.png
  AssetGenImage get homeLogo =>
      const AssetGenImage('assets/icons/home_logo.png');

  /// File path: assets/icons/home_nav_feed.svg
  String get homeNavFeed => 'assets/icons/home_nav_feed.svg';

  /// File path: assets/icons/home_nav_matching.svg
  String get homeNavMatching => 'assets/icons/home_nav_matching.svg';

  /// File path: assets/icons/home_nav_mypage.svg
  String get homeNavMypage => 'assets/icons/home_nav_mypage.svg';

  /// File path: assets/icons/home_nav_search.svg
  String get homeNavSearch => 'assets/icons/home_nav_search.svg';

  /// File path: assets/icons/kakao.png
  AssetGenImage get kakao => const AssetGenImage('assets/icons/kakao.png');

  /// File path: assets/icons/mentee.png
  AssetGenImage get mentee => const AssetGenImage('assets/icons/mentee.png');

  /// File path: assets/icons/mento.png
  AssetGenImage get mento => const AssetGenImage('assets/icons/mento.png');

  /// File path: assets/icons/sign_in_logo.png
  AssetGenImage get signInLogoPng =>
      const AssetGenImage('assets/icons/sign_in_logo.png');

  /// File path: assets/icons/sign_in_logo.svg
  String get signInLogoSvg => 'assets/icons/sign_in_logo.svg';

  /// File path: assets/icons/sign_up_profile_accept.png
  AssetGenImage get signUpProfileAccept =>
      const AssetGenImage('assets/icons/sign_up_profile_accept.png');

  /// File path: assets/icons/sign_up_profile_deny.png
  AssetGenImage get signUpProfileDeny =>
      const AssetGenImage('assets/icons/sign_up_profile_deny.png');

  /// List of all assets
  List<dynamic> get values => [
    apple,
    back,
    google,
    homeLogo,
    homeNavFeed,
    homeNavMatching,
    homeNavMypage,
    homeNavSearch,
    kakao,
    mentee,
    mento,
    signInLogoPng,
    signInLogoSvg,
    signUpProfileAccept,
    signUpProfileDeny,
  ];
}

class Assets {
  const Assets._();

  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const AssetGenImage pageRole = AssetGenImage('assets/page_role.png');

  /// List of all assets
  static List<AssetGenImage> get values => [pageRole];
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
    this.animation,
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;
  final AssetGenImageAnimation? animation;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class AssetGenImageAnimation {
  const AssetGenImageAnimation({
    required this.isAnimation,
    required this.duration,
    required this.frames,
  });

  final bool isAnimation;
  final Duration duration;
  final int frames;
}
