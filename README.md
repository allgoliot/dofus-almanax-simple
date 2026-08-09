# Boite a Outils VTOM CDC

Ce depot contient des scripts et des ressources pour exporter, migrer, transformer et reimporter des objets VTOM (applications, jobs, agents, submit units, contextes, ressources, etc.).

## Objectif

- Industrialiser les operations de migration VTOM entre environnements.
- Automatiser les traitements de collecte et de conversion de donnees.
- Fournir des scripts utilitaires pour la creation et la maintenance d'objets VTOM.

## Arborescence principale

- [script/](script/) : scripts shell/python principaux (export, import, migration, outillage).
- [fonctions/](fonctions/) : bibliotheques shell sourcees par les scripts.
- [conf/](conf/) : fichiers de configuration et donnees intermediaires.
- [data/](data/) : donnees de travail (json/xml) organisees par type d'objet.
- [doc/](doc/) : documentation projet, guides et references de scripts.
- [output_all/](output_all/) : sorties JSON agrigees par type d'objet.
- [r3/](r3/) : scripts historiques et utilitaires complementaires.

## Prerequis

- Linux (bash)
- Outils shell usuels: curl, jq, sed, awk, grep
- Python 3 pour les scripts Python
- Acces VTOM/API selon les scripts utilises

## Usages frequents

1. Export d'objets VTOM vers des fichiers
2. Transformation / migration des donnees exportees
3. Reimport vers un environnement cible
4. Verification via fichiers de sortie et logs

Les points d'entree les plus utilises sont dans [script/](script/).

## Documentation

- Reference complete des scripts: [doc/scripts_reference.md](doc/scripts_reference.md)
- Notes de migration: [doc/RAPPORT_MIGRATION.md](doc/RAPPORT_MIGRATION.md)
- Aide sur les traitements: [doc/recap_vtom_scripts.md](doc/recap_vtom_scripts.md)

## Bonnes pratiques

- Toujours verifier les variables d'environnement avant execution.
- Tester d'abord sur un environnement non productif.
- Conserver les exports sources avant toute transformation.
- Mettre a jour la documentation des scripts apres toute modification.

## Contact / maintenance

Maintenir ce README en phase avec les scripts et la documentation du dossier [doc/](doc/).

## Licence

Ce projet est diffuse sous licence Creative Commons BY-NC 4.0 (utilisation non commerciale).

- Fichier de licence: [LICENSE](LICENSE)
- Texte legal: https://creativecommons.org/licenses/by-nc/4.0/legalcode
