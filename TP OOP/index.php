<?php 

require_once 'Voiture.php';
require_once 'Moto.php';


$voiture = new Voiture(1 , "abc100", "dacia", "2025" , 2000, 500, "oui", 4);
$voiture->afficherDetails();
$voiture->getTransmission();

echo "\n";

$moto = new Moto(1 , "efj123", "bicker", "2000" , 500, "oui", 4);
$moto->afficherDetails();

