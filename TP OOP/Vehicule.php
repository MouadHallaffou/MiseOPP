<?php

abstract class Vehicule
{
    protected int $id;
    protected string $immatriculation;
    protected string $marque;
    protected string $modele;
    protected float $prixJour;
    protected bool $disponible;
    protected string $type;


    public function __construct(
        int $id, 
        string $immatriculation, 
        string $marque, 
        string $modele, 
        float $prixJour, 
        bool $disponible, 
        string $type
    ) {
        $this->id = $id;
        $this->immatriculation = $immatriculation;
        $this->marque = $marque;
        $this->modele = $modele;
        $this->prixJour = $prixJour;
        $this->disponible = $disponible;
        $this->type = $type;
    }

    public function getImmatriculation(): string
    {
        return $this->immatriculation;
    }

    public function afficherDetails(): void
    {
        echo "Immatriculation: {$this->immatriculation}\n";
        echo "Marque: {$this->marque},\n";
        echo "Modèle: {$this->modele},\n";
        echo "Prix par jour: {$this->prixJour}, MAD\n";
        echo "Disponible: " . ($this->disponible ? "Oui" : "Non") . "," . "\n";
    }

    public function calculerPrix(int $jours): float
    {
        return $this->prixJour * $jours;
    }

    public function estDisponible(): bool
    {
        return $this->disponible;
    }

    public abstract function getType(): string;

}
