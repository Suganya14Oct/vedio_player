import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:vedio_player/model/vedioList_model.dart';

class SecondScreen extends StatefulWidget {

  ///fetching data from the modelclass named movies
  final String movie_details;
  final Movies movies;

  const SecondScreen({Key? key, required this.movie_details, required this.movies}) : super(key: key);


  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {

  ///setting betterplayer controller to view the vedio
  BetterPlayerController? _betterPlayerController;
  GlobalKey _betterPlayerKey = GlobalKey();

  ///initiating the vedio configuration
  @override
  void initState() {
    BetterPlayerConfiguration betterPlayerConfiguration = BetterPlayerConfiguration(
      aspectRatio: 16/9,
      fit: BoxFit.contain,
    );
    ///getting media url from the modelclass
    BetterPlayerDataSource dataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      widget.movies.media_url!
    );
    _betterPlayerController = BetterPlayerController(betterPlayerConfiguration);
    _betterPlayerController!.setupDataSource(dataSource);
    _betterPlayerController!.setBetterPlayerGlobalKey(_betterPlayerKey);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: ListView(
        children: [
          Stack(
            children: [
              ///vedio design
              AspectRatio(
                aspectRatio: 16/9,
                child: BetterPlayer(key: _betterPlayerKey,controller: _betterPlayerController!,),
              ),
            ],
          ),
          SizedBox(height: 20.0,),
          MovieDetailsHeaderwithPoster(movie: widget.movies),
          HorizontalLine(),
          MovieDetailsCast(movies: widget.movies),
          HorizontalLine(),
          MovieDetailsExtraPosters(posters: widget.movies.images!.toList(),)
        ],
      ),
    );
  }
}


///getting movie images from the modelclass
class MovieDetailsHeaderwithPoster extends StatelessWidget {

  final Movies movie;

  const MovieDetailsHeaderwithPoster({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          MoviePoster(poster:movie.images![0].toString()),
          SizedBox(width: 16),
          Expanded(
            child: MovieDetailsHeader(movie:movie),
          )
        ],
      ),
    );
  }
}

///getting movie poster images from the modelclass
class MoviePoster extends StatelessWidget {

  final String poster;

  const MoviePoster({Key? key, required this.poster}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var borderRadius = BorderRadius.all(Radius.circular(10.0));
    return Card(
      child: ClipRRect(
        borderRadius: borderRadius,
        child: Container(
          width: MediaQuery.of(context).size.width / 4,
          height: 160,
          decoration: BoxDecoration(
              image: DecorationImage(image: NetworkImage(poster),
                  fit: BoxFit.cover
              )
          ),
        ),
      ),
    );
  }
}

///getting all the details about the specific data

class MovieDetailsHeader extends StatelessWidget {

  final Movies movie;

  const MovieDetailsHeader({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("${movie.year} . ${movie.genre}".toUpperCase(),
          style: TextStyle(fontWeight: FontWeight.w400,
              color: Colors.cyan),),
        Text(movie.title.toString(),style: TextStyle(fontWeight: FontWeight.w500,fontSize: 30.0),),
        Text.rich(TextSpan(style: TextStyle(
            fontSize: 12,fontWeight: FontWeight.w300
        ),children: [
          TextSpan(
              text: movie.plot
          ),
          TextSpan(text: "more...",style: TextStyle(color: Colors.indigoAccent))
        ]))
      ],
    );
  }
}

///getting details of the specific gestured movie

class MovieDetailsCast extends StatelessWidget {

  final Movies movies;

  const MovieDetailsCast({Key? key, required this.movies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          MovieField(field: "Cast", value: movies.actors.toString()),
          MovieField(field: "Directors", value: movies.director.toString()),
          MovieField(field: "Awards", value: movies.awards.toString(),)
        ],
      ),
    );
  }
}

class MovieField extends StatelessWidget {

  final String field;
  final String value;

  const MovieField({Key? key, required this.field, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("$field : ",style: TextStyle(
            color: Colors.black38,
            fontSize: 12, fontWeight: FontWeight.w300
        ),),
        Expanded(child: Text(value,style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.w300),))
      ],
    );
  }
}

class HorizontalLine extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 16.0),
      child: Container(
        height: 0.5,
        color: Colors.grey,
      ),
    );
  }
}


///setting more movie posters
class MovieDetailsExtraPosters extends StatelessWidget {

  final List<String> posters;

  const MovieDetailsExtraPosters({Key? key, required this.posters}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Text("More Movie Posters".toUpperCase(),
            style: TextStyle(fontSize: 14,color: Colors.black26),),
        ),
        Container(
          height: 170,
          padding: EdgeInsets.symmetric(vertical: 16),
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) => SizedBox(width: 8),
              itemCount: posters.length,
              itemBuilder: (context, index) => ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                child: Container(
                  width: MediaQuery.of(context).size.width / 4,
                  height: 160,
                  decoration: BoxDecoration(
                      image: DecorationImage(image: NetworkImage(posters[index]),
                          fit: BoxFit.cover)
                  ),
                ),
              )
          ),
        )
      ],
    );
  }
}
