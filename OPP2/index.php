<?php

class User
{
    protected string $nom;
    protected string $email;

    public function __construct(string $nom, string $email)
    {
        $this->nom = $nom;
        $this->email = $email;
    }
    public function getNom()
    {
        return $this->nom;
    }
    public function getEmail()
    {
        return $this->email;
    }
    public function setNom($nom)
    {
        $this->nom = $nom;
    }
    public function setEmail($email)
    {
        $this->email = $email;
    }
    public function afficheDetails()
    {
        echo "Nom : {$this->nom}\n";
        echo "Email : {$this->email}\n";
    }
}

class Auteur extends User
{
    private string $bio;

    public function __construct(string $nom, string $email, string $bio)
    {
        parent::__construct($nom,  $email);
        $this->bio = $bio;
    }
    public function getBio()
    {
        return $this->bio;
    }
    public function setBio($bio)
    {
        $this->bio = $bio;
    }
    public function afficheDetails()
    {
        parent::afficheDetails();
        echo "bio: {$this->bio}";
    }
    public function creerArticle($title, $contenu): Article
    {
        return new Article($title, $contenu , new DateTime() , $this);
    }
}

class Administrateur extends User
{
    private string $role;

    public function __construct(string $nom, string $email, string $role)
    {
        parent::__construct($nom, $email);
        $this->role = "super admin";
    }
    public function getRole()
    {
        return $this->role;
    }

    public function setRole($role)
    {
        $this->role = $role;
    }
    public function afficheRole()
    {
        echo " role: {$this->role}";
    }

    private function supprimerArticle(Article $article)
    {
        echo " cette" . $article->getTitle() . "supprimmer avec sucesss par l admin";
    }
}

class Article
{
    private string $title;
    private string $contenu;
    private DateTime $dataPublication;
    private object $auteur;

    public function __construct(string $title, string $contenu, DateTime $dataPublication, object $auteur)
    {
        $this->title =    $title;
        $this->contenu =    $contenu;
        $this->dataPublication = new DateTime();
        $this->auteur = $auteur;
    }
    public function getTitle()
    {
        return $this->title;
    }
    public function setTitle($title)
    {
        $this->title = $title;
    }

    public function getcontenu()
    {
        return $this->contenu;
    }
    public function setcontenu($contenu)
    {
        $this->contenu = $contenu;
    }

    public function getdataPublication()
    {
        return $this->dataPublication;
    }
    public function setdataPublication($dataPublication)
    {
        $this->dataPublication = $dataPublication;
    }

    public function getauteur()
    {
        return $this->auteur;
    }
    public function setauteur($auteur)
    {
        $this->auteur = $auteur;
    }

    public function afficheDetails()
    {
        echo " title {$this->title} \n";
        echo " contenu {$this->contenu} \n";
        echo " dataPublication {$this->dataPublication} \n";
        echo " auteur:" . $this->auteur->getNom() . "\n";
    }
} 
