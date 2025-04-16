<?php 

abstract class Personne {
    protected $id;
    protected $nom; 
    protected $prenom; 
    protected $email;

    public function __construct($id, $nom, $prenom, $email)
    {
        $this->id = $id;
        $this->nom = $nom;
        $this->prenom = $prenom;
        $this->email = $email;
    }

    public abstract function afficherProfil();
}