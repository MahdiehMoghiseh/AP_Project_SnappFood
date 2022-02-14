import 'dart:math';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/search_bar_style.dart';
import 'package:flutter/src/widgets/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:ap_project/main.dart';
import 'package:flutter/services.dart';
void main() {
  runApp(MainTheme());
}
class MainTheme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "SnappFood",
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.pink,
        accentColor: const Color(0xFFEC407A),
        fontFamily: 'Recoleta-RegularDEMO',
      ),
      home: LoginHome(),
    );
  }
}
class Person extends StatelessWidget{
  String firstname;
  String lastname;
  String phonenumber;
  List<String> adresses;
  String password;
  int money = 0;

  Person({Key key,this.firstname,this.lastname,this.phonenumber,this.password,this.adresses,this.money}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

int walletCredit = 0;
int Index = 0;
List<Person> Persons = <Person>[];
List<Lastorders> LastOrders = <Lastorders>[];
List<Activeorders> ActiveOrders = <Activeorders>[];
List<Favorite> favorites = <Favorite>[];
List<Restaurant> restaurants = <Restaurant>[];
List<Comments> comments = <Comments>[];
List<ShoppingCart> shoppingCarts = <ShoppingCart>[];
class Add extends StatefulWidget {
  @override
  _AddState createState() => _AddState();
}
class _AddState extends State<Add> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}


String app_Name = "SnappFood";
class CustomerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

    );
  }
}

class LoginHome extends StatefulWidget {
  @override
  _LoginHomeState createState() => _LoginHomeState();
}

class _LoginHomeState extends State<LoginHome> {

