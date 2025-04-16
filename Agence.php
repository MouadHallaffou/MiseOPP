<?php

class Agence {
    use LoggerTrait;
    protected string $nom;
    protected string $ville;
    protected array $vehicules;
    protected array $clients;

    public function __construct($nom, $ville, $vehicules, $clients)
    {
        $this->nom = $nom;
        $this->ville = $ville;
        $this->vehicules = $vehicules;
        $this->clients = $clients;
    }

    public function ajouteVehicule($vehicule){
        if(!$vehicule){
            $this->vehicules.array_push($vehicule);
        }else{
            echo "aucun vehucule a ce nom";
        }
    }

    public function rechercherVehiculeDisponible(string $type){
        if($type === $this->nom){
            return "$this->nom";
        }else{
            return [];
        }
    }

    public function enregistrerClient($client){
        if($client){
            $this->clients.array_push($client);
        }
    }

    public function faireReservation($client, $vehicule, $dateDebut, $nbJours){}

}