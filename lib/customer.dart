import 'package:clienttelling/recommendation.dart';

class Customer {
  String firstName;
  String lastName;
  List<Recommendation> recs = new List<Recommendation>();

  Customer(this.firstName, this.lastName, this.recs);

  String fullName() {
    return firstName + " " + lastName;
  }
}
