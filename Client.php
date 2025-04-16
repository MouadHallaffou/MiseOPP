<?php

require_once 'Personne.php';

class Client extends Personne{
    protected int $numeroClient;
    protected array $reservations;
    protected $reserveAt;
    protected $sortAt;

    public function __construct($numeroClient, $reservations,$reserveAt, $sortAt, $id, $nom, $prenom, $email)
    {
        parent::__construct($id, $nom, $prenom, $email);
        $this->numeroClient = $numeroClient;
        $this->reservations = $reservations;
        $this->reserveAt = $reserveAt;
        $this->reserveAt = $ $sortAt;
    }

    public function afficherProfil()
    {
        return "nom : $this->nom, prenom: $this->prenom, email: $this->email";
    }

    public function ajouterReservation($resrve){
        if(!empty($reservations)){
            $this->reservations.array_push($resrve, $this->id, $this->nom, $this->prenom, $this->email);
        }
    }

    public function getHistorique(){
        $durre = $this->sortAt - $this->reserveAt;
        return " le client avec l'id : $this->id ,..., rerve le : $this->reserveAt, quite le : $this-> sortAt une dure de : $durre j";
    }

}