  Widget _image(Size size){
    return Container(
      height: size.height/3,
      width: size.width,
      child: Image.asset('assets/images/welcome2.jpeg',
        fit: BoxFit.fill,),
    );
  }
  GlobalKey<FormState> _key = new GlobalKey();
  bool _validate = false;
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return new Scaffold(
        appBar: AppBar(
          title: Text(
            'SnappFood',style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Recoleta-RegularDEMO'),
          ),
        ),
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            _image(size),
            new Center(
              child: new SingleChildScrollView(
                child: new Container(
                  margin: new EdgeInsets.all(10.0),
                  child: Center(
                    child: new Form(
                      key: _key,
                      autovalidate: _validate,
                      child: _getLogin(),
                    ),
                  ),
                ),
              ),
            ),
          ],
        )
    );

  }
  Widget _getLogin() {
    String text1 = "";
    String text2 = "";
    int check;
    return new Column(
      children: <Widget>[
        new SizedBox(height: 5.0),
        new TextFormField(
          keyboardType: TextInputType.phone,
          autofocus: false,
          decoration: InputDecoration(
            hintText: 'Phone Number',
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            border:
            OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          ),
          onSaved: (String value){
            text1 = value;
          },
          validator: (String value){
            for (int i=0;i<Persons.length;i++){
              if(Persons[i].phonenumber==value){
                check = i;
                break;
              }
            }
            if(value.length!=11 || check==null)
              return "Invalid phone number!";
            else
              return null;
          },
        ),
        new SizedBox(height: 10.0),
        new TextFormField(
          autofocus: false,
          obscureText: _obscureText,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            hintText: 'Password',
            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            border:
            OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
              child: Icon(
                _obscureText ? Icons.visibility : Icons.visibility_off,
                semanticLabel:
                _obscureText ? 'show password' : 'hide password',
              ),
            ),
          ),
          onSaved: (String value){
            text2 = value;
          },
          validator: (String value){
            if(Persons[check].password==value)
              return null;
            else
              return "Invalid Password!";
          },
        ),
        new SizedBox(height: 15.0),
        new Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: ElevatedButton(
            child: Text('Log In',style: TextStyle(fontFamily: 'Recoleta-RegularDEMO',fontWeight: FontWeight.bold)),
            onPressed: (){
              setState(() {
                if(_key.currentState.validate()){
                  _key.currentState.save();
                  Index = check;
                  Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                }
              });
            },
          ),
        ),
        new Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "You don't have account?",
                style: TextStyle(
                    fontFamily: 'Recoleta-RegularDEMO',
                    color: Theme.of(context).accentColor,
                    fontWeight: FontWeight.bold
                ),
              ),
              RaisedButton(
                  color: Theme.of(context).accentColor,
                  child: Text('SignUp',style: TextStyle(fontFamily: 'Recoleta-RegularDEMO',fontWeight: FontWeight.bold,color: Colors.white)),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
                  }
              ),
            ],
          ),
        )
      ],
    );
  }
}
///////////////Sign Up/////////////////////////////////////////////////////////////////////////////////////////
class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  Widget addPerson(String firstname,String lastname,String phonenumber,String adress,String password){
    setState(() {
      Persons.add(Person(
        firstname: firstname,
        lastname: lastname,
        phonenumber: phonenumber,
        adresses: [adress],
        password: password,
        money: 0,
      ));
    });
  }
  GlobalKey<FormState> _key = new GlobalKey();
  bool _validate = false;
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text(
            'Sign Up',style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Recoleta-RegularDEMO'),
          ),
        ),
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            new Center(
              child: new SingleChildScrollView(
                child: new Container(
                  margin: new EdgeInsets.all(10.0),
                  child: Center(
                    child: new Form(
                      key: _key,
                      autovalidate: _validate,
                      child: _getSignUp(),
                    ),
                  ),
                ),
              ),
            ),
          ],
        )
    );
  }
  Widget _getSignUp(){
    String text1 = "";
    String text2 = "";
    String text3 = "";
    String text4 = "";
    String text5 = "";
    return new Column(
      children: <Widget>[
        new SizedBox(height: 5.0),
        new TextFormField(
          autofocus: false,
          decoration: InputDecoration(
            hintText: 'First Name',
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            border:
            OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          ),
          onSaved: (String value){
            text1 = value;
          },
          validator: (String value){
            return validate_Name(value);
          },
        ),
        new SizedBox(height: 10.0,),
        new TextFormField(
          autofocus: false,
          decoration: InputDecoration(
            hintText: 'Last Name',
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            border:
            OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          ),
          onSaved: (String value){
            text2 = value;
          },
          validator: (String value){
            return validate_Name(value);
          },
        ),
        new SizedBox(height: 15.0,),
        new TextFormField(
          keyboardType: TextInputType.phone,
          autofocus: false,
          decoration: InputDecoration(
            hintText: 'Phone Number',
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            border:
            OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          ),
          onSaved: (String value){
            text3 = value;
          },
          validator: (String value){
            return validate_phonenumber(value);
          },
        ),
        new SizedBox(height: 20.0,),
        new TextFormField(
          autofocus: false,
          decoration: InputDecoration(
            hintText: 'Address',
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            border:
            OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          ),
          onSaved: (String value){
            text4 = value;
          },
          validator: (String value){
            return validate_adress(value);
          },
        ),
        new SizedBox(height: 25.0,),
        new TextFormField(
          obscureText: _obscureText,
          autofocus: false,
          decoration: InputDecoration(
              hintText: 'Password',
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
                child: Icon(
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                  semanticLabel:
                  _obscureText ? 'show password' : 'hide password',
                ),
              )),
          onSaved: (String value){
            text5 = value;
          },
          validator: (String value){
            return validate_password(value);
          },
        ),
        new SizedBox(height: 15.0),
        new Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: ElevatedButton(
            child: Text('Sign Up',style: TextStyle(fontFamily: 'Recoleta-RegularDEMO',fontWeight: FontWeight.bold)),
            onPressed: (){
              setState(() {
                if(_key.currentState.validate()){
                  _key.currentState.save();
                  addPerson(text1, text2, text3, text4, text5);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginHome()));
                }
              });
            },
          ),
        ),
      ],
    );
  }
}
/////////////////////////////////Home Page//////////////////////////////////////////////////////////////////////
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final List<Widget> _children = [Home(),ShoppingCart(),ListOfOrders(),];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Food",style : TextStyle(fontFamily: 'Recoleta-RegularDEMO',fontWeight: FontWeight.bold),),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("Home",style: TextStyle(fontFamily: 'Recoleta-RegularDEMO',fontWeight: FontWeight.bold)),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_outlined), title: Text("Shopping Cart",style: TextStyle(fontFamily: 'Recoleta-RegularDEMO',fontWeight: FontWeight.bold),)),
          BottomNavigationBarItem(
            icon: Icon(Icons.description_outlined),
            title: Text("Orders",style: TextStyle(fontFamily: 'Recoleta-RegularDEMO',fontWeight: FontWeight.bold),),
          )
        ],
        onTap: (int index){
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      body: _children[_selectedIndex],
    );
  }
}
//////////////////////////////Home/////////////////////////////////////////////////////////////////////////
class Menu extends StatelessWidget {
  String name;
  Image image;
  int price;
  Menu({Key key,this.name,this.image,this.price}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class Favorite extends StatelessWidget {
  String restaurant_name;
  Image image;
  List<Foods_Categories> type;
  Favorite({Key key,this.restaurant_name,this.type,this.image}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
class Restaurant extends StatefulWidget {
  String restaurant_name;
  double score;
  List<Menu> menu;
  Image image;
  List<Foods_Categories> type;
  String restaurant_adress;
  List<String> ThisComments;
  Restaurant({Key key,this.score,this.restaurant_name,this.image,this.menu,this.type,this.restaurant_adress,this.ThisComments}) : super(key: key);
  @override
  _RestaurantState createState() => _RestaurantState();
}
GlobalKey<FormState> _key = new GlobalKey();
String text = "";
class _RestaurantState extends State<Restaurant> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            children: [
              Container(
                  height: size.height/3,
                  width: size.width,
                  child: widget.image
              ),
              Padding(
                  padding: EdgeInsets.all(5),
                  child: Column(
                    children: [
                      Card(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(widget.restaurant_name,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                RaisedButton(onPressed: (){
                                  setState(() {
                                    widget.score += 0.01;
                                  });
                                },
                                  color: Colors.green[900],
                                  child: Row(
                                    children: [
                                      Icon(Icons.star_rate_rounded,color: Colors.white,),
                                      Text(widget.score.toString(),style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)
                                    ],
                                  ),
                                ),
                                ElevatedButton(
                                    onPressed: (){
                                      showModalBottomSheet(context: context, builder: (context){
                                        return Padding(padding: EdgeInsets.all(5),
                                            child: new SingleChildScrollView(
                                                child: new Form(
                                                    key: _key,
                                                    child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: [
                                                          new SizedBox(height: 5.0,),
                                                          new TextFormField(
                                                            autofocus: false,
                                                            decoration: InputDecoration(
                                                              hintText: 'New Comment',
                                                              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 50.0),
                                                              border:
                                                              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                                                            ),
                                                            onSaved: (String value){
                                                              text=value;
                                                            },
                                                            onChanged: (String value){
                                                              text = value;
                                                            },
                                                          ),
                                                          ElevatedButton(
                                                            onPressed: (){
                                                              setState(() {
                                                                comments.add(Comments(
                                                                  restaurant_name: widget.restaurant_name,
                                                                  answer: false,
                                                                  date: DateTime.now(),
                                                                  comment: text,
                                                                ));
                                                                Navigator.pop(context);
                                                                _key.currentState.save();
                                                              });
                                                            },
                                                            child: Text('add',style: TextStyle(fontWeight: FontWeight.bold),),
                                                          )
                                                        ])
                                                )
                                            )
                                        );
                                      });
                                    },
                                    child: Icon(Icons.mode_comment_outlined)
                                ),
                                ElevatedButton(
                                  onPressed: (){
                                    setState(() {
                                      favorites.add(Favorite(
                                        restaurant_name: widget.restaurant_name,
                                        type: widget.type,
                                        image: widget.image,
                                      ));
                                    });
                                  },
                                  child: Icon(Icons.favorite_border),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: widget.menu.length,
                        itemBuilder: (context,int index){
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    children: [
                                      Text(widget.menu[index].name,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
                                      Text(widget.menu[index].price.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),)
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                        height: 100,width: 100,
                                        child: widget.menu[index].image,
                                      ),
                                      RaisedButton(
                                        onPressed: (){
                                          setState(() {
                                            shoppingCarts.add(ShoppingCart(
                                              restaurant_name: widget.restaurant_name,
                                              price: widget.menu[index].price,
                                              date: DateTime.now(),
                                              image: widget.image,
                                              restaurant_adress: widget.restaurant_adress,
                                            ));
                                          });
                                        },
                                        child: Text('ADD',style: TextStyle(color: Colors.white),),
                                        color: Theme.of(context).primaryColor,
                                      )
                                    ],
                                  )
                                ],
                              ),
                              Divider(
                                color: Theme.of(context).primaryColor,
                              )
                            ],
                          );
                        },
                      )
                    ],
                  )
              )
            ],
          ),
        )
    );
  }
}

