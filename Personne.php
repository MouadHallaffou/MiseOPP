<?php 

abstract class Personne {
    protected int $id;
    protected string $nom;
    protected string $prenom;
    protected string $email;

    public function __construct(int $id, string $nom, string $prenom, string $email)
    {
        $this->id = $id;
        $this->nom = $nom;
        $this->prenom = $prenom;
        $this->email = $email;
    }

    public function getId(): int {
        return $this->id;
    }

    public function getNom(): string {
        return $this->nom;
    }

    public function getPrenom(): string {
        return $this->prenom;
    }

    public function getEmail(): string {
        return $this->email;
    }

    public abstract function afficherProfil(): string;
}
