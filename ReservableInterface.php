<?php

interface ReservableInterface{
    public function reserver($client, $dateDebut, int $nbJours);
}