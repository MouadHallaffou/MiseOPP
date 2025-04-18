<?php

class Agence {
    use LoggerTrait;
    protected string $nom;
    protected string $ville;
    protected array $vehicules;
    protected array $clients;

    public function __construct($nom, $ville, $vehicules = [], $clients = [])
    {
        $this->nom = $nom;
        $this->ville = $ville;
        $this->vehicules = $vehicules;
        $this->clients = $clients;
    }

    public function ajouteVehicule($vehicule)
    {
        if ($vehicule) {
            $this->vehicules[] = $vehicule;  
        } else {
            echo "Aucun véhicule à ajouter.";
        }
    }

    public function rechercherVehiculeDisponible(string $type)
    {
        $resultats = [];

        foreach ($this->vehicules as $vehicule) {
            if ($vehicule->getType() === $type && $vehicule->estDisponible()) {
                $resultats[] = $vehicule;  
            }
        }

        return $resultats; 
    }

    public function enregistrerClient($client)
    {
        if ($client) {
            $this->clients[] = $client; 
        } else {
            echo "Client non valide.";
        }
    }

    public function faireReservation($client, $vehicule, $dateDebut, $nbJours)
    {
        if (!in_array($client, $this->clients)) {
            echo "Client non trouvé.";
            return;
        }

        if (!in_array($vehicule, $this->vehicules)) {
            echo "Véhicule non trouvé.";
            return;
        }

        if ($vehicule->estDisponible()) {
            $vehicule->reserver($client, $dateDebut, $nbJours);
            echo "Réservation réussie pour le véhicule : " . $vehicule->getImmatriculation();
        } else {
            echo "Le véhicule n'est pas disponible.";
        }
    }
}
