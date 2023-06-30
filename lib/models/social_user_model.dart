class SocialUserModel {
  String? name;
  String? email;
  String? phone;
  String? uId;
  String? image;
  String? bio;
  bool? isEmailVerified;

  SocialUserModel({
     this.email,
     this.name,
     this.phone,
     this.uId,
    this.image,
    this.bio,

    this.isEmailVerified,
  });

  SocialUserModel.fromJson(Map<String, dynamic> json)
  {
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    uId = json['uId'];
    uId = json['image'];
    uId = json['bio'];

    isEmailVerified = json['isEmailVerified'];
  }

  Map<String, dynamic> toMap()
  {
    return {
      'name':name,
      'email':email,
      'phone':phone,
      'image':image,
      'bio':bio,
      'isEmailVerified':isEmailVerified,
    };
  }
}