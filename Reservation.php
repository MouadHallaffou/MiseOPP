<?php

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
        $this->client =  $client;
        $this->dateDebut = $dateDebut;
        $this->nbJours = $nbJours;
        $this->status = $status;
    }


    public function calculerMontant($price) {
        $montant = $price * $this->nbJours;
        return " le montant total a paye est $montant"; 
    }

    public function confirmer(){
        return $this->status === "accepted";
    }

    public function annuler(){
        return $this->status === "annuler";
    }

    public function logAction($message){
        echo " hello world ";
    }
}
