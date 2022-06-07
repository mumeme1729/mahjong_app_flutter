//ログインしているユーザーのデータモデル

class GroupData {
  GroupData(this.password, this.id, this.text, this.createdAt, this.title,
      this.image, this.updateAt);
  String? password;
  String? id;
  String? text;
  String? createdAt;
  String? title;
  String? image;
  String? updateAt;
}