class Comments extends StatelessWidget {
  String comment;
  String restaurant_name;
  bool answer;
  String Answer;
  DateTime date;
  Comments({Key key,this.restaurant_name,this.Answer,this.answer,this.comment,this.date}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    restaurants.sort((a,b) => a.score.compareTo(b.score));
  }
  void _ShowAdresses(context){
    showModalBottomSheet(
        context: (context),
        builder: (context){
          return Padding(
            padding: EdgeInsets.all(5),
            child: ListView.builder(
              itemCount: Persons[Index].adresses.length,
              itemBuilder: (context,int index){
                return GestureDetector(
                  onTap: (){
                    //select address
                    setState(() {
                      String temp = Persons[Index].adresses[0];
                      Persons[Index].adresses[0] = Persons[Index].adresses[index];
                      Persons[Index].adresses[index] = temp;
                    });
                  },
                  child: Card(
                    child: ListTile(
                      title: Text(
                        Persons[Index].adresses[index],
                        style: TextStyle(fontFamily: 'Recoleta-RegularDEMO',fontWeight: FontWeight.bold,color: Theme.of(context).accentColor),
                      ),
                      trailing: index==0 ? Icon(Icons.check_circle_outline,color: Colors.green,) : Icon(Icons.clear),
                    ),
                  ),
                );
              },
            ),
          );
        }
    );
  }
  void _search(context){
    Navigator.of(context).push(
        new MaterialPageRoute(
            builder: (context){
              return new Scaffold(
                body: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: SearchBar(
                      onSearch: search,
                      onItemFound: (String restaurant, int index) {
                        return GestureDetector(
                            onTap: (){
                              for(int i=0;i<restaurants.length;i++){
                                if(restaurants[i].restaurant_name.startsWith(restaurant)){
                                  index = i;
                                }
                              }
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Restaurant(restaurant_name: restaurants[index].restaurant_name,
                                score: restaurants[index].score,type: restaurants[index].type,image: restaurants[index].image,menu: restaurants[index].menu,
                              )));
                            },
                            child: Card(
                              child: Text(restaurant,style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Theme.of(context).accentColor),),
                            )
                        );
                      },
                      searchBarStyle: SearchBarStyle(
                          padding: EdgeInsets.all(10),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      loader: Text('loading...'),
                    ),
                  ),
                ),
              );
            }
        )
    );
  }
  void _showComments(){
    Navigator.of(context).push(
        new MaterialPageRoute(
            builder: (context){
              return new Scaffold(
                appBar: AppBar(title: Text('My Comments',style: TextStyle(fontWeight: FontWeight.bold),),),
                body: ListView.builder(
                  itemCount: comments.length,
                  itemBuilder: (context,int index){
                    return GestureDetector(
                        child: Card(
                            child: Padding(padding: EdgeInsets.all(20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  ListTile(
                                    title: Text(comments[index].restaurant_name),
                                    subtitle: Text(comments[index].date.day.toString()+"/"+comments[index].date.month.toString()+"/"+comments[index].date.year.toString()),
                                  ),
                                  Text(comments[index].comment),
                                  comments[index].answer ? SizedBox(
                                    height: 200,width: 500,
                                    child: Text(comments[index].Answer),
                                  ) : SizedBox(
                                    height: 200,width: 500,
                                    child: Text('No Answer for this comment!'),
                                  )
                                ],
                              ),
                            )
                        )
                    );
                  },
                ),
              );
            }
        )
    );
  }
  GlobalKey<FormState> _key = new GlobalKey();
  String text = "";
  Future<List<String>> search(String name) async {
    await Future.delayed(Duration(seconds: 2));
    return List.generate(restaurants.length, (int index) {
      return restaurants[index].restaurant_name;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: (){
                    _search(context);
                    setState(() {
                      //test
                      List<int> prices = [300000,250000,460000,670000,12000,23000,324000,876000,134000,56000];
                      restaurants.add(Restaurant(
                        restaurant_name: 'this restaurant',
                        score: 5.4,
                        type: [food_categories[0],food_categories[5]],
                        image: food_categories[5].image,
                        restaurant_adress: 'street 123',
                        menu: List<Menu>.generate(10,(index) => Menu(name: food_categories[index].name,image: food_categories[index].image,price: prices[index],)),
                      ));
                      LastOrders.add(Lastorders(
                        restaurant_name: 'Iren',
                        type: food_categories[4].name,
                        date: DateTime(2020,12,11,22,30),
                        restaurant_adress: 'street 12345',
                        price: '1010000 T',
                        image: Image.asset('assets/images/welcome1.jpeg'),
                        items: List.generate(3, (index) => OrdersClass(price: prices[index].toString(),name: food_categories[index].name,count: 1,)),
                      ));
                    });
                  },
                  child: Icon(Icons.search),
                ),
                ElevatedButton(
                    onPressed: (){
                      showModalBottomSheet(context: context, builder: (context){
                        return Padding(padding: EdgeInsets.all(5),
                            child: new SingleChildScrollView(
                                child: new Form(
                                    key: _key,
                                    child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          new SizedBox(height: 5.0,),
                                          new TextFormField(
                                            autofocus: false,
                                            decoration: InputDecoration(
                                              hintText: 'New Address',
                                              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 50.0),
                                              border:
                                              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                                            ),
                                            onSaved: (String value){
                                              text=value;
                                            },
                                            onChanged: (String value){
                                              text = value;
                                            },
                                          ),
                                          ElevatedButton(
                                            onPressed: (){
                                              setState(() {
                                                Persons[Index].adresses.add(text);
                                                Navigator.pop(context);
                                                _key.currentState.save();
                                              });
                                            },
                                            child: Text('add',style: TextStyle(fontWeight: FontWeight.bold),),
                                          )
                                        ])
                                )
                            )
                        );
                      }
                      );},
                    child: Row(
                      children: [
                        Text(
                          'Add address',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        //Icon(Icons.add_circle_outline),
                      ],
                    )
                ),
                ElevatedButton(
                    onPressed: (){
                      _ShowAdresses(context);
                    },
                    child: Row(
                      children: [
                        Text(
                          "Addresses",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Icon(Icons.expand_more),
                      ],
                    )
                ),
              ],
            )
        ),
        drawer: Drawer(
          child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      height: 80,width: 300,
                      child: Card(
                        child: Padding(padding: EdgeInsets.only(top: 5,),
                            child: Row(
                              children: [
                                Icon(Icons.person,color: Theme.of(context).primaryColor,),
                                Spacer(),
                                Text(Persons[Index].firstname+" "+Persons[Index].lastname,
                                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                                Spacer(flex: 20,)
                              ],
                            )
                        ),
                      )
                  ),
                  Container(
                      height: 80,width: 300,
                      child: GestureDetector(
                        onTap: (){
                          setState(() {
                            walletCredit = 0;
                          });
                          Navigator.push(context, MaterialPageRoute(builder: (context) => IcreaseWallet()));
                        },
                        child: Card(
                          child: Padding(padding: EdgeInsets.only(top: 1),
                              child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(Icons.account_balance_wallet,color: Theme.of(context).primaryColor,),
                                  Text('Increase wallet credit',
                                    style: TextStyle(fontSize: 20),),
                                  Icon(Icons.chevron_right)
                                ],
                              )
                          ),
                        ),
                      )
                  ),
                  Container(
                      height: 80,width: 300,
                      child: GestureDetector(
                        onTap: (){
                          _showComments();
                        },
                        child: Card(
                          child: Padding(padding: EdgeInsets.only(top: 1),
                              child: Row(
                                children: [
                                  Spacer(),
                                  Icon(Icons.comment,color: Theme.of(context).primaryColor,),
                                  Spacer(),
                                  Text('My comments',
                                    style: TextStyle(fontSize: 20),),
                                  Spacer(flex: 10,),
                                  Icon(Icons.chevron_right),
                                  Spacer()
                                ],
                              )
                          ),
                        ),
                      )
                  ),
                  Container(
                      height: 80,width: 300,
                      child: GestureDetector(
                        onTap: (){
                          Navigator.of(context).push(
                              new MaterialPageRoute(builder: (context){
                                return Padding(padding: EdgeInsets.all(5),
                                  child: new Scaffold(
                                    body: ListView.builder(
                                      itemCount: favorites.length,
                                      itemBuilder: (context,int index){
                                        return GestureDetector(
                                          onTap: (){
                                            for(int i=0;i<restaurants.length;i++){
                                              if(restaurants[i].restaurant_name.startsWith(favorites[index].restaurant_name)){
                                                Navigator.push(context,
                                                    MaterialPageRoute(builder: (context) => Restaurant(restaurant_name: restaurants[i].restaurant_name,
                                                      score: restaurants[i].score,image: restaurants[i].image,type: restaurants[i].type,menu: restaurants[i].menu,
                                                    )
                                                    )
                                                );
                                              }
                                            }
                                          },
                                          child: Card(
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  Container(
                                                    height: 150,
                                                    width: 150,
                                                    child: favorites[index].image,
                                                  ),
                                                  Text(favorites[index].restaurant_name,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)
                                                ],
                                              )
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                );
                              })
                          );
                        },
                        child: Card(
                          child: Padding(padding: EdgeInsets.only(top: 1),
                              child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(Icons.stars_rounded,color: Theme.of(context).primaryColor,),
                                  Text('Favorite Restaurants',
                                    style: TextStyle(fontSize: 20),),
                                  Icon(Icons.chevron_right)
                                ],
                              )
                          ),
                        ),
                      )
                  ),
                  Container(
                      height: 80,width: 300,
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => LoginHome()
                              )
                          );
                        },
                        child: Card(
                          child: Padding(padding: EdgeInsets.only(top: 1),
                              child: Row(
                                children: [
                                  Spacer(),
                                  Icon(Icons.exit_to_app_outlined,color: Theme.of(context).primaryColor,),
                                  Spacer(),
                                  Text('Exit',
                                    style: TextStyle(fontSize: 20),),
                                  Spacer(flex: 25,),
                                  Icon(Icons.chevron_right),
                                  Spacer()
                                ],
                              )
                          ),
                        ),
                      )
                  ),
                ],
              )
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Food Categories',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),
                ),
                SizedBox(
                  height: 250,
                  child: ListView.builder(
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: food_categories.length,
                      itemBuilder: (BuildContext context, int index) => GestureDetector(
                        onTap: (){},
                        child: Card(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  height: 150,
                                  width: 150,
                                  child: food_categories[index].image,
                                ),
                                Text(
                                  food_categories[index].name,
                                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Theme.of(context).accentColor),
                                )
                              ],
                            )
                        ),
                      )
                  ),
                ),
                Text(
                  'My Favorite',
                  style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 250,
                  child: ListView.builder(
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: favorites.length,
                      itemBuilder: (BuildContext context, int index) => GestureDetector(
                        onTap: (){
                          for(int i=0;i<restaurants.length;i++){
                            if(restaurants[i].restaurant_name.startsWith(favorites[index].restaurant_name)){
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => Restaurant(restaurant_name: restaurants[i].restaurant_name,
                                    score: restaurants[i].score,image: restaurants[i].image,type: restaurants[i].type,menu: restaurants[i].menu,
                                  )
                                  )
                              );
                            }
                          }
                        },
                        child: Card(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  height: 150,
                                  width: 150,
                                  child: favorites[index].image,
                                ),
                                Text(
                                  favorites[index].restaurant_name,
                                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Theme.of(context).primaryColor),
                                )
                              ],
                            )
                        ),
                      )
                  ),
                ),
                Text(
                  'The Best',
                  style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 250,
                  child: ListView.builder(
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: restaurants.length<11 ? restaurants.length : 10,
                      itemBuilder: (BuildContext context, int index) => GestureDetector(
                        onTap: (){
                          for(int i=0;i<restaurants.length;i++){
                            if(restaurants[i].restaurant_name.startsWith(favorites[index].restaurant_name)){
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => Restaurant(restaurant_name: restaurants[i].restaurant_name,
                                    score: restaurants[i].score,image: restaurants[i].image,type: restaurants[i].type,menu: restaurants[i].menu,
                                  )
                                  )
                              );
                            }
                          }
                        },
                        child: Card(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  height: 150,
                                  width: 150,
                                  child: restaurants[index].image,
                                ),
                                Text(
                                  restaurants[index].restaurant_name,
                                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Theme.of(context).primaryColor),
                                )
                              ],
                            )
                        ),
                      )
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}
class IcreaseWallet extends StatefulWidget {
  @override
  _IcreaseWalletState createState() => _IcreaseWalletState();
}

