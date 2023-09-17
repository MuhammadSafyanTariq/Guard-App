import 'package:flutter/material.dart';

class Invite extends StatefulWidget {
  const Invite({super.key});

  @override
  State<Invite> createState() => _InviteState();
}

class _InviteState extends State<Invite> {
  @override
  Widget build(BuildContext context) {
    double W = MediaQuery.of(context).size.width;
    double H = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
        child: Container(
           padding: EdgeInsets.all(6),
                      constraints: BoxConstraints(
                      minWidth: W*0.95,
                      maxWidth:  W*0.95,
                      minHeight: H*0.8,
                      maxHeight:  H*0.8,
            
                      ),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                          width: 2,
                          style: BorderStyle.solid,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            (20),
                          ),
                        ),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black,
                              blurRadius: 20,
                              spreadRadius: 2.0,
                              offset: Offset(-10, 7)),
                        ],
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.white, Colors.grey, const Color.fromARGB(255, 124, 123, 123)],
                        ),
                      ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.send,
                size: 80,
                color: Colors.green,
              ),
              SizedBox(height: 20),
              Text(
                'Invite',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Invite friends or colleagues.', // Replace with your content
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}