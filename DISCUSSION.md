# Installation de l'environnement

Comment installer un environnement Ruby rapidement sur les machines permettant de suivre les sessions WoR.

# Composants requis

- Git
- Ruby 2.3.1
- Probablement d’outils de compilation pour installer les extensions natives (à vérifier).
- Un éditeur de texte
- Un navigateur Web
- Redis ?

# Contraintes

J’ai identifié quelques critères importants :

- On ne connait pas les machines et les systèmes installés à l’avance. Il faut donc gérer le plus de configurations possibles  (OS, versions, etc.).
- Il faut pouvoir réaliser beaucoup d’installations rapidement en minimisant les problèmes techniques.
- Il faut prévoir des stratégies de secours en cas d’échec de la solution de préférence.

# Stratégies

Il y a plusieurs stratégies possibles qui ont leurs avantages et leurs inconvénients.

## Installation native

Chaque composant est installé individuellement. La procédure peut comporter un nombre important d'étapes avec un irsque d'échec à chacune d'entre elles. Il est possible d'installer des outils supplémentaires comme un gestionnaire de version Ruby par exemple, des personnalisations de Shell, des alias, mais c'est risqué et plus coûteux en temps.

L'avantage est d'avoir une installation parfaitement adaptée à la machine et qui utilise l'environnement habituel (navigateur, éditeur de texte, etc.). Seuls les outils essentiels qui sont abordés dans la session sont installés.

## Installation avec Docker

Il faut installer Docker et le container puis utiliser l'environnement ainsi créé pour travailler. Il y a moins d'étapes qu'une installation native, mais des prérequis plus importants :

- OS X 10.8+
- Windows 7+ 64-bits avec virtualisation matérielle
- Linux kernel 3.10+ 64-bit

Ce prérequis peuvent être complexes à vérifier dans certains cas, comme la vérification du support de virtualisation matérielle par exemple. Il faut également apprendre à utiliser Docker.

Les avantages sont une installation plus rapide qu'en natif. En cas d'échec, c'est tout ou rien donc éventuellement plus facile à débugguer. Comme pour l'installation native, l'environnement habituel est utilisé. Tout le monde à un environnement identique.

## Installation d'une VM

Un peu comme pour Docker, on installe un gestionnaire de VM, puis la VM elle-même. On lance la VM qui contient les outils et l'environnement. Il faut utiliser l'environnement de la VM ou bien passer un peu de temps à configurer le réseau et les partages de fichiers de la VM. Il y a aussi des prérequis, mais moins contraignants que pour Docker (en utilisant Virtual Box 5) :

- OS X 10.8+
- Windows Vista ou plus récent
- Linux kernel 2.6+

Si on utilise l'environnement de la VM, il faut s'habituer à la distribution de Linux fournie et au fonctionnement d'une VM, il peut être nécessaire d'avoir à configurer le clavier.

Les avantages sont une installation simple et rapide. Les prérequis sont permissifs et simples à vérifier, beaucoup de configurations sont supportées. Tous les outils nécessaires sont présents (éditeur, navigateur, etc.) sans configuration/installation supplémentaire. Il est possible de réutiliser son environnement moyennant un peu de configuration.

