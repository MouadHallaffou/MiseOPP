<?php
require_once 'Vehicule.php';
require_once 'ReservableInterface.php';

class Camion extends Vehicule implements ReservableInterface
{
    protected float $capaciteTonnage;

    public function __construct(int $id, string $immatriculation, string $marque, string $modele, float $prixJour, bool $disponible, float $capaciteTonnage)
    {
        parent::__construct($id, $immatriculation, $marque, $modele, $prixJour, $disponible, 'Camion');
        $this->capaciteTonnage = $capaciteTonnage;
    }

    public function reserver(Client $client, DateTime $dateDebut, int $nbJours): Reservation
    {
        if ($this->estDisponible()) {
            $reservation = new Reservation($this, $client, $dateDebut, $nbJours, 'En attente');
            return $reservation;
        } else {
            echo "Le camion n'est pas disponible à ce moment.\n";
            return null;
        }
    }

    public function afficherDetails(): void
    {
        parent::afficherDetails();
        echo "Capacité de tonnage: {$this->capaciteTonnage} tonnes\n";
    }

    public function getCapaciteTonnage(): string
    {
        return "La capacité du camion est : {$this->capaciteTonnage} tonnes";
    }

    public function getType(): string
    {
        return 'Camion';
    }
}
