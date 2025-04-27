<?php
// Gestion des events
// User peut créer un profil avec ses infos personnelles.
// Event possède des détails (id, nom, description, capacity) avec une capacité maximale de participants.
// Booking permet aux users de s'inscrire à un event, avec le respect de la capacité maximale.
// Organizer gère la création et la visualisation des events 

class User
{
    protected int $id;
    protected string $name;
    protected string $email;
    public array $users = [];

    public function create($id, $name, $email)
    {
        $data = ([
            'id' => $id,
            'name' => $name,
            'email' => $email,
        ]);
        return $this->users[] = $data;
        // print_r($users);
    }

    public function getProfile($id)
    {
        // echo"id:" . $id;
        // print_r($this->users);
        foreach ($this->users as  $user) {

            if ($user['id'] === $id) {
                echo "votre profile: \n";
                echo "id: " . $user['id'] . "name: " . $user['name'] . "email: " . $user['email'];
            } else {
                echo " users not";
            }
        }
    }
}
$user = new User();
$user->create(1, "mouad", "mouad@gmail.com");
$user->getProfile(1);

class Event{
    protected int $id;
    protected string $nom;
    protected string $description;
    protected int $capacity;
    protected array $events = [];

    public function displayEvent($id){
        foreach ($this->events as $event) {
            if($event['id'] == $id){
            echo"all event ";
            echo" id :" . $event['id'] . "nom :" . $event['nom'] . "description: " . $event['description'];
        }else{
            echo "aucaun evenement dispo";
        }
    }
    }
}

$event = new Event();
$event->displayEvent(1);

class Organizer extends User {

    public function createEvent(int $id, string $nom, string $description, int $capacity){
        $data = ([
            'id' => $id,
            'nom' => $nom, 
            'description' => $description,
            'capacity' => $capacity,
        ]);
        return array_push($this->events , $data);
    }
}

class Booking {
    protected array $participants = [];

    public function reserve(){

    }
}