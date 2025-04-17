<?php
require_once 'LoggerTrait.php';

class Reservation
{
    use LoggerTrait; 

    protected $vehicule;
    protected $client;
    protected $dateDebut;
    protected $nbJours;
    protected $status;

    public function __construct($vehicule, $client, $dateDebut, $nbJours, $status)
    {
        $this->vehicule = $vehicule;
        $this->client = $client;
        $this->dateDebut = $dateDebut;
        $this->nbJours = $nbJours;
        $this->status = $status;
    }

    public function calculerMontant() {
        $montant = $this->vehicule->prixJour * $this->nbJours; 
        $this->logAction("Calcul du montant pour la réservation : $montant"); 
        return "Le montant total à payer est : $montant"; 
    }

    public function confirmer() {
        return $this->status === "accepted";
    }

    public function annuler() {
        return $this->status === "cancelled";
    }
}
