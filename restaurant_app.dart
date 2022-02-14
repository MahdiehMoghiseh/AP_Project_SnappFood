import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'main.dart';

void main() {
  runApp(MainTheme());
}
class MainTheme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "SnapFood",
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
int Index = 0;
String appBar = "Services";
List<restaurants> Restaurant = <restaurants>[];
List<ManageComments> comments = <ManageComments>[];
List<String> commentString = ['It was so good','The food was awful','The food was cold','It was too late and it was quite cold','Everything was great'];
class restaurants extends StatelessWidget {
  String name;
  String adress;
  String food_categories;
  String phoneNumber;
  String password;
  double score;
  List<Menu> menu;
  Image image;
  List<ManageComments> ThisComments;
  restaurants({Key key,this.name,this.food_categories,this.adress,this.password,this.phoneNumber,this.score,this.menu,this.ThisComments,this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
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
      child: Image.asset('assets/images/welcome1.jpeg',
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
            for (int i=0;i<Restaurant.length;i++){
              if(Restaurant[i].phoneNumber==value){
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
            if(Restaurant[check].password==value)
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
///////////////////////signup//////////////////////
class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  Widget addRestaurant(String name,String adress,String phonenumber,String food_categories,String password){
    setState(() {
      Restaurant.add(restaurants(
        name: name,
        adress: adress,
        phoneNumber: phonenumber,
        password: password,
        food_categories: food_categories,
        score: 0.0,
        image: Image.asset('assets/images/welcome2.jpeg'),
        menu:List<Menu>.generate(0, (index) => Menu(),growable: true),
        ThisComments: List<ManageComments>.generate(5, (index) => ManageComments(comment: commentString[index],answer: "",isAnswered: false,)),
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
            hintText: 'Name of the restaurant',
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
            hintText: 'Adress',
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            border:
            OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          ),
          onSaved: (String value){
            text2 = value;
          },
          validator: (String value){
            return validate_adress(value);
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
            hintText: 'Food Categories',
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            border:
            OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          ),
          onSaved: (String value){
            text4 = value;
          },
          validator: (String value){
            return validate_Name(value);
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
                  addRestaurant(text1, text2, text3, text4, text5);
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
//////////////HomePage///////////////
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  final List<Widget> children = [Services(),Ordering(),Dashboard(),];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(appBar,style : TextStyle(fontFamily: 'Recoleta-RegularDEMO',fontWeight: FontWeight.bold),),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.widgets_outlined),
            title: Text("Services",style: TextStyle(fontFamily: 'Recoleta-RegularDEMO',fontWeight: FontWeight.bold)),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.description_outlined), title: Text("Ordering",style: TextStyle(fontFamily: 'Recoleta-RegularDEMO',fontWeight: FontWeight.bold),)),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            title: Text("Dashboard",style: TextStyle(fontFamily: 'Recoleta-RegularDEMO',fontWeight: FontWeight.bold),),
          )
        ],
        onTap: (int index){
          setState(() {
            if(index==0){
              appBar = "Services";
            }
            else if(index==1){
              appBar = "Ordering";
            }
            else{
              appBar = "Dashboard";
            }
            selectedIndex = index;
          });
        },
      ),
      body: children[selectedIndex],
    );
  }
}

////////////////////////Services//////////////////////
class Services extends StatefulWidget {
  @override
  _ServicesState createState() => _ServicesState();
}

class _ServicesState extends State<Services> {
  Widget items(String text,IconData icon,Size size){
    return Container(
      height: size.height/3,
      width: size.width/2.5,
      child: GestureDetector(
        child: Card(
            child: Padding(
              padding: EdgeInsets.all(5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(icon,size: 50,color: Theme.of(context).accentColor,),
                  Center(
                    child: Text(
                      text,
                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),
                    ),
                  )
                ],
              ),
            )
        ),
        onTap: (){
          if(text=="Edit Menu"){
            Navigator.push(context, MaterialPageRoute(builder: (context) => EditMenu()));
          }
          if(text=="Manage comments"){
            Navigator.push(context, MaterialPageRoute(builder: (context) => ManageComments()));
          }

        },
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  items('Edit Menu', Icons.edit,size),
                  items('Accounting', Icons.attach_money,size)
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  items('Manage comments', Icons.comment,size),
                  items('History', Icons.access_time,size)
                ],
              ),
            ],
          ),
        )
    );
  }
}
class EditMenu extends StatefulWidget {
  @override
  _EditMenuState createState() => _EditMenuState();
}

