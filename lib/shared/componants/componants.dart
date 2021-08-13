import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:news_app/module/WebViewPage/WebViewScreen.dart';
import 'package:news_app/shared/Cubit/cubit.dart';


Widget customButtom({
  Color buttomCollor = Colors.blue,
  double buttomWidth = double.infinity,
  required String text,
  required Function()? press,
}) =>
    Container(
      color: buttomCollor,
      width: buttomWidth,
      child: MaterialButton(
        onPressed: press,
        child: Text(
          text.toUpperCase(),
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );

Widget customTextFeild({
  required TextEditingController controller,
  required TextInputType inputType,
  required String title,
  required IconData pIcon,
  bool isPassword = false,
  IconData? sIcon,
  String? Function(String?)? validate,
  Function()? tap,
  String? Function(String?)? change,
  //Function? tap,
  suffixPress,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: inputType,
      obscureText: isPassword,
      validator: validate,
      onChanged: change,
      onTap: tap,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: title,
        prefixIcon: Icon(pIcon),
        suffixIcon: IconButton(icon: Icon(sIcon), onPressed: suffixPress),
      ),
    );


Widget customArticalItem(artical, context) => InkWell(
      onTap: () {
        Get.to(WebVeiwScreen('${artical['url']}'));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                  image: NetworkImage(artical['urlToImage'] == null
                      ? 'https://ipartspares.com/wp-content/uploads/2019/12/no-photo.png'
                      : '${artical['urlToImage']}'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Container(
                height: 120.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        '${artical['title']}',
                        style: Theme.of(context).textTheme.bodyText1,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      '${artical['publishedAt']}',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

Widget customLine() => Container(
      color: Colors.grey[300],
      width: double.infinity,
      height: 1,
      padding: EdgeInsets.all(16.0),
    );

Widget articleBuilder(list, context, {isSearch = false}) => ConditionalBuilder(
      condition: list.length > 0,
      builder: (context) => ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) =>
            customArticalItem(list[index], context),
        separatorBuilder: (context, index) => customLine(),
        itemCount: 10,
      ),
      fallback: (context) => isSearch
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "No Results",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                  ),
                ),
              ],
            )
          : Center(child: CircularProgressIndicator()),
    );
