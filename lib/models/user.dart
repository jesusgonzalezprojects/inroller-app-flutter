class User {
    String name;
    String lastName;
    String email;
    String password;
    String passwordConfirmation;
    String phone;
    User({this.name, this.email, this.password,this.lastName,this.phone,this.passwordConfirmation});
    factory User.fromJson(Map<String, dynamic> json) {
        return User(
        name: json['name'],
        email: json['email'],
        password: json['password'],
        passwordConfirmation: json['passwordConfirmation'],
        lastName: json['lastName'],
        phone: json['phone']
        );
    }
}

class UserCredential {
    String usernameOrEmail;
    String password;
    UserCredential({this.usernameOrEmail, this.password});
}
