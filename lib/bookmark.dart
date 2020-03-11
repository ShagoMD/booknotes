class Bookmark {
  String book;
  String note;

  Bookmark(this.book, this.note);

  static List<Bookmark> getData() {
    return [
      Bookmark("Harry Potter", "Harry ataco a los pobres"),
      Bookmark("Cochinito Pobre", "Hay que ahorrar dinero"),
      Bookmark("Historia", "Mexico tuvo muchas peleas"),
    ];
  }
}
