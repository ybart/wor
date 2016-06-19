# Installation Vagrant Ruby on Rails

Installation de l'environnement Vagrant Ruby on Rails pour Women on Rails.

# Prérequis

Pour Vagrant (uniquement pour les mentors):

- Une version récente de Windows, OS X ou Linux

Pour Virtual Box:

- OS X 10.8+
- Windows Vista ou plus récent
- Linux kernel 2.6+

Pour l'environnement de travail :

- Git
- SSH
- Un éditeur de texte (ex: Sublime Text 3)
- Un navigateur Web (ex: Mozilla Firefox)

# Création de la VM

```
cd
vagrant plugin install vagrant-vbguest
vagrant up
```

# Resources

- Box Custom : https://github.com/ashantyk/vagrant-box-scripts
- Install Minimal Xerus : https://www.howtoforge.com/tutorial/ubuntu-minimal-server-install/

# TODO

- Avec Vagrant
  - [*] Runtime JS
  - [*] Redirection de port (rails s -b 0.0.0.0)
  - [] Faire un dossier synchronisé pour le code (! Git dans Git)
  - [] Générer une VM du premier coup avec Vagrant Up
  - [] Version 64-bits
- Sans Vagrant
  - [] Documenter les commandes SSH
  - [] Vérifier les partages
  - [] Vérifier les redirections de port
- Sans Vagrant + GUI
  - [] GUI
- Box custom
  - [] SSH installé avec les clés pour Vagrant
  - [] Compte utilisateur avec login:password => rails:rails
  - [] Sudo sans mot de passe
  - [] Version minimale
  - [] Défragmentation et réduction de la taille réelle du disque virtuel
  - [] VirtualBox additions gérées par le plugin vagrant-vbguest
  - [] Vagrant Berskshelf (ChefDK)
  - [] Redirection de ports fonctionnels
  - [] Partages de fichiers fonctionnels (plugin vagrant-vbguest)

# Création d'une box de base

Voici le principe de cette procédure.

- Dans VirtualBox, créer une VM Linux de travail qui va permettre de modifier l'ISO d'installation pour faire une instalation automatique.
- Depuis la VM, éxecuter le script de création de l'ISO (ce script va télécharger une ISO, la monter, configurer les options d'installation, comme la langue, les paquets à installer, et optimiser l'espace).
- Copier l'ISO sur la machine hôte.
- Créer la VM sur VirtualBox, et utiliser l'ISO pour l'installer.
- Compresser la marchine virtuelle
- Créer une box Vagrant à partir de cette machine virtuelle
- Envoyer la box de base sur Hashicorp.

## Création de l'ISO

Si vous avez un Linux à disposition, vous pouvez l'utiliser directement. Sur Mac ou Windows, il vaut mieux utiliser cette procédure pour créer l'ISO. On pourrait adapter cette procédure pour macOS et Windows, mais la difficulté est de monter l'ISO en BRTFS et la modifier tout en la laissant bootable.

Utilisons Vagrant pour télécharger notre environement Linux et faire générer l'ISO finale.

Lors de l'installation, le fichier `preseed.cfg` est récupéré par HTTP. Il faut communiquer l'IP de la machine hôte à Vagrant. Ainsi cette IP sera écrite sur l'ISO de l'installeur généré par Vagrant. L'installeur pourra ainsi accéder au fichier.


Sous Linux:
```
export HOST_ADDRESS=`hostname --ip-address`
```

Sous OS X:
```
export HOST_ADDRESS=`ifconfig | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p' | head -1`
````

Après avoir installé Vagrant (installez le plugin vagrant-vbguest, et lancez `vagrant provision` en cas de problème):

```
 #vagrant plugin uninstall vagrant-vbguest
cd iso-builder
python -m SimpleHTTPServer 8080
vagrant up
```

Cette dernière commande va télécharger automatiquement la version d'Ubuntu paramétrée dans `build-iso.sh` et utiliser VirtualBox pour démarrer dessus. Le script pour générer l'ISO finale `build-iso.sh` va ensuite être éxecuté automatiquement. Ce script va télécharger une ISO d'installation et la modifier et la copier dans le dossier ISO-builder. Vous pouvez modifier le script `build-iso.sh` pour utiliser une autre version d'Ubuntu.

## Création de la box

Nous allons créer une nouvelle VM avec VirtualBox. Nous allons la configurer avec un disque dynamique et démarrer à partir de l'ISO. Une fois l'installation terminée, nous allons commpresser limage disque pouis créer l'OVF dans Virtual Box. Enfin, nous allons créer un dossier respectant le format Box de Vragrant.

1. Ouvrez Virtual Box et créez une nouvelle VM
2. Choisissez un nom (ex: ubuntu-xenial-i386), et choisissez le type Linux version Ubuntu 32-bit ou 64-bit selon l'image que vous avez téléchargé (vous pouvez vérifier l'image utilisée dans build-iso.sh)
3. Choisissez 512 Mo pour la mémoire (pour une installation sans GUI).
4. Créez un disque virtuel de 5 Go dynamiquement alloué avec le nom par défaut.
5. Associez l'ISO créée (dans Configuration > Stockage > CD Vide > Icône de CD à côté du menu déroulant Lecteur optique > Choisissez un disque virtuel). Puis choisissez le disque généré qui se termine par '-custom.iso' (ex: ubuntu-xenial-i386-installer-custom.iso)
6. Mettez le réseau en mode bridge (Configuration > Réseau > Mode d'accès réseau > Accès par pont)
7. Démarrez la machine virtuelle pour lancer l'installation
8. À la fin de l'installation éjectez le CD et éteignez la VM si nécessaire.
9. Vous pouvez ensuite créer la box (en utilisant le nom de la VM dans VirtualBox) :
    ````
    VBoxManage modifyhd ~/VirtualBox\ VMs/ubuntu-xenial-i386/ubuntu-xenial-i386.vdi --compact
    vagrant package --base ubuntu-xenial-i386 --output ubuntu-xenial-i386.box
    ```


TODO:

- SSHD: UseDNS = No
