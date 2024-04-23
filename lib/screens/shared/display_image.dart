import 'dart:ffi';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';

import '../../Constants.dart';

class DisplayImage{
  static Widget display({
    required BuildContext context,
    required String? url,
    String? defaultImage,
    double? width,
    double? height,
  }){
    if (url == null){
      return Image.asset(defaultImage ?? ProjectPaths.profilePlaceholderImage,
        height: height ?? MediaQuery.of(context).size.height,
        width: width ?? MediaQuery.of(context).size.width,
        fit: BoxFit.cover,);
    }

    return CachedNetworkImage(imageUrl: url,
        height: height ?? MediaQuery.of(context).size.height,
      width: width ?? MediaQuery.of(context).size.width,
      fit: BoxFit.cover,
      placeholder: (_, __) => const CupertinoActivityIndicator(),
      errorWidget: (_, __, ___) => Image.asset(defaultImage ?? ProjectPaths.profilePlaceholderImage),
    );
  }
}