class _EditMenuState extends State<EditMenu> {
  Widget ShowMenu(){
    GlobalKey<FormState> _key = new GlobalKey();
    String text1="";
    String text2="";
    return SingleChildScrollView(
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: Restaurant[Index].menu.length,
        itemBuilder: (context,int index){
          bool isSwitched = Restaurant[Index].menu[index].available;
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text(Restaurant[Index].menu[index].name,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
                      Text(Restaurant[Index].menu[index].priceR.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),)
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        height: 200,width: 150,
                        child: Restaurant[Index].menu[index].image,
                      ),
                      Switch(
                        value: isSwitched,
                        onChanged: (value){
                          setState(() {
                            isSwitched=value;
                          });
                        },
                        activeTrackColor: Colors.green[800],
                        activeColor: Colors.green[700],
                      ),
                    ],
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(onPressed: (){
                    Navigator.of(context).push(
                        new MaterialPageRoute(builder: (context){
                          return new Scaffold(
                              appBar: AppBar(
                                title: Text('Change Detailes'),
                              ),
                              body: new Form(
                                key: _key,
                                child: Column(
                                  children: [
                                    new SizedBox(height: 5.0),
                                    new TextFormField(
                                      autofocus: false,
                                      decoration: InputDecoration(
                                        hintText: 'Change Name',
                                        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                        border:
                                        OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                                      ),
                                      onSaved: (String value){
                                        text1 = value;
                                      },
                                    ),
                                    new SizedBox(height: 10.0,),
                                    new TextFormField(
                                        autofocus: false,
                                        decoration: InputDecoration(
                                          hintText: 'Change price',
                                          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                          border:
                                          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                                        ),
                                        onSaved: (String value){
                                          text2 = value;
                                        }
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        RaisedButton(
                                          onPressed: (){
                                            Restaurant[Index].menu[index].available = true;
                                          },
                                          child: Text('Available'),
                                          color: Colors.green,
                                        ),
                                        RaisedButton(
                                          onPressed: (){
                                            Restaurant[Index].menu[index].available = false;
                                          },
                                          child: Text('Not Available'),
                                          color: Colors.red,
                                        )
                                      ],
                                    ),
                                    ElevatedButton(onPressed: (){
                                      setState(() {
                                        _key.currentState.save();
                                        if(text1 != ""){
                                          Restaurant[Index].menu[index].name = text1;
                                        }
                                        if(text2 != ""){
                                          Restaurant[Index].menu[index].priceR = text2;
                                        }
                                      });
                                      Navigator.pop(context);
                                    },
                                      child: Text('Save Changes'),
                                    )
                                  ],
                                ),
                              )
                          );
                        })
                    );
                  },
                      child: Text('details',style: TextStyle(fontWeight: FontWeight.bold),)
                  ),
                  ElevatedButton(
                    onPressed: (){
                      setState(() {
                        Restaurant[Index].menu.removeAt(index);
                      });
                    },
                    child: Icon(Icons.delete),
                  )
                ],
              ),
              Divider(
                color: Theme.of(context).primaryColor,
              )
            ],
          );
        },
      ),
    );
  }
  Widget addMenu(){
    GlobalKey<FormState> _key = new GlobalKey();
    String text1="";
    String text2="";
    return Scaffold(
        appBar: AppBar(
          title: Text('Add Menu'),
        ),
        body: new Form(
          key: _key,
          child:  new Column(
              children: <Widget>[
                new SizedBox(height: 5.0),
                new TextFormField(
                  autofocus: false,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: 'Name',
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                  ),
                  onSaved: (String value){
                    text1 = value;
                  },
                ),
                new SizedBox(height: 10.0),
                new TextFormField(
                  keyboardType: TextInputType.phone,
                  autofocus: false,
                  decoration: InputDecoration(
                    hintText: 'Price',
                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                  ),
                  onSaved: (String value){
                    text2 = value;
                  },
                ),
                ElevatedButton(onPressed: (){
                  setState(() {
                    _key.currentState.save();
                    Restaurant[Index].menu.add(Menu(
                      name: text1,
                      priceR: text2,
                      available: false,
                      image: Image.asset('assets/images/welcome1.jpeg'),
                    ));

                  });
                  Navigator.pop(context);
                },
                    child:Text('Add')
                )
              ]
          ),
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Edit Menu',style: TextStyle(fontWeight: FontWeight.bold),),
        actions: [
          ElevatedButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => addMenu()));
          },
              child: Icon(Icons.add)
          )
        ],
      ),
      body: ShowMenu(),
    );
  }
}
////////manage comments////////////////
class ManageComments extends StatefulWidget {
  String comment;
  String answer;
  bool isAnswered = false;
  ManageComments({Key key,this.comment,this.answer,this.isAnswered}) : super(key: key);
  @override
  _ManageCommentsState createState() => _ManageCommentsState();
}

