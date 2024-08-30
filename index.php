<?php
$idUser = 1; // l'id de l'utilisateur connecté

// on récupère tous les événements avec le nombre de places disponibles
$cnx = new PDO("mysql:host=localhost;dbname=gestion_evenements;charset=utf8;port=3306", "root", "");
$stmt = $cnx->prepare("CALL getEventsByIdUser(?);");
$stmt->execute([$idUser]);
$events = $stmt->fetchAll(PDO::FETCH_ASSOC);

// affichage des événements
foreach ($events as $event) { ?>
    <h1><?= $event["titreEvenement"] ?></h1>
    <p>Organisé par <?= $event["nomOrganisateur"] ?></p>
    <p>Nombre de places restantes : <?= $event["nbPlacesDispo"] > 0 ? $event["nbPlacesDispo"] : 0  ?></p>
<?php
    if ($event["idUser"]) {
        echo "Vous êtes inscrit";
        echo "<button>Me désinscrire</button>";
    } else {
        echo "Vous n'êtes pas inscrit";
        if ($event["nbPlacesDispo"] > 0) {
            echo "<button>M'inscrire</button>";
        }
    }
}
?>