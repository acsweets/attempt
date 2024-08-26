
// 枚举的必要性在于 路由使用name  跳转要使用path

enum AppRoutes {
  root("/","/"),
  home("home","/home"),
  aboutMe("aboutMe","/aboutMe"),
  article("article","/article"),
  messageBoards("messageBoards","/messageBoards"),
  photoStories("photoStories","/photoStories"),
  error("404","/404"),
  animation("animation","/animation"),
  example("example","/example"),

  ;
  final String name;
  final String path;

  const AppRoutes(this.name, this.path);
}
