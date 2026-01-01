# Programme simulant un double pendule

> [!WARNING]
> Necessite la librairie graphique Raylib

Programme permettant de résoudre numériquement l'équation du double pendule. 
Le programme embarque plusieurs solveur d'EDO comment RK4, Verlet, Euler et DOPRI45.
La visualisation de cette simulation est effectuée avec Raylib.

## Pour commencer

```console
$ cc double_pendule.c resolveur_EDO.c -o double_pendule -Wall -Wextra -Wno-unused-function -lraylib -lGL -lm -lpthread -ldl -lrt -lX11
$ ./double_pendule
```

