// To parse this JSON data, do
//
//     final userProfile = userProfileFromJson(jsonString);

import 'dart:convert';

UserProfile userProfileFromJson(String str) => UserProfile.fromJson(json.decode(str));

String userProfileToJson(UserProfile data) => json.encode(data.toJson());

class UserProfile {
    UserProfile({
        this.profileUser,
    });

    ProfileUser profileUser;

    factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        profileUser: ProfileUser.fromJson(json["profile_user"]),
    );

    Map<String, dynamic> toJson() => {
        "profile_user": profileUser.toJson(),
    };
}

class ProfileUser {
    ProfileUser({
        this.id,
        this.name,
        this.lastName,
        this.email,
        this.status,
        this.emailVerifiedAt,
        this.subscription,
    });

    int id;
    String name;
    String lastName;
    String email;
    bool status;
    DateTime emailVerifiedAt;
    dynamic subscription;

    factory ProfileUser.fromJson(Map<String, dynamic> json) => ProfileUser(
        id: json["id"],
        name: json["name"],
        lastName: json["last_name"],
        email: json["email"],
        status: json["status"] == 1 ? true : false,
        emailVerifiedAt: DateTime.parse(json["email_verified_at"]),
        subscription: json["subscription"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "last_name": lastName,
        "email": email,
        "status": status,
        "email_verified_at": emailVerifiedAt.toIso8601String(),
        "subscription": subscription,
    };
}
