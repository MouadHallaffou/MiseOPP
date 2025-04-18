<?php

require_once 'Personne.php';

class Client extends Personne {
    protected int $numeroClient;
    protected array $reservations;
    protected DateTime $reserveAt;
    protected DateTime $sortAt;

    public function __construct(int $numeroClient, array $reservations, DateTime $reserveAt, DateTime $sortAt, int $id, string $nom, string $prenom, string $email)
    {
        parent::__construct($id, $nom, $prenom, $email);
        $this->numeroClient = $numeroClient;
        $this->reservations = $reservations;
        $this->reserveAt = $reserveAt;
        $this->sortAt = $sortAt;
    }

    public function afficherProfil(): string
    {
        return "Nom : $this->nom, Prénom : $this->prenom, Email : $this->email, Numéro Client : $this->numeroClient";
    }

    public function ajouterReservation(Reservation $reservation): void
    {
        $this->reservations[] = $reservation;
    }

    public function getHistorique(): string
    {
        $interval = $this->reserveAt->diff($this->sortAt);
        $durre = $interval->days; 
        return "Le client avec l'ID : $this->id, a réservé le : " . $this->reserveAt->format('Y-m-d') . ", a quitté le : " . $this->sortAt->format('Y-m-d') . ", pour une durée de : $durre jours.";
    }

    public function getNumeroClient(): int
    {
        return $this->numeroClient;
    }

    public function getReservations(): array
    {
        return $this->reservations;
    }

    public function getReserveAt(): DateTime
    {
        return $this->reserveAt;
    }

    public function getSortAt(): DateTime
    {
        return $this->sortAt;
    }
}
