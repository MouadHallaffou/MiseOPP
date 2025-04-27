<pre>
<?php
// Class Product
// attrs: associative array: products contain keys: id, name, price
// methods: add_product(); delete_product($id); get_products()

class Product {
    private array $products=[];

    public function add_product($id, $name, $price) {
        $product = [
            'id' => $id,
            'name' => $name,
            'price' => $price
        ];
        $this->products[] = $product; 
        return $this->products;
    }

    public function delete_product($id){
        foreach ($this->products as $key => $product) {
            if($product['id'] === $id){
                unset($this->products[$key]);
                break;
            }
        }
    }

    public function get_all_products() {
        return $this->products;
    }
    
    public function get_products(){
        echo "<h1>informations products</h1>";
        foreach ($this->products as $product) {
           echo"book :$product[id] est:<li>id: $product[id]</li>";
           echo"<li>name: $product[name]</li>";
           echo"<li>price : $product[price]</li>";
           echo"<br>";
        }
    }
}

$product = new Product;
$product->add_product(1, 'book1', 10);
$product->add_product(2, 'book2', 15);
$product->add_product(3, 'book3', 13.2);
$product->delete_product(4);
$product->get_products();

print_r($product);


// class Cart
// attr: cart_list = []
// methods: add_to_cart(), display_cart(); get_total_price($cart_list)
class Cart {
    private array $cart_list = [];

    public function add_to_cart(Product $product) {
        foreach ($product->get_all_products() as $item) {
            return $this->cart_list[] = $item;
        }
    }

    public function display_cart(){
        echo "<h1>all products</h1>";
        foreach ($this->cart_list as $item) {
            echo"<li>$item[name]</li>";
            echo"<li>$item[price]</li>";
            echo"<br>";
        }
    }

    public function get_total_price(){
        $total = 0;
        foreach ($this->cart_list as $cart) {
            $total += $cart['price'];
        }
        return "le total est :" . $total; 
    }
}

$cart = new Cart;
$cart->add_to_cart($product);
$cart->add_to_cart($product);
$cart->add_to_cart($product);
$cart->display_cart();
echo $cart->get_total_price(); echo"<br>";
echo"<br>";
print_r($cart);
?>
</pre>