class _IcreaseWalletState extends State<IcreaseWallet> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(title: Text('Increase wallet credit'),),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('Current Balance : '+Persons[Index].money.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: (){
                  setState(() {
                    walletCredit += 50000;
                  });
                },
                child: Text('50000 T'),
              ),
              ElevatedButton(
                onPressed: (){
                  setState(() {
                    walletCredit += 20000;
                  });
                },
                child: Text('20000 T'),
              ),
              ElevatedButton(
                onPressed: (){
                  setState(() {
                    walletCredit += 10000;
                  });
                },
                child: Text('10000 T'),
              )
            ],
          ),
          Text(walletCredit.toString()),
          ElevatedButton(onPressed: (){
            setState(() {
              Persons[Index].money += walletCredit;
              Navigator.pop(context);
            });
          },
            child: Text('The Payment'),
          )
        ],
      ),
    );
  }
}

///////////////////////////////////////////////orders////////////////////////////////////////////////////////////
class OrdersClass extends StatelessWidget {
  String name;
  String price;
  int count;
  OrdersClass({Key key,this.price,this.name,this.count}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
class Lastorders extends StatefulWidget {
  List<OrdersClass> items = <OrdersClass>[];
  DateTime date;
  String restaurant_name;
  String restaurant_adress;
  String price;
  Image image;
  String type;
  Lastorders({Key key,this.items,this.date,this.restaurant_name,this.restaurant_adress,this.price,this.image,this.type}) : super(key: key);
  @override
  _LastordersState createState() => _LastordersState();
}

class _LastordersState extends State<Lastorders> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Card(
        child: ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                widget.restaurant_name,
                style: TextStyle(
                    fontFamily: 'Recoleta-RegularDEMO',fontWeight: FontWeight.bold,color: Colors.black
                ),
              ),
              Container(
                height: 130,
                width: 130,
                child: widget.image,
              )
            ],
          ),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  Spacer(flex: 2,),
                  Icon(Icons.date_range),
                  Text(
                    widget.date.year.toString()+"/"+widget.date.month.toString()+"/"+widget.date.day.toString(),
                    style: TextStyle(
                        fontFamily: 'Recoleta-RegularDEMO',fontWeight: FontWeight.bold,color: Colors.black
                    ),
                  ),
                  Spacer(),
                  Icon(Icons.access_time),
                  Text(
                    widget.date.hour.toString()+":"+widget.date.minute.toString(),
                    style: TextStyle(
                        fontFamily: 'Recoleta-RegularDEMO',fontWeight: FontWeight.bold,color: Colors.black
                    ),
                  ),
                  Spacer(flex: 2,)
                ],
              ),
              Row(
                children: [
                  Spacer(flex: 2,),
                  Icon(Icons.location_on_outlined),
                  Text(
                    widget.restaurant_adress,
                    style: TextStyle(
                        fontFamily: 'Recoleta-RegularDEMO',fontWeight: FontWeight.bold,color: Colors.black
                    ),
                  ),
                  Spacer(flex: 4,)
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Total",
                    style: TextStyle(
                        fontFamily: 'Recoleta-RegularDEMO',fontWeight: FontWeight.bold,color: Colors.black
                    ),
                  ),
                  Text(
                    widget.price,
                    style: TextStyle(
                        fontFamily: 'Recoleta-RegularDEMO',fontWeight: FontWeight.bold,color: Colors.black
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RaisedButton(
                      color: Theme.of(context).accentColor,
                      onPressed: (){
                        setState(() {
                          ActiveOrders.add(Activeorders(
                            price: widget.price,
                            date: widget.date,
                            image: widget.image,
                            TrackingCode: Random().nextInt(1000000),
                          ));
                        });
                      },
                      child: Text(
                        "Reorder",
                        style: TextStyle(
                            fontFamily: 'Recoleta-RegularDEMO',fontWeight: FontWeight.bold,color: Colors.white
                        ),
                      )
                  ),
                  ElevatedButton(
                    onPressed: (){
                      showModalBottomSheet(context: (context), builder: (context){
                        return Padding(padding: EdgeInsets.all(5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: ListView.builder(
                                    itemCount: widget.items.length,
                                    itemBuilder: (context,index) => new Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(widget.items[index].name+"("+widget.items[index].count.toString()+")",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Theme.of(context).accentColor),),
                                        Text(widget.items[index].price,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Theme.of(context).accentColor),),
                                      ],
                                    )
                                ),
                              ),
                              Divider(
                                color: Theme.of(context).accentColor,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "Total",
                                    style: TextStyle(
                                      fontFamily: 'Recoleta-RegularDEMO',fontWeight: FontWeight.bold,fontSize: 25,
                                    ),
                                  ),
                                  Text(
                                    widget.price,
                                    style: TextStyle(
                                        fontFamily: 'Recoleta-RegularDEMO',fontWeight: FontWeight.bold,fontSize: 30
                                    ),
                                  ),
                                ],
                              ),
                              Spacer()
                            ],
                          ),
                        );
                      });
                    },
                    child: Text(
                      "View invoice",
                      style: TextStyle(
                          fontFamily: 'Recoleta-RegularDEMO',fontWeight: FontWeight.bold
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Activeorders extends StatelessWidget {
  String price;
  int TrackingCode;
  DateTime date;
  String description;
  Image image;
  Activeorders({Key key,this.description,this.date,this.price,this.TrackingCode,this.image}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Card(
        child: ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 130,
                width: 130,
                child: image,
              ),
              Text(
                "Tracking Code : ",
                style: TextStyle(fontWeight: FontWeight.bold,color: Theme.of(context).accentColor),
              ),
              Text(
                TrackingCode.toString(),
                style: TextStyle(fontWeight: FontWeight.bold,color: Theme.of(context).accentColor),
              ),
            ],
          ),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  Spacer(flex: 2,),
                  Icon(Icons.date_range),
                  Text(
                    date.year.toString()+"/"+date.month.toString()+"/"+date.day.toString(),
                    style: TextStyle(
                        fontFamily: 'Recoleta-RegularDEMO',fontWeight: FontWeight.bold,
                        color: Colors.black
                    ),
                  ),
                  Spacer(),
                  Icon(Icons.access_time),
                  Text(
                    date.hour.toString()+":"+date.minute.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  Spacer(flex: 3,)
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Total",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black
                    ),
                  ),
                  Text(
                    price,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class ListOfOrders extends StatelessWidget {
  SliverAppBar showSliverAppBar(String screenTitle){
    return SliverAppBar(
      backgroundColor: Colors.white,
      floating: true,
      pinned: true,
      snap: false,
      bottom: TabBar(
        labelColor: Colors.black,
        tabs: [
          Tab(
            text: "Last Orders",
          ),
          Tab(
            text: "Active Orders",
          )
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: TabBarView(
          children: [
            CustomScrollView(
              slivers: [
                showSliverAppBar("Last Orders"),
                SliverFillRemaining(
                  child: ListView.builder(
                    itemCount: LastOrders.length,
                    itemBuilder: (context,int index){
                      return GestureDetector(
                        child: LastOrders[index],
                      );
                    },
                  ),
                )
              ],
            ),
            CustomScrollView(
              slivers: [
                showSliverAppBar("Active Orders"),
                SliverFillRemaining(
                  child: ListView.builder(
                    itemCount: ActiveOrders.length,
                    itemBuilder: (context,int index){
                      return GestureDetector(
                        child: ActiveOrders[index],
                      );
                    },
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}


/////////////////////////////////////////////shopping cart/////////////////////////////////////////////////////
class ShoppingCart extends StatefulWidget {
  String restaurant_name;
  DateTime date;
  String restaurant_adress;
  int price;
  Image image;
  ShoppingCart({Key key,this.restaurant_name,this.date,this.price,this.image,this.restaurant_adress}) : super(key: key);
  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: shoppingCarts.length,
          itemBuilder: (context,int index){
            return Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          shoppingCarts[index].restaurant_name,
                          style: TextStyle(
                              fontFamily: 'Recoleta-RegularDEMO',fontWeight: FontWeight.bold
                          ),
                        ),
                        Container(
                            height: 150,
                            width: 150,
                            child: shoppingCarts[index].image
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Spacer(flex: 2,),
                        Icon(Icons.date_range),
                        Text(
                          shoppingCarts[index].date.year.toString()+"/"+shoppingCarts[index].date.month.toString()+"/"+shoppingCarts[index].date.day.toString(),
                          style: TextStyle(
                              fontFamily: 'Recoleta-RegularDEMO',fontWeight: FontWeight.bold
                          ),
                        ),
                        Spacer(),
                        Icon(Icons.access_time),
                        Text(
                          shoppingCarts[index].date.hour.toString()+":"+shoppingCarts[index].date.minute.toString(),
                          style: TextStyle(
                              fontFamily: 'Recoleta-RegularDEMO',fontWeight: FontWeight.bold
                          ),
                        ),
                        Spacer(flex: 2,)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Total",
                          style: TextStyle(
                              fontFamily: 'Recoleta-RegularDEMO',fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(
                          shoppingCarts[index].price.toString(),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RaisedButton(
                            color: Theme.of(context).accentColor,
                            onPressed: (){
                              setState(() {
                                shoppingCarts.removeAt(index);
                              });
                            },
                            child: Text(
                              "Cancel",
                              style: TextStyle(
                                  fontFamily: 'Recoleta-RegularDEMO',fontWeight: FontWeight.bold,color: Colors.white
                              ),
                            )
                        ),
                        ElevatedButton(
                          onPressed: (){
                            setState(() {
                              if(shoppingCarts[index].price>Persons[Index].money){
                                setState(() {
                                  walletCredit = 0;
                                });
                                Navigator.push(context, MaterialPageRoute(builder: (context) => IcreaseWallet()));
                                Persons[Index].money -= shoppingCarts[index].price;
                                ActiveOrders.add(Activeorders(
                                  price: shoppingCarts[index].price.toString(),
                                  date: DateTime.now(),
                                  image: shoppingCarts[index].image,
                                  description: shoppingCarts[index].restaurant_name,
                                  TrackingCode: Random().nextInt(1000000),
                                ));
                                shoppingCarts.removeAt(index);
                              }
                              else{
                                Persons[Index].money -= shoppingCarts[index].price;
                                ActiveOrders.add(Activeorders(
                                  price: shoppingCarts[index].price.toString(),
                                  date: DateTime.now(),
                                  image: shoppingCarts[index].image,
                                  description: shoppingCarts[index].restaurant_name,
                                  TrackingCode: Random().nextInt(1000000),
                                ));
                                shoppingCarts.removeAt(index);
                              }
                            });
                          },
                          child: Text(
                            "Continue",
                            style: TextStyle(
                                fontFamily: 'Recoleta-RegularDEMO',fontWeight: FontWeight.bold
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                )
            );
          },
        )
    );
  }
}