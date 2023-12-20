import 'package:flutter/material.dart';
import 'package:vedio_player/vedio_list_screen/first_screen.dart';

class welcomeScreen extends StatefulWidget {
  const welcomeScreen({super.key});

  @override
  State<welcomeScreen> createState() => _welcomeScreenState();
}

class _welcomeScreenState extends State<welcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Color(0xffB81736),
                  Color(0xff281537),
                ]
            )
        ),
        child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 200.0,left: 30),
                child: Text('Developed by Suganya Murugan',style: TextStyle(
                    fontSize: 40,
                    color: Colors.white
                ),),
              ),
              const SizedBox(
                height: 110,
              ),
              const Text('Click below to proceed',style: TextStyle(
                  fontSize: 25,
                  color: Colors.white
              ),),
              const SizedBox(height: 30,),
              ///navigating to the first page
              GestureDetector(
                onTap: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) =>  FirstScreen()));
                },
                child: Container(
                  height: 53,
                  width: 320,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.white),
                  ),
                  child: const Center(child: Text('Move In',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black
                    ),),),
                ),
              ),
              const SizedBox(height: 30,),
              const SizedBox(height: 80,),
              const Text('Login with Social Media',style: TextStyle(
                  fontSize: 17,
                  color: Colors.white
              ),),//
              const SizedBox(height: 12,),
              Container(
                height: 30,
                width: 250,
                child: Image.asset("assets/social.jpg"),
              ),
            ]
        ),
      ),

    );
  }
}
