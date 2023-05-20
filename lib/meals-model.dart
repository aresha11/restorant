class Meals{

  String? name;
  String? vitamin;
  String? weight;
  String? calories;
  String? available;


  Meals();

   Meals.fromMap(Map<String, dynamic> map) {

      name= map['name'] ;
      vitamin= map['vitamine'] ;
      weight= map['weight'] ;
      calories= map['calories'] ;
      available= map['available'] ;

  }
}