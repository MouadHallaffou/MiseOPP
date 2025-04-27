<?php 
class Book {
    public int $id; 
    public string $title; 
    public string $author; 
    public float $price;

    private static array $books = [];

    public function __construct($id, $title, $author, $price) {
        $this->id = $id;
        $this->title = $title;
        $this->author = $author;
        $this->price = $price;
    }

    public static function addBook(Book $book) {
        self::$books[] = $book;
    }

    public static function getBooks() {
        return self::$books;
    }

    public static function deleteBook($id) {
        foreach (self::$books as $index => $book) {
            if ($book->id === $id) {
                unset(self::$books[$index]);
                break;
            }
        }
    }
}

class Wishlist {
    private array $wishlist_items = [];

    public function addToWishlist(Book $book){
        $this->wishlist_items[] = $book;
    }

    public function removeFromWishlist($id){
        foreach ($this->wishlist_items as $index => $book) {
            if ($book->id === $id) {
                unset($this->wishlist_items[$index]);
                break;
            }
        }
    }

    public function displayWishlist(){
        echo "Liste des ouvrages dans la wishlist:<br>";
        foreach ($this->wishlist_items as $item) {
            echo "ID: {$item->id}, Titre: {$item->title}, Auteur: {$item->author}<br>";
        }
    }
}

class Cart {
    private array $cart_items = [];

    public function addToCart(Book $book){
        $this->cart_items[] = $book;
    }

    public function removeFromCart($id){
        foreach ($this->cart_items as $index => $book) {
            if ($book->id === $id) {
                unset($this->cart_items[$index]);
                break;
            }
        }
    }

    public function displayCart(){
        echo "Liste des ouvrages dans le panier:<br>";
        foreach ($this->cart_items as $item) {
            echo "ID: {$item->id}, Titre: {$item->title}, Auteur: {$item->author}<br>";
        }
    }

    public function getTotalPrice(){
        $total = 0;
        foreach ($this->cart_items as $item) {
            $total += $item->price;
        }
        return $total;
    }
}


$book1 = new Book(1, 'React Avancé', 'Mouad Hallaffou', 19.99);
$book2 = new Book(2, 'Laravel pour les pros', 'Mouad Hallaffou', 25.50);

Book::addBook($book1);
Book::addBook($book2);

$wishlist = new Wishlist();
$wishlist->addToWishlist($book1);
$wishlist->displayWishlist();

$cart = new Cart();
$cart->addToCart($book2);
$cart->displayCart();
echo "Total: " . $cart->getTotalPrice() . " $";
