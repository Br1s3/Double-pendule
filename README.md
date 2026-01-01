# Programme simulant un double pendule

> [!WARNING]
> Necessite Raylib.h

## Pour commencer

```console
$ cc double_pendule.c resolveur_EDO.c -o double_pendule -Wall -Wextra -Wno-unused-function -lraylib -lGL -lm -lpthread -ldl -lrt -lX11
$ ./double_pendule
```

## Info interessante

### `Programme DOP853`
https://www.unige.ch/~hairer/software.html

### `Simulateur double pendule ultra réaliste`
https://www.myphysicslab.com/pendulum/double-pendulum-en.html
(Formule dispo en bas de page)

### `Code du site`
https://github.com/myphysicslab/myphysicslab/blob/master/src/lab/model/AdaptiveStepSolver.ts

### Résolution théorique: Résoudre les équations différentielles en utilisant la transformée de Laplace
> [Résolution celon_Laplace_](https://www.mathforengineers.com/french/Laplace-transform/solve-differential-equations-using-Laplace-transform.html)

### `simplification trigonométrique`
> [Formule trigo](https://www.mathforu.com/hors-programme/formulaire-de-trigonometrie/)


### `visualisation de la Série de Fourier`
https://isaacvr.github.io/coding/fourier_transform/

### `Equation rugeuse (stiff) qui sont les pire equation pour les solveur explicite`
https://en.wikipedia.org/wiki/Backward_differentiation_formula
https://en.wikipedia.org/wiki/Stiff_equation
