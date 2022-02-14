import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ap_project/customer_app.dart';
import 'package:ap_project/restaurant_app.dart';

class Foods_Categories extends StatelessWidget {
  String name;
  Image image;
  @override
  Widget build(BuildContext context) {
    return Container();
  }
  Foods_Categories({Key key,this.image,this.name}) : super(key: key);
}


final List<String> names = ["Iranian","Arabic","Asian","Breakfast","Burger","Fried","Gilani","Indian","Italian","Pizza","Salad","Sandwich","Seafood","Steak","Vegan"];
final List<Image> images =
[Image.asset('assets/images/iranian.jpg',fit: BoxFit.fill,),Image.asset('assets/images/arabic.jpg',fit: BoxFit.fill,),Image.asset('assets/images/asian.jpg',fit: BoxFit.fill,),
  Image.asset('assets/images/breakfast.jpg',fit: BoxFit.fill,),Image.asset('assets/images/burger.jpg',fit: BoxFit.fill,),Image.asset('assets/images/fried.jpg',fit: BoxFit.fill,),Image.asset('assets/images/gilani.jpg',fit: BoxFit.fill,),
  Image.asset('assets/images/indian.jpg',fit: BoxFit.fill,),Image.asset('assets/images/italian.jpg',fit: BoxFit.fill,),Image.asset('assets/images/pizza.jpg',fit: BoxFit.fill,),Image.asset('assets/images/salad.jpg',fit: BoxFit.fill,),
  Image.asset('assets/images/sandwich.jpg',fit: BoxFit.fill,),Image.asset('assets/images/seafood.jpg',fit: BoxFit.fill,),Image.asset('assets/images/steak.jpeg',fit: BoxFit.fill,),Image.asset('assets/images/vegan.jpg',fit: BoxFit.fill,)
];

final food_categories = List<Foods_Categories>.generate(15, (index) => Foods_Categories(name: names[index],image: images[index],));



String validate_adress (String value){
  if(value.isEmpty || value==null){
    return "You must enter an address";
  }
  return null;
}

String validate_Name (String value){
  if(value.isEmpty || value==null){
    return "You must enter a name";
  }
  return null;
}

String validate_phonenumber(String value){
  for(int i=0;i<Persons.length;i++){
    if(Persons[i].phonenumber==value)
      return "Your phone number has already registered!";
  }
  if(value.isEmpty || value==null)
    return "You must enter a phone number";
  else if(value.length != 11){
    return "Invalid phone number!";
  }
  return null;
}


String validate_password(String value){
  RegExp regex = RegExp(r"([a-zA-Z]+)([0-9]+)");
  if(value.length<6 || !regex.hasMatch(value))
    return "Invalid password,Your password must be at least 6 letters!";
  return null;
}
class Menu extends StatelessWidget {
  String name;
  Image image;
  int price;
  String priceR;//for restaurant_app
  bool available;
  Menu({Key key,this.name,this.image,this.price,this.priceR,this.available}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
