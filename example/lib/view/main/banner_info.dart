/// list : [{"articleType":1,"createTime":1619664833000,"delFlag":1,"id":36,"imageUrl":"https://lcatluo.oss-cn-shenzhen.aliyuncs.com/img/20210429105351.png","isShow":1,"jumpType":1,"jumpUrl":"2","sort":2,"title":"安卓轮播图测试2","typeid":1},{"articleType":1,"createTime":1619664810000,"delFlag":1,"id":35,"imageUrl":"https://lcatluo.oss-cn-shenzhen.aliyuncs.com/img/20210429105325.png","isShow":1,"jumpType":1,"jumpUrl":"1","sort":1,"title":"安卓轮播图测试","typeid":1}]
/// page : {"pageNo":1,"pageSize":30,"startLoc":0,"totalNum":2,"totalPage":1}

class BannerInfo {
  List<UrlInfo>? list;
  Page? page;

  BannerInfo({
    this.list,
    this.page});

  BannerInfo.fromJson(dynamic json) {
    if (json['list'] != null) {
      list = [];
      json['list'].forEach((v) {
        list?.add(UrlInfo.fromJson(v));
      });
    }
    page = json['page'] != null ? Page.fromJson(json['page']) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (list != null) {
      map['list'] = list?.map((v) => v.toJson()).toList();
    }
    if (page != null) {
      map['page'] = page?.toJson();
    }
    return map;
  }

}

/// pageNo : 1
/// pageSize : 30
/// startLoc : 0
/// totalNum : 2
/// totalPage : 1

class Page {
  int? pageNo;
  int? pageSize;
  int? startLoc;
  int? totalNum;
  int? totalPage;

  Page({
    this.pageNo,
    this.pageSize,
    this.startLoc,
    this.totalNum,
    this.totalPage});

  Page.fromJson(dynamic json) {
    pageNo = json['pageNo'];
    pageSize = json['pageSize'];
    startLoc = json['startLoc'];
    totalNum = json['totalNum'];
    totalPage = json['totalPage'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['pageNo'] = pageNo;
    map['pageSize'] = pageSize;
    map['startLoc'] = startLoc;
    map['totalNum'] = totalNum;
    map['totalPage'] = totalPage;
    return map;
  }

}

/// articleType : 1
/// createTime : 1619664833000
/// delFlag : 1
/// id : 36
/// imageUrl : "https://lcatluo.oss-cn-shenzhen.aliyuncs.com/img/20210429105351.png"
/// isShow : 1
/// jumpType : 1
/// jumpUrl : "2"
/// sort : 2
/// title : "安卓轮播图测试2"
/// typeid : 1

class UrlInfo {
  int? articleType;
  int? createTime;
  int? delFlag;
  int? id;
  String? imageUrl;
  int? isShow;
  int? jumpType;
  String? jumpUrl;
  int? sort;
  String? title;
  int? typeid;

  UrlInfo({
    this.articleType,
    this.createTime,
    this.delFlag,
    this.id,
    this.imageUrl,
    this.isShow,
    this.jumpType,
    this.jumpUrl,
    this.sort,
    this.title,
    this.typeid});

  UrlInfo.fromJson(dynamic json) {
    articleType = json['articleType'];
    createTime = json['createTime'];
    delFlag = json['delFlag'];
    id = json['id'];
    imageUrl = json['imageUrl'];
    isShow = json['isShow'];
    jumpType = json['jumpType'];
    jumpUrl = json['jumpUrl'];
    sort = json['sort'];
    title = json['title'];
    typeid = json['typeid'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['articleType'] = articleType;
    map['createTime'] = createTime;
    map['delFlag'] = delFlag;
    map['id'] = id;
    map['imageUrl'] = imageUrl;
    map['isShow'] = isShow;
    map['jumpType'] = jumpType;
    map['jumpUrl'] = jumpUrl;
    map['sort'] = sort;
    map['title'] = title;
    map['typeid'] = typeid;
    return map;
  }

}