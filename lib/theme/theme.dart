import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui';
part 'palette.dart';

//font sizes
const LargeTextSize = 26.0;
const MediumTextSize = 20.0;
const Body1TextSize = 16.0;
const Body2TextSize = 14.0;
const CaptionTextSize = 12.0;
const OverlineTextSize = 10.0;

//font families
const String BodyFont = 'DMSans';
const String HeadingFont = 'PlayfairDisplay';

//text styles
const TitleStyleBlack = TextStyle(
    fontFamily: BodyFont,
    fontWeight: FontWeight.bold,
    fontSize: 18.0,
    color: GreyD);

const HeaderStyleGrey = TextStyle(
    fontFamily: BodyFont,
    fontWeight: FontWeight.bold,
    fontSize: 16.0,
    color: GreyC);

const HeaderStyleBlack = TextStyle(
    fontFamily: BodyFont,
    fontWeight: FontWeight.bold,
    fontSize: 16.0,
    color: GreyD);

const HeaderStyleWhite = TextStyle(
    fontFamily: BodyFont,
    fontWeight: FontWeight.bold,
    fontSize: 16.0,
    color: White);

const SectionHeaderStyleGrey = TextStyle(
    fontFamily: BodyFont,
    fontWeight: FontWeight.w500,
    fontSize: 14.0,
    color: GreyC);

const SectionTitleStyleGrey = TextStyle(
    fontFamily: BodyFont,
    fontWeight: FontWeight.w500,
    fontSize: 18.0,
    color: GreyC);

const SectionTitleStyleOrange = TextStyle(
    fontFamily: BodyFont,
    fontWeight: FontWeight.w500,
    fontSize: 14.0,
    color: BivatecOrange);

const ErrorTextStyle = TextStyle(
  fontFamily: BodyFont,
  fontWeight: FontWeight.w500,
  fontSize: 14,
  color: GreyB,
  letterSpacing: 0.3,
);
