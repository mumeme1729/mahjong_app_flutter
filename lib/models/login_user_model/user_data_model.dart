//ログインしているユーザーのデータモデル
class LoginUserData {
  LoginUserData(this.nickName, this.image, this.rank1, this.rank2, this.rank3,
      this.rank4, this.gameCnt, this.score);
  String? nickName;
  String? image;
  int? rank1;
  int? rank2;
  int? rank3;
  int? rank4;
  int? score;
  int? gameCnt;
}

// class GroupData {
//   GroupData(this.password, this.id, this.text, this.createdAt, this.title,
//       this.image, this.updateAt);
//   String? password;
//   String? id;
//   String? text;
//   String? createdAt;
//   String? title;
//   String? image;
//   String? updateAt;
// }
