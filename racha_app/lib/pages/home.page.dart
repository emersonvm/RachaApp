import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:racha_app/components/user_tile.dart';
import 'package:flutter/services.dart';
import 'package:racha_app/models/auth.dart';
import 'package:racha_app/utils/app_routes.dart';

enum FilterOptions {
  logout,
}

class HomePage extends StatefulWidget with ChangeNotifier {
  _HomePageState createState() => _HomePageState();
}

class BNBCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..color = Colors.lightGreen
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0, 0); // Start
    path.quadraticBezierTo(size.width * 0.20, 0, size.width * 0.35, 0);
    path.quadraticBezierTo(size.width * 0.40, 0, size.width * 0.40, 20);
    path.arcToPoint(Offset(size.width * 0.60, 20),
        radius: Radius.circular(20.0), clockwise: false);
    path.quadraticBezierTo(size.width * 0.60, 0, size.width * 0.65, 0);
    path.quadraticBezierTo(size.width * 0.80, 0, size.width, 0); //end
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 20);
    canvas.drawShadow(path, Colors.black, 5, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  setBottomBarIndex(index) {
    setState(() {
      currentIndex = index;
    });
  }

//------------------------------------------------------------------------------
  @override
  Widget _body() {
    //Atributo privado inicia com _
    // NAVIGATION BAR
    final Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Positioned(
          bottom: 0,
          left: 0,
          child: Container(
            width: size.width,
            height: 80,
            child: Stack(
              clipBehavior: Clip.antiAlias,
              children: [
                CustomPaint(
                  size: Size(size.width, 80),
                  painter: BNBCustomPainter(),
                ),
                Center(
                  heightFactor: 0.6,
                  child: FloatingActionButton(
                      backgroundColor: Colors.lightGreen,
                      child: Icon(Icons.add_circle),
                      elevation: 0.1,
                      onPressed: (
                          //ADICIONAR EVENTO NA HOME PAGE
                          ) {}),
                ),
                Container(
                  width: size.width,
                  height: 80,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.home,
                          color: currentIndex == 0
                              ? Colors.black
                              : Colors.grey.shade500,
                        ),
                        onPressed: () {
                          setBottomBarIndex(0);
                        },
                        splashColor: Colors.white,
                      ),
                      IconButton(
                          icon: Icon(
                            Icons.event_available,
                            color: currentIndex == 1
                                ? Colors.black
                                : Colors.grey.shade500,
                          ),
                          onPressed: () {
                            Navigator.of(context).pushNamed('/participantes');
                            setBottomBarIndex(1);
                          }),
                      Container(
                        width: size.width * 0.20,
                      ),
                      IconButton(
                          icon: Icon(
                            Icons.notifications,
                            color: currentIndex == 2
                                ? Colors.black
                                : Colors.grey.shade500,
                          ),
                          onPressed: () {
                            setBottomBarIndex(2);
                          }),
                      IconButton(
                          icon: Icon(
                            Icons.person,
                            color: currentIndex == 3
                                ? Colors.black
                                : Colors.grey.shade500,
                          ),
                          onPressed: () {
                            setBottomBarIndex(3);
                          }),
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  //-----------------BACKGROUND---------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Racha App',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 30,
          ),
        ),
        actions: [
          PopupMenuButton(
            icon: Icon(
              Icons.exit_to_app,
              color: Colors.white,
              size: 30,
            ),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text(
                  'Sair',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                value: FilterOptions.logout,
              ),
            ],
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.logout) {
                  Provider.of<Auth>(
                    context,
                    listen: false,
                  ).logout();

                  Navigator.of(context).pushReplacementNamed(
                    AppRoutes.AUTH_OR_HOME,
                  );
                }
              });
            },
          ),
        ],
        backgroundColor: Colors.lightGreen,
      ),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(40),
            constraints: BoxConstraints.expand(height: 200),
            decoration: BoxDecoration(
                gradient: new LinearGradient(
                    colors: [Colors.orangeAccent, Colors.lightGreenAccent],
                    begin: const FractionalOffset(2.0, 1.0),
                    end: const FractionalOffset(0.2, 0.2),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(0))),
          ),
          // ListView.builder(
          //   scrollDirection: Axis.vertical,
          //   itemCount: users.length,
          //   itemBuilder: (ctx, i) => UserTile(users.values.elementAt(i)),
          // ),
          _body(),
        ],
      ),
    );
  }
  // FIM BACKGROUND -----------------------------

}
