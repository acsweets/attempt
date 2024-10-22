// 书架接口
abstract class Bookshelf {
   late List<String> books;
  void displayBooks();
}

// 具体书架实现
class WoodenBookshelf implements Bookshelf {


  @override
  void displayBooks() {
    print("Wooden Bookshelf contains: ${books.join(', ')}");
  }

  @override
  List<String> books=[];
}

class MetalBookshelf implements Bookshelf {
  @override
  List<String> books=[];

  @override
  void displayBooks() {
    print("Metal Bookshelf contains: ${books.join(', ')}");
  }
}

// 书抽象类
abstract class Book {
  String title;
  Bookshelf bookshelf;

  Book(this.title, this.bookshelf);

  void putOnShelf();
}

// 具体书实现
class Novel extends Book {
  Novel(super.title, super.bookshelf);

  @override
  void putOnShelf() {
    bookshelf.displayBooks();
    bookshelf.books.add(title);
    print("Putting novel '$title' on shelf.");
  }
}

class TechnicalBook extends Book {
  TechnicalBook(String title, Bookshelf bookshelf) : super(title, bookshelf);

  @override
  void putOnShelf() {
    bookshelf.displayBooks();
    bookshelf.books.add(title);
    print("Putting technical book '$title' on shelf.");
  }
}

// 客户端代码
void main() {
  Bookshelf woodenBookshelf = WoodenBookshelf();
  Bookshelf metalBookshelf = MetalBookshelf();

  Book novel = Novel("The Great Gatsby", woodenBookshelf);
  Book techBook = TechnicalBook("Dart Programming", metalBookshelf);

  novel.putOnShelf(); // 放置小说
  techBook.putOnShelf(); // 放置技术书

  woodenBookshelf.displayBooks(); // 输出木质书架上的书
  metalBookshelf.displayBooks(); // 输出金属书架上的书
}