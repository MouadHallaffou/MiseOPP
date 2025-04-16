<?php

require_once 'Vehicule.php';
require_once 'ReservableInterface.php';

class Voiture extends Vehicule implements ReservableInterface{
    protected int $nbPortes;
    protected int $transmission;

    public function __construct($id, $immatriculation, $marque, $modele,$transmission,$prixJour, $disponible,$nbPortes)
    {
        parent::__construct($id, $immatriculation, $marque, $modele, $prixJour, $disponible);
        $this->nbPortes = $nbPortes;
        $this->transmission = $transmission;
    }

    public function reserver($client, $dateDebut, int $nbJours){
        if(empty($immatriculation)){
            return " le client avec l'id : $this->id , et le name : $client, reserve apartir de : $dateDebut, devant : $nbJours";
        }else {
            return "la voiture demande ni pas disponible a ce moment";
        }   
    }

    public function afficherDetails() {
        return "immatriculation : $this->immatriculation, marque : $this->marque, modele : $this->modele, prixJour : $this->prixJour, disponible : $this->disponible, nbPortes: $this->nbPortes";
    }
  
    public function  getTransmission(){
        return " le transmission du voiture est : $this->transmission";
    }

    public function  getType(){
        return " le type du voiture est : $this->type";
    }

}