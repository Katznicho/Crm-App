part of 'theme.dart';

///main colors
const Color BivatecGreen = Color(0xFF2e7d32);
const Color BivatecOrange = Color(0xffffab00);
const Color BivatecBlack = Color(0xff012503);

//colors
const Color SurfaceA = Color(0xff0F0F0F);
const Color SurfaceB = Color(0xff171717);
const Color SurfaceC = Color(0xff2A2A2A);
const Color SurfaceD = Color(0xff303030);

//sheds of grey
const Color GreyA = Color(0xffDDDEDD);
const Color GreyB = Color(0xff929292);
const Color GreyC = Color(0xff767676);
const Color GreyD = Color(0xff3D3D3D);

//sheds of blue
const Color BlueA = Color(0xfff2f4f8);

//others
const Color DangerColor = Color(0xffFF4C3D);
const Color Turquoise = Color(0xFF219f9c);

//faint
const Color FaintBlueDeeper = Color(0xFFFBFEFF);

///Theme
const Color PrimaryColor = BivatecGreen; //used for App Bar and as main color
const Color SecondaryColor = BivatecGreen; //used for page icons
const Color TertiaryColor = BivatecGreen; //used for menu icons
const Color AccentColor = BivatecOrange; //used in some appearances
const Color TextColor = BivatecBlack;

const Color White = Color(0xFFF0F2F5);

const Color Black = BivatecBlack;

const Color RoyalBlue = Color(0xFF1777F2);

//gradients
const List<Color> CombinationBlue = [Color(0xFF26428b), Color(0xFF7793cb)];
const List<Color> CombinationGreen = [Color(0xFF20c14f), Color(0xFF2e7d32)];
const List<Color> CombinationGreenDarker = [
  Color(0xFF4F8429),
  Color(0xFF1C6120)
];
const List<Color> CombinationOrange = [Color(0xFFEDA704), Color(0xFFEF8900)];
const List<Color> CombinationRed = [Color(0xFFff0000), Color(0xFFff0000)];

const LinearGradient createRoomGradient = LinearGradient(
  colors: [Color(0xFF496AE1), Color(0xFFCE48B1)],
);

const Color online = Color(0xFF4BCB1F);

const LinearGradient storyGradient = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [Colors.transparent, Colors.black26],
);

const pieChartColors = [
  Color(0xffFFA500), // Orange
  Color(0xff008000), // Green
  Color(0xff3ACD48), // Light Green
  Color(0xffD13E29), // Red
  Color(0xff4186F5), // Blue
  Color(0xff851B3D), // Maroon

  Color(0xffFF1493), // Deep Pink
  Color(0xFF219f9c), // Turquoise
  Color(0xffFF00FF), // Purple
  Color(0xff00FFFF), // Cyan
];

//Material Color Primary
MaterialColor primaryColor = const MaterialColor(0xFF2e7d32, <int, Color>{
  50: Color.fromRGBO(46, 135, 50, .1),
  100: Color.fromRGBO(46, 135, 50, .2),
  200: Color.fromRGBO(46, 135, 50, .3),
  300: Color.fromRGBO(46, 135, 50, .4),
  400: Color.fromRGBO(46, 135, 50, .5),
  500: Color.fromRGBO(46, 135, 50, .6),
  600: Color.fromRGBO(46, 135, 50, .7),
  700: Color.fromRGBO(46, 135, 50, .8),
  800: Color.fromRGBO(46, 135, 50, .9),
  900: Color.fromRGBO(46, 135, 50, 1),
});
