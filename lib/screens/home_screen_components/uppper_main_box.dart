import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class UpperMainBox extends StatelessWidget {
  const UpperMainBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8),
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: 100,
          decoration: const BoxDecoration(
            // borderRadius: BorderRadius.circular(10),
            // color: Colors.black,
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(182, 198, 247, 1),
                offset: Offset(5, 5),
                blurRadius: 20,
                spreadRadius: 10,
              ),
            ],
          ),
          child: Stack(
            children: [
              SvgPicture.asset(
                "assets/svg/front.html",
                fit: BoxFit.cover,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Total Balance",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    Text(
                      "\$ 802.23",
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "View Details",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                        size: 15,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