class _ManageCommentsState extends State<ManageComments> {
  GlobalKey<FormState> _key = new GlobalKey();
  String text = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Manage Comments'
        ),
      ),
      body: SingleChildScrollView(
        child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: Restaurant[Index].ThisComments.length,
          itemBuilder: (context,int index){
            return Padding(
              padding: EdgeInsets.all(10),
              child: Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ListTile(
                      title: Text(Restaurant[Index].ThisComments[index].comment,style: TextStyle(fontWeight: FontWeight.bold),),
                      trailing: Restaurant[Index].ThisComments[index].isAnswered ? Icon(Icons.done_outline) : Icon(Icons.cancel_presentation),
                    ),
                    !Restaurant[Index].ThisComments[index].isAnswered ?
                    ElevatedButton(
                      onPressed: (){
                        showModalBottomSheet(context: context, builder: (context){
                          return Padding(
                            padding: EdgeInsets.all(5),
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
                                              hintText: 'answer',
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
                                                Restaurant[Index].ThisComments[index].isAnswered = true;
                                                Restaurant[Index].ThisComments[index].answer = text;
                                                Navigator.pop(context);
                                                _key.currentState.save();
                                              });
                                            },
                                            child: Text('Done',style: TextStyle(fontWeight: FontWeight.bold),),
                                          )
                                        ])
                                )
                            ),
                          );
                        });
                      },
                      child: Text('Answer',style: TextStyle(fontWeight: FontWeight.bold),),
                    ) :
                    ElevatedButton(
                      onPressed: (){
                        showModalBottomSheet(context: context, builder: (context){
                          return Padding(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Card(
                                    child: ListTile(
                                      title: Text(Restaurant[Index].ThisComments[index].answer,style: TextStyle(fontWeight: FontWeight.bold,
                                          fontSize: 20),),
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: (){
                                      Navigator.pop(context);
                                    },
                                    child: Text('Done',style: TextStyle(fontWeight: FontWeight.bold),),
                                  )
                                ],
                              )
                          );
                        });
                      },
                      child: Text('Show Answer',style: TextStyle(fontWeight: FontWeight.bold),),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}



///////////////Ordering////////////////////
class Ordering extends StatefulWidget {
  @override
  _OrderingState createState() => _OrderingState();
}

class _OrderingState extends State<Ordering> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
/////////////////////////Dashboard////////////////
class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
////////////////////////////



