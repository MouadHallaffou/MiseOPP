<?php

class User {
    protected int $id;
    protected string $nom;
    protected string $email;
    protected string $role;

    public function __construct(int $id, string $nom, string $email, string $role) {
        $this->id = $id;
        $this->nom = $nom;
        $this->email = $email;
        $this->role = $role;
    }

    public function afficheDetails(): string {
        return "ID: {$this->id}, Nom: {$this->nom}, Email: {$this->email}, Rôle: {$this->role}";
    }
}

class Developer extends User {
    public function getNom(): string {
        return $this->nom;
    }
}

class Task {
    protected int $id;
    protected string $status;
    protected Developer $developpeur;

    public function __construct(int $id, string $status, Developer $developpeur) {
        $this->id = $id;
        $this->status = $status;
        $this->developpeur = $developpeur;
    }

    public function getInfos(): string {
        return "Tâche ID: {$this->id}, Statut: {$this->status}, Développeur: " . $this->developpeur->getNom();
    }

    public function getStatus(): string {
        return $this->status;
    }
}

class Projet {
    protected int $id;
    protected string $nom;
    protected string $deadline;
    protected array $taches;

    public function __construct(int $id, string $nom, string $deadline) {
        $this->id = $id;
        $this->nom = $nom;
        $this->deadline = $deadline;
        $this->taches = []; 
    }

    public function ajouterTache(int $id, string $status, Developer $developpeur): void {
        if (count($this->taches) < 5) {
            $tache = new Task($id, $status, $developpeur);
            $this->taches[] = $tache;
            echo "Tâche ajoutée avec succès.\n";
        } else {
            echo "Limite de 5 tâches atteinte pour ce projet.\n";
        }
    }

    public function afficherTaches(): void {
        echo "\n Liste des tâches du projet :\n";
        foreach ($this->taches as $tache) {
            echo $tache->getInfos() . "\n";
        }
    }

    public function filtrerTachesParStatus(string $status): array {
        return array_filter($this->taches, function(Task $tache) use ($status) {
            return $tache->getStatus() === $status;
        });
    }
}


$dev1 = new Developer(1, "Ali", "ali@exemple.com", "developer");

$projet = new Projet(101, "Application Ebooks", "2025-12-01");

$projet->ajouterTache(1, "en cours", $dev1);
$projet->ajouterTache(2, "en cours", $dev1);
$projet->ajouterTache(3, "terminée", $dev1);
$projet->ajouterTache(4, "en cours", $dev1);
$projet->ajouterTache(5, "terminée", $dev1);
$projet->ajouterTache(6, "en cours", $dev1); 

$projet->afficherTaches();

$tachesEnCours = $projet->filtrerTachesParStatus("en cours");

echo "\n Tâches en cours :\n";
foreach ($tachesEnCours as $tache) {
    echo $tache->getInfos() . "\n";
}
