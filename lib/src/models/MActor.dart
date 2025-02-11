class Actors {
  List<MActor> cast = new List(); 
  Actors.fromJson(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final mMovie = new MActor.fromJson(item);
      cast.add(mMovie);
    }
  }
}

class MActor {
  int castId;
  String character;
  String creditId;
  int gender;
  int id;
  String name;
  int order;
  String profilePath;

  MActor({
      this.castId,
      this.character,
      this.creditId,
      this.gender,
      this.id,
      this.name,
      this.order,
      this.profilePath
  });

  MActor.fromJson(Map<String, dynamic> json) {
    castId = json['cast_id'];
    character = json['character'];
    creditId = json['credit_id'];
    gender = json['gender'];
    id = json['id'];
    name = json['name'];
    order = json['order'];
    profilePath = json['profile_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cast_id'] = this.castId;
    data['character'] = this.character;
    data['credit_id'] = this.creditId;
    data['gender'] = this.gender;
    data['id'] = this.id;
    data['name'] = this.name;
    data['order'] = this.order;
    data['profile_path'] = this.profilePath;
    return data;
  }

    getProfileImg(){
    return  profilePath!=null ? 'https://image.tmdb.org/t/p/w500/$profilePath' : 'data:image/png;base64,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';
  }
}