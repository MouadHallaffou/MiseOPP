<?php 
class Book {
    private int $id; 
    private string $title; 
    private string $author; 
    private float $price;

    public function __construct(int $id, string $title, string $author, float $price) {
        $this->id = $id;
        $this->title = $title;
        $this->author = $author;
        $this->price = $price;
    }

    public function getId(): int {
        return $this->id;
    }

    public function getTitle(): string {
        return $this->title;
    }

    public function getAuthor(): string {
        return $this->author;
    }

    public function getPrice(): float {
        return $this->price;
    }
}

class Library {
    private array $books = [];

    public function addBook(Book $book): void {
        $this->books[] = $book;
    }

    public function getBooks(): array {
        return $this->books;
    }

    public function deleteBook(int $id): void {
        foreach ($this->books as $index => $book) {
            if ($book->getId() === $id) {
                unset($this->books[$index]);
                $this->books = array_values($this->books);
                break;
            }
        }
    }
}

class Wishlist {
    private array $wishlist_items = [];

    public function addToWishlist(Book $book): void {
        $this->wishlist_items[] = $book;
    }

    public function removeFromWishlist(int $id): void {
        foreach ($this->wishlist_items as $index => $book) {
            if ($book->getId() === $id) {
                unset($this->wishlist_items[$index]);
                $this->wishlist_items = array_values($this->wishlist_items);
                break;
            }
        }
    }

    public function displayWishlist(): void {
        echo "Liste de la wishlist :<br>";
        foreach ($this->wishlist_items as $book) {
            echo "ID: {$book->getId()}, Titre: {$book->getTitle()}, Auteur: {$book->getAuthor()}<br>";
        }
    }
}

class Cart {
    private array $cart_items = [];

    public function addToCart(Book $book): void {
        $this->cart_items[] = $book;
    }

    public function removeFromCart(int $id): void {
        foreach ($this->cart_items as $index => $book) {
            if ($book->getId() === $id) {
                unset($this->cart_items[$index]);
                $this->cart_items = array_values($this->cart_items);
                break;
            }
        }
    }

    public function displayCart(): void {
        echo "Contenu du panier :<br>";
        foreach ($this->cart_items as $book) {
            echo "ID: {$book->getId()}, Titre: {$book->getTitle()}, Auteur: {$book->getAuthor()}<br>";
        }
    }

    public function getTotalPrice(): float {
        $total = 0;
        foreach ($this->cart_items as $book) {
            $total += $book->getPrice();
        }
        return $total;
    }
}

$library = new Library();

$book1 = new Book(1, 'React Avancé', 'Mouad Hallaffou', 19.99);
$book2 = new Book(2, 'Laravel pour les pros', 'Mouad Hallaffou', 25.50);

$library->addBook($book1);
$library->addBook($book2);

$wishlist = new Wishlist();
$wishlist->addToWishlist($book1);
$wishlist->displayWishlist();

$cart = new Cart();
$cart->addToCart($book2);
$cart->displayCart();
echo "Prix total : " . $cart->getTotalPrice() . " €";
