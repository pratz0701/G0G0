class users{


  final String email;
  final String uid;
  final String name;



  users({this.name, this.email, this.uid});



  factory users.fromMap( Map data){
    data = data ?? { };
    return users(
        email: data['email'] ?? '',
        uid: data['uid'] ?? '',
        name: data['displayName']??''

    );
  }
}




