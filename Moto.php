<?php
require_once 'Vehicule.php';
require_once 'ReservableInterface.php';

class Moto extends Vehicule implements ReservableInterface{
    protected int $cylindree;

    public function __construct($id, $immatriculation, $marque, $modele,$type,$prixJour, $disponible,$cylindree)
    {
        parent::__construct($id, $immatriculation, $marque, $modele,$type, $prixJour, $disponible);
        $this->cylindree = $cylindree;
    }

    public function reserver($client, $dateDebut, int $nbJours){
        if(empty($immatriculation)){
            return " le client avec l'id : $this->id , et le name : $client, reserve apartir de : $dateDebut, devant : $nbJours";
        }else {
            return "la moto demande ni pas disponible a ce moment";
        }   
    }

    public function afficherDetails() {
        return "immatriculation : $this->immatriculation, marque : $this->marque, modele : $this->modele, prixJour : $this->prixJour, disponible : $this->disponible, cylindree: $this->cylindree";
    }
  
    public function  getType(){
        return " le type du moto est : $this->type";
    }
}