class events{


  final String drugs;
  final String molestation;
  final String murder;
  final String other;
  final String robbery;



  events({this.drugs, this.molestation, this.murder, this.other, this.robbery, });



  factory events.fromMap( Map data){
    data = data ?? { };
    return events(
        drugs: data['Drugs'] ?? '',
        molestation: data['Molestation'] ?? '',
        murder: data['Murder']??'',
        other: data['Other']??'',
        robbery: data['Robbery']??''

    );
  }
}




