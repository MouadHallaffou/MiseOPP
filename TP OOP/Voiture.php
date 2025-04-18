<?php

require_once 'Vehicule.php';
require_once 'ReservableInterface.php';

class Voiture extends Vehicule implements ReservableInterface
{
    protected int $nbPortes;
    protected string $transmission;

    public function __construct(int $id, string $immatriculation, string $marque, string $modele, string $transmission, float $prixJour, bool $disponible, int $nbPortes)
    {
        parent::__construct($id, $immatriculation, $marque, $modele, $prixJour, $disponible, 'Voiture');
        $this->nbPortes = $nbPortes;
        $this->transmission = $transmission;
    }

    public function reserver(Client $client, DateTime $dateDebut, int $nbJours): Reservation
    {
        if ($this->estDisponible()) {
            $reservation = new Reservation($this, $client, $dateDebut, $nbJours, 'En attente');
            return $reservation;
        } else {
            echo "La voiture n'est pas disponible à ce moment.\n";
            return null;
        }
    }

    public function afficherDetails(): void
    {
        parent::afficherDetails();
        echo "Nombre de portes: {$this->nbPortes}\n";
        echo "Transmission: {$this->transmission}\n";
    }

    public function getTransmission(): string
    {
        return "La transmission de la voiture est : {$this->transmission}";
    }

    public function getType(): string
    {
        return 'Voiture';
    }
}
