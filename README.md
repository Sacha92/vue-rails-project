# Description

Ce repo implemente une application vue js et une api ruby on rails.

L'appli permet de creer une Hive, avec un nom et un poids.

L'endpoint `/` nous donne la liste des Hives actuellement en db, et permet d'ajouter une nouvelle Hive.

L'endpoint `/hives/:id` permet d'afficher les details d'une Hive.

# Rails app setup

```cd my_api
bundle install
rails db:create
rails db:migrate
rails s
```

# Vue app setup
```
cd vue-project
npm run install
npm run dev
```
# Choix d'implémentation

J'ai décidé d'implémenter les deux applications de manière découplées, pour ne pas ajouter de contraintes de dev sur le long terme. 

L'application vue js n'as pas connaissances du backend, elle envoie simplement des requetes sur une api, et vice versa.

La validations des données pendant le create est faites une première fois au niveau du frontend, en vanilla js, puis une deuxième fois avec les validators rails (aussi une clée :unique dans le field name de la db). La validation niveau js n'est pas obligatoire mais plus pratique. L'inconvenient est que si les contraintes sont aménées à changer, il faudra changer la validations des deux cotés de l'application.

Sans utiliser Scalingo j'aurai implémenté les deux cotés de l'application dans des images Docker et les auraient montées ensemble dans un docker-compose.
