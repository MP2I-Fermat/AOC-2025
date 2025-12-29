Dans cette première partie, on s'intéresse a la manière d'acquérir l'entrée du
problème.

L'entrée est envoyée sur le canal stdin qui peut être lu à l'aide de la fonction
`std::io::input`. Chaque ligne est envoyée une par une, suivie d'une seule ligne
vide pour signifier la fin de l'entrée.

Pour cette partie, votre programme doit simplement répéter l'entrée, suivi du
texte `C'est fini`.

Par exemple, pour l'entrée suivante:
```
Ligne 1
Ligne 2
Ligne 3
```

Votre programme doit afficher:
```
Ligne 1
Ligne 2
Ligne 3
C'est fini
```
