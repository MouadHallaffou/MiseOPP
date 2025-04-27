<?php 
class Book {
    protected int $id; 
    protected string $title; 
    protected string $author; 
    protected float $price;
    protected array $books = [];

    public function add_book($id, $title, $author, $price) {
        $data = ([
            'id' => $id,
            'title' => $title,
            'author' => $author,
            'price' => $price,
        ]);
        return $this->books [] = $data;
    }

    public function get_books() {
        foreach ($this->books as $book) {
            echo"listes books <br>";
            echo"id: " . $book['id'] . ", title: " . $book['title'];
        }
    }

    public function delete_book($id) {
        foreach ($this->books['id'] as $key => $book) {
            if($book['id'] === $id){
            unset($this->book['id']);
        }
        }
        
    }

}

class Wishlist {
    protected array $wishlist_items = [];

    public function add_to_wishlist(Book $book){
        $book = new Book();
        return $this->wishlist_items[] = $book;
    }

    public function remove_from_wishlist($id){
        foreach ($this->wishlist_items['id'] as $book) {
            if($book['id'] === $id){
            unset($this->book['id']);
        }
        }
    }

    public function display_wishlist(){
        foreach ($this->wishlist_items as $item) {
            echo"liste des articles";
            echo"id: " . $item['id'] . "title: " . $item['title'] . "author: " . $item['author'];
        }
    }

}

class Cart {
    protected array $cart_items  =[];

    public function add_to_cart($book){
        return $this->cart_items[] = $book;
    }

    public function remove_from_cart($id){
        foreach ($this->cart_items['id'] as $book) {
            if($book['id'] === $id){
            unset($this->book['id']);
        }
        }
    }

    public function display_cart(){
        foreach ($this->cart_items as $item) {
            echo"la listes des ouvrages";
            echo"id: " . $item['id'] . "title: " . $item['title'] . "author: " . $item['author'];
        }
    }

    public function get_total_price(){
        $total = 0;
        foreach ($this->cart_items as $price) {
            $total += $price['price'];
        }
        return $total;
    }

}

$ebook = new Book();
$ebook->add_book(1, 'React Avancé', 'Mouad Hallaffou', 19.99);
$ebook->add_book(2, 'Laravel pour les pros', 'Mouad Hallaffou', 25.50);

$wishlist = new Wishlist();
$wishlist->add_to_wishlist($ebook->get_books()[1]);

$cart = new Cart();
$cart->add_to_cart($ebook->get_books()[1]);
echo $cart->get_total_price();
