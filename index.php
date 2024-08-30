<?php

$cnx = new PDO("mysql:host=localhost;dbname=gestion_evenements;charset=utf8;port=3306", "root", "");

// $stmt = $cnx->prepare("SELECT * FROM evenement e
// JOIN lieu ON e.id_lieu=lieu.id_lieu
// JOIN organisateur ON e.idOrganisateur=organisateur.idOrganisateur
// LEFT JOIN participer ON e.idEvenement=participer.idEvenement AND participer.idUser=2");

$idUser = 1;
$stmt = $cnx->prepare("CALL getEventsByIdUser(?);");
$stmt->execute([$idUser]);

$events = $stmt->fetchAll(PDO::FETCH_ASSOC);

// var_dump($events);

foreach ($events as $event) { ?>
    <h1><?= $event["titreEvenement"] ?></h1>
    <!-- <p><?= $event["descriptionEvenement"] ?></p> -->
    <p>Organisé par <?= $event["nomOrganisateur"] ?></p>
    <p>User <?= $event["idUser"] ?></p>
    <?php
    if ($event["idUser"]) {
        echo "Vous êtes inscrit";
        echo "<button>Me désinscrire</button>";
    } else {
        echo "Vous n'êtes pas inscrit";
        echo "<button>M'inscrire</button>";
    }
    ?>
<?php } ?>