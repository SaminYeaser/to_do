import 'package:flutter/material.dart';
import 'package:todo/app/core/value/colors.dart';
import 'package:todo/app/core/value/icons.dart';

List<Icon> getIcon(){
  return const[
    Icon(Icons.person,color: purple,),
    Icon(Icons.work,color: pink,),
    Icon(Icons.movie,color: green,),
    Icon(Icons.sports,color: yellow,),
    Icon(Icons.wallet_travel_rounded,color: deepPink,),
    Icon(Icons.shop,color: lightBlue,),
  ];
}