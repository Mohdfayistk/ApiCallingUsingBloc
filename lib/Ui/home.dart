import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled10/Repository/modelclass/AnimeModel.dart';

import '../Bloc/anime_bloc.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}
late AnimeModel data;
class _homeState extends State<home> {
  @override
  void initState() {
    BlocProvider.of<AnimeBloc>(context).add(FetchAnimeEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 50.h,),
          Expanded(
              child: BlocBuilder<AnimeBloc, AnimeState>(
                builder: (context, state) {

                  if(state is AnimeblocLoading){
                    return  Center(child: CircularProgressIndicator(),);
                  }
                  if(state is AnimeblocError){
                    return Text('error');
                  }
                  if( state is AnimeblocLoaded){
                    data=BlocProvider.of<AnimeBloc>(context).animeModel;

                  return ListView.separated(
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        width: 250.w,
                        height: 157.h,
                        color: Colors.red,
                        child: Row(
                          children: [
                            Image.network(data.data![index].image.toString()),
                            SizedBox(width: 25.w,),
                            Column(crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 40.h,),
                                Container(width: 260.w,height:40.h,
                                  child: Text(data.data![index].title.toString(), style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 28.sp,
                                    fontFamily: 'Gilroy-Bold',
                                    fontWeight: FontWeight.w400,
                                    ),),
                                ),
                                SizedBox(height: 40.h,),
                                Text(data.data![index].status.toString(), style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 28.sp,
                                  fontFamily: 'Gilroy-Bold',
                                  fontWeight: FontWeight.w400,
                                  height: 0.07.h,
                                  letterSpacing: 0.10,),),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider();
                    },
                    itemCount: data.data!.length,
                  );}else{return SizedBox();}
                },
              )),
        ],
      ),
    );
  }
}
