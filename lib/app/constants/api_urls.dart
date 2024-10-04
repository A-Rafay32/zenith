const BASEURL = "https://api.spaceflightnewsapi.net";

class APIUrls {
  static String getArticles = "/v4/articles/";

  static String getArticleById(int id) {
    return "/v4/articles/$id";
  }
}
