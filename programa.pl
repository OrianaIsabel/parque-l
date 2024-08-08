% Aquí va el código.
persona(nina, 22, 1.6).
persona(marcos, 8, 1.32).
persona(osvaldo, 13, 1.29).

tiene(parqueDeLaCosta, trenFantasma).
tiene(parqueDeLaCosta, montanaRusa).
tiene(parqueDeLaCosta, maquinaTiquetera).

restriccion(trenFantasma, edad(12)).
restriccion(montanaRusa, altura(1.30)).

tiene(parqueAcuatico, toboganGigante).
tiene(parqueAcuatico, rioLento).
tiene(parqueAcuatico, piscinaDeOlas).

restriccion(toboganGigante, altura(1.50)).
restriccion(piscinaDeOlas, edad(5)).

% Punto 1

puedeSubir(Persona, Atraccion):-
    persona(Persona,_,_),
    not(restriccion(Atraccion,_)).

puedeSubir(Persona, Atraccion):-
    persona(Persona, Edad,_),
    restriccion(Atraccion, edad(EdadMin)),
    Edad >= EdadMin.

puedeSubir(Persona, Atraccion):-
    persona(Persona,_, Altura),
    restriccion(Atraccion, altura(AlturaMin)),
    Altura > AlturaMin.

sonParaElle(Persona, [Atraccion]):-
    puedeSubir(Persona, Atraccion).

sonParaElle(Persona, [Atraccion|Atracciones]):-
    puedeSubir(Persona, Atraccion),
    sonParaElle(Persona, Atracciones).

esParaElle(Persona, Parque):-
    persona(Persona,_,_),
    tiene(Parque,_),
    findall(Atraccion, tiene(Parque, Atraccion), Atracciones),
    sonParaElle(Persona, Atracciones).

grupoEtario(ninos, 0, 12).
grupoEtario(adolescentes, 13, 18).
grupoEtario(adultos, 18, 60).

malaIdea(Grupo, Parque):-
    grupoEtario(Grupo, Menor, Mayor),
    tiene(Parque,_),
    not((tiene(Parque, Atraccion), restriccion(Atraccion, edad(EdadMin)), Menor >= EdadMin)).

