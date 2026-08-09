# dofus-almanax-simple

Script shell simple pour recuperer les offrandes Almanax via l'API Dofus et afficher un tableau des quantites, avec calcul du total selon le nombre de personnages.

## Fichier

- [almanax.sh](almanax.sh)

## Prerequis

- Linux (bash)
- `curl`
- `jq`
- `date` (GNU coreutils)

## Usage

```bash
./almanax.sh [-d YYYY-MM-DD] [-f YYYY-MM-DD] [-p NOMBRE] [-l LANG]
```

Options:

- `-d DATE`: date de debut (defaut: aujourd'hui)
- `-f DATE`: date de fin (defaut: meme date que `-d`)
- `-p NOMBRE`: nombre de personnages (defaut: `1`)
- `-l LANG`: langue API (defaut: `fr`)
- `-h`: affiche l'aide

## Exemples

Jour unique:

```bash
./almanax.sh -d 2026-08-10
```

Plage de dates avec 3 personnages:

```bash
./almanax.sh -d 2026-08-10 -f 2026-08-12 -p 3
```

## Sortie

Le script affiche un tableau avec les colonnes:

- `Date`
- `Offrande`
- `Quantite`
- `Total perso` (quantite x nombre de personnages)

```bash
./almanax.sh -d 2026-08-10 -f 2026-08-12 -p 3
Date       | Offrande                                 | Quantite | Total perso
-----------+------------------------------------------+----------+------------
2026-08-10 | Petit Extrait de Mangeoire               |        5 |          15
2026-08-11 | Kapokaza                                 |        3 |           9
2026-08-12 | Viande de Brousse                        |        4 |          12

Nombre de personnages: 3
```

## Licence

Ce projet est sous licence Creative Commons BY-NC 4.0 (non commerciale).

- Fichier: [LICENSE](LICENSE)
- Texte legal: https://creativecommons.org/licenses/by-nc/4.0/legalcode
