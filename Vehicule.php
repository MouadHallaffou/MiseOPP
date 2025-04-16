<?php

abstract class Vehicule
{
    protected $id;
    protected $immatriculation;
    protected $marque;
    protected $modele;
    protected $prixJour;
    protected $disponible;
    protected string $type;

    public function __construct($id, $immatriculation, $marque, $modele, $prixJour,$type,$disponible)
    {
        $this->id = $id;
        $this->immatriculation = $immatriculation;
        $this->marque = $marque;
        $this->modele = $modele;
        $this->prixJour = $prixJour;
        $this->disponible = $disponible;
        $this->type = $type;
    }

    public function getImmatriculation(){
        return $this->immatriculation;
    }


    public function afficherDetails() {}

    public function calculerPrix(int $jours) {}

    public function estDisponible() {}

    public abstract function  getType();
}
