<?php
require_once 'Vehicule.php';
require_once 'ReservableInterface.php';

class Moto extends Vehicule implements ReservableInterface
{
    protected int $cylindree;

    public function __construct(int $id, string $immatriculation, string $marque, string $modele, float $prixJour, bool $disponible, int $cylindree)
    {
        parent::__construct($id, $immatriculation, $marque, $modele, $prixJour, $disponible, 'Moto');
        $this->cylindree = $cylindree;
    }

    public function reserver(Client $client, DateTime $dateDebut, int $nbJours): Reservation
    {
        if ($this->estDisponible()) {
            $reservation = new Reservation($this, $client, $dateDebut, $nbJours, 'En attente');
            return $reservation;
        } else {
            echo "La moto n'est pas disponible à ce moment.\n";
            return null;
        }
    }

    public function afficherDetails(): void
    {
        parent::afficherDetails();
        echo "Cylindrée: {$this->cylindree}\n";
    }

    public function getCylindree(): string
    {
        return "La cylindrée de la moto est : {$this->cylindree}cc";
    }

    public function getType(): string
    {
        return 'Moto';
    }
}
