import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled5/get_data_bloc/get_data_cubit.dart';
import 'package:untitled5/progress.dart';

import 'datails_page.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

Color myColor = const Color.fromRGBO(170, 74, 50, 1.0);

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _showProgressPage = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5)).then((_) {
      setState(() {
        _showProgressPage = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      GetDataCubit()
        ..getMeals(),
      child: MaterialApp(
        home: _showProgressPage ? ProgressPage() : MyHomePage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List images=['assets/plate2.png','assets/Koshary.jpg','assets/plate3.png','assets/plate4.png'];
    List price=['25','30','80','20'];
    return BlocConsumer<GetDataCubit, GetDataState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: myColor,
          body: Column(
            children: <Widget>[
              SizedBox(height: 50.0),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search for meals',
                    hintStyle: TextStyle(color: Colors.black),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: Icon(Icons.search, color: Colors.black),
                  ),
                ),
              ),
              SizedBox(height: 25.0),
              Padding(
                padding: EdgeInsets.only(left: 40.0),
                child: Row(
                  children: const <Widget>[
                    Text('OUR MEALS',
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25.0)),
                    SizedBox(width: 10.0),
                  ],
                ),
              ),
              SizedBox(height: 40.0),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(75.0)),
                  ),
                  child: ListView(
                    primary: false,
                    padding: EdgeInsets.only(left: 25.0, right: 20.0),
                    children: <Widget>[
                      Padding(
                          padding: const EdgeInsets.only(top: 45.0),
                          child: Container(
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height - 300.0,
                              child:state is GetDataLoadingState?
                            Container(
                              height: 25,
                              width: 25,
                              child: CircularProgressIndicator(),
                            ):
                              ListView.builder(
                                itemCount: 4,
                                  itemBuilder: (context, index) {
                                    return buildFoodItem(
                                        images[index],
                                        context
                                            .read<GetDataCubit>().data.isNotEmpty?
                                        context
                                        .read<GetDataCubit>()
                                        .data[index].name.toString() == "null"
                                        ? "Berry"
                                        : context
                                        .read<GetDataCubit>()
                                        .data[index]
                                        .name
                                        .toString():"barry"

                                        , '\$${price[index]}',index);
                                  },
                              ))

              ),

                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget buildFoodItem(String imgPath, String foodName, String price,int index) {
    return Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
        child: InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      DetailsPage(heroTag: imgPath, foodName: context
                          .read<GetDataCubit>()
                          .data[index]
                          .name
                          .toString(), foodPrice: price,index: index,)
              ));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                    child: Row(
                        children: [
                          Hero(
                              tag: imgPath,
                              child: Image(
                                  image: AssetImage(imgPath),
                                  fit: BoxFit.cover,
                                  height: 75.0,
                                  width: 75.0
                              )
                          ),
                          const SizedBox(width: 10.0),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    foodName,
                                    style: const TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontSize: 17.0,
                                        fontWeight: FontWeight.bold
                                    )
                                ),
                                Text(
                                    price,
                                    style: const TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontSize: 15.0,
                                        color: Colors.grey
                                    )
                                )
                              ]
                          )
                        ]
                    )
                ),

              ],
            )
        ));
  }
}
