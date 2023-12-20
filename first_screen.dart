import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:vedio_player/model/vedioList_model.dart';
import 'package:vedio_player/vedio_list_screen/second_screen.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {

  @override
  Widget build(BuildContext context) {
    final List<Movies> movieList = Movies.getMovies();
    return Scaffold(
      ///setting app bar
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text("Vedio Player",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                    Color(0xffB81736),
                    Color(0xff281537)
                  ])
          ),
        ),
      ),
      backgroundColor: Color(0xff281525),
      ///listview builder to list the vedios
      body: ListView.builder(
          itemCount: movieList.length,
          itemBuilder: (BuildContext context, int index){
            return Stack(children: [
              movieCard(movieList[index], context),
              Positioned(
                  top: 10.0,
                  child: movieImage(movieList[index].images![0])),
            ], );
          }),
    );
  }
  ///creating all the thumbnail details
  Widget movieCard(Movies movie, BuildContext context){
    return InkWell(
      child: Container(
        margin: EdgeInsets.only(left: 60),
        width: MediaQuery.of(context).size.width,
        height: 120.0,
        child: Card(
          color: Colors.black45,
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0,bottom: 8.0,left: 60,right: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(movie.title.toString(),style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0,
                          color: Colors.white
                      ),),
                    ),
                    Text("Rating: ${movie.imdbRating} / 10",style: TextStyle(
                        fontSize: 13.0,
                        color: Colors.grey
                    ),)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Released: ${movie.released}",style: TextStyle(
                        fontSize: 13.0,
                        color: Colors.grey
                    ),),
                    Text(movie.runtime.toString(),style: TextStyle(
                        fontSize: 13.0,
                        color: Colors.grey
                    ),),
                    Text(movie.rated.toString(),style: TextStyle(
                        fontSize: 13.0,
                        color: Colors.grey
                    ),)
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      ///navigating to nextpage
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => SecondScreen(movie_details: movie.title.toString(),
          movies: movie,)));
      },
    );
  }
  ///setting the image thumbnail inside the circle
  Widget movieImage(String imageUrl){
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
              image: NetworkImage(imageUrl ?? "https://images-na.ssl-images-amazon.com/images/M/MV5BMTc0NzAxODAyMl5BMl5BanBnXkFtZTgwMDg0MzQ4MDE@._V1_SX1500_CR0,0,1500,999_AL_.jpg"),
              fit: BoxFit.cover
          )
      ),
    );
  }
}
