% ==========================================
% 1. HECHOS Y REGLAS BÁSICAS
% ==========================================

% 1. par(N): evalúa verdadero si N es par sin usar mod.
par(0).
par(N) :- 
    N > 1, 
    N2 is N - 2, 
    par(N2).

% 2. suma(N, S): sumatoria de los primeros N números naturales pares
suma_pares(0, 0).
suma_pares(N, S) :-
    N > 0,
    N1 is N - 1,
    suma_pares(N1, S1),
    Termino is 2 * N,
    S is S1 + Termino.

% 3. potencia(B, E, V): B elevado a la E
potencia(_, 0, 1).
potencia(B, E, V) :-
    E > 0,
    E1 is E - 1,
    potencia(B, E1, V1),
    V is V1 * B.

% 4. fibonacci(N, R): término N-ésimo de Fibonacci
fibonacci(1, 1).
fibonacci(2, 1).
fibonacci(N, R) :-
    N > 2,
    N1 is N - 1,
    N2 is N - 2,
    fibonacci(N1, R1),
    fibonacci(N2, R2),
    R is R1 + R2.

% 5. Compuertas lógicas (se usa and_g, or_g, not_g para no chocar con built-ins)
and_g(1, 1, 1).
and_g(1, 0, 0).
and_g(0, 1, 0).
and_g(0, 0, 0).

or_g(0, 0, 0).
or_g(1, 0, 1).
or_g(0, 1, 1).
or_g(1, 1, 1).

not_g(1, 0).
not_g(0, 1).

circuito(Q1, Q2, S) :-
    and_g(Q1, Q2, S_and),
    not_g(Q1, S_not),
    or_g(S_and, S_not, S).

% 6. Diagnóstico médico
sintoma(juan, fiebre).
sintoma(juan, tos).
sintoma(maria, dolor_cabeza).

enfermedad(gripe, fiebre).
enfermedad(gripe, tos).
enfermedad(migrana, dolor_cabeza).

diagnostico(P, S, E) :-
    sintoma(P, S),
    enfermedad(E, S).

% ==========================================
% 2. TRATAMIENTO DE LISTAS
% ==========================================

% 7. predecesor(L, R): elementos mayores o iguales a su predecesor
predecesor([], []).
predecesor([X], [X]).
predecesor([X, Y | Cola], [X | R]) :-
    Y >= X,
    predecesor([Y | Cola], R).
predecesor([X, Y | Cola], R) :-
    Y < X,
    predecesor([Y | Cola], R).

% 8 y 17. rotada / rotarIzq(L, N, R): rota N posiciones a la izquierda
rotada(L, 0, L).
rotada([Cabeza|Cola], N, R) :-
    N > 0,
    N1 is N - 1,
    append(Cola, [Cabeza], LRotada),
    rotada(LRotada, N1, R).

rotarIzq(L, N, R) :- rotada(L, N, R).

% 9. suma(S, L): sumatoria de elementos de la lista
suma(0, []).
suma(S, [Cabeza|Cola]) :-
    suma(SCola, Cola),
    S is Cabeza + SCola.

% 10. cantidad(L, N): cantidad de elementos
cantidad([], 0).
cantidad([_|Cola], N) :-
    cantidad(Cola, NCola),
    N is NCola + 1.

% 11. ultimo(L, U): último elemento
ultimo([U], U).
ultimo([_|Cola], U) :-
    ultimo(Cola, U).

% 12. inversa(L, I): lista invertida
inversa([], []).
inversa([Cabeza|Cola], I) :-
    inversa(Cola, ICola),
    append(ICola, [Cabeza], I).

% 13. sacar(P, L, R): elimina posición P (índice base 1)
sacar(1, [_|Cola], Cola).
sacar(P, [Cabeza|Cola], [Cabeza|R]) :-
    P > 1,
    P1 is P - 1,
    sacar(P1, Cola, R).

% 14. eliminar(L, E, R): elimina la primera ocurrencia de E
eliminar([E|Cola], E, Cola).
eliminar([Cabeza|Cola], E, [Cabeza|R]) :-
    Cabeza \= E,
    eliminar(Cola, E, R).

% 15. eliminarTodas(L, E, R): elimina todas las instancias de E
eliminarTodas([], _, []).
eliminarTodas([E|Cola], E, R) :-
    eliminarTodas(Cola, E, R).
eliminarTodas([Cabeza|Cola], E, [Cabeza|R]) :-
    Cabeza \= E,
    eliminarTodas(Cola, E, R).

% 16. intersec(L1, L2, L3): intersección
intersec([], _, []).
intersec([Cabeza|Cola], L2, [Cabeza|L3]) :-
    member(Cabeza, L2),
    intersec(Cola, L2, L3).
intersec([Cabeza|Cola], L2, L3) :-
    \+ member(Cabeza, L2),
    intersec(Cola, L2, L3).

% 18. insertarEn(E, L, P, R): inserta en posición P (base 1)
insertarEn(E, L, 1, [E|L]).
insertarEn(E, [Cabeza|Cola], P, [Cabeza|R]) :-
    P > 1,
    P1 is P - 1,
    insertarEn(E, Cola, P1, R).

% 19. insOrden(E, O, D): inserta E en lista ordenada O
insOrden(E, [], [E]).
insOrden(E, [Cabeza|Cola], [E, Cabeza|Cola]) :-
    E =< Cabeza.
insOrden(E, [Cabeza|Cola], [Cabeza|D]) :-
    E > Cabeza,
    insOrden(E, Cola, D).

% 20. ordenada(L, O): ordena L mediante inserción
ordenada([], []).
ordenada([Cabeza|Cola], O) :-
    ordenada(Cola, OCola),
    insOrden(Cabeza, OCola, O).

% ==========================================
% 3. ESTRUCTURAS, ÁRBOLES Y BASE DE DATOS
% ==========================================

% 21. Árbol con functor persona(Nombre, DNI, Edad)
nodo(r, persona('Raul', '11111111', 70)).
nodo(a, persona('Ana', '22222222', 45)).
nodo(b, persona('Beto', '33333333', 48)).
nodo(c, persona('Carlos', '44444444', 40)).
nodo(d, persona('Diego', '55555555', 20)).
nodo(e, persona('Elena', '66666666', 22)).
nodo(f, persona('Florencia', '77777777', 25)).
nodo(g, persona('Gabriel', '88888888', 19)).
nodo(h, persona('Hugo', '99999999', 2)).
nodo(i, persona('Ignacio', '10101010', 3)).
nodo(j, persona('Julia', '12121212', 4)).
nodo(k, persona('Kevin', '13131313', 1)).

padre_arbol(r, a). padre_arbol(r, b). padre_arbol(r, c).
padre_arbol(a, d). padre_arbol(a, e).
padre_arbol(b, f). padre_arbol(b, g).
padre_arbol(e, h).
padre_arbol(f, i). padre_arbol(f, j).
padre_arbol(g, k).

descendiente(PadreID, HijoID) :- padre_arbol(PadreID, HijoID).
descendiente(PadreID, DescID) :- 
    padre_arbol(PadreID, Aux), 
    descendiente(Aux, DescID).

mostrar_descendientes(ID) :-
    descendiente(ID, DescID),
    nodo(DescID, Persona),
    writeln(Persona),
    fail.
mostrar_descendientes(_).

ascendiente(HijoID, PadreID) :- padre_arbol(PadreID, HijoID).
ascendiente(HijoID, AscID) :-
    padre_arbol(PadreID, HijoID),
    ascendiente(PadreID, AscID).

mostrar_ascendientes(ID) :-
    ascendiente(ID, AscID),
    nodo(AscID, Persona),
    writeln(Persona),
    fail.
mostrar_ascendientes(_).

% 22. parejas(L1, L2, L3)
parejas([], [], []).
parejas([X|L1], [Y|L2], [(X, Y)|L3]) :-
    parejas(L1, L2, L3).

% 23. Base de datos de personas
persona_db(persona('Carlos', '420111', m, 25)).
persona_db(persona('Lucia', '420222', f, 22)).
persona_db(persona('Pedro', '420333', m, 18)).
persona_db(persona('Maria', '420444', f, 30)).

casado('420111', '420222').
visita('Carlos', 'Pedro').

existe_persona(Nom) :- persona_db(persona(Nom, _, _, _)).

mostrar_personas :- 
    persona_db(P), writeln(P), fail.
mostrar_personas.

mostrar_mujeres :- 
    persona_db(persona(Nom, Tel, f, Edad)), 
    writeln(persona(Nom, Tel, f, Edad)), 
    fail.
mostrar_mujeres.

mostrar_varones_mayores21 :- 
    persona_db(persona(Nom, Tel, m, Edad)), 
    Edad > 21, 
    writeln(persona(Nom, Tel, m, Edad)), 
    fail.
mostrar_varones_mayores21.

mostrar_casados :-
    casado(Tel1, Tel2),
    persona_db(persona(N1, Tel1, _, _)),
    persona_db(persona(N2, Tel2, _, _)),
    format('~w está casado/a con ~w~n', [N1, N2]),
    fail.
mostrar_casados.

% ==========================================
% 4. GRAFO DE CIUDADES (EJERCICIO 24)
% ==========================================

arista('Mendoza', 'San Juan', 160).
arista('Mendoza', 'San Luis', 280).
arista('San Juan', 'Cordoba', 480).
arista('San Luis', 'Cordoba', 350).
arista('San Luis', 'Bs.As.', 710).
arista('Cordoba', 'Bs.As.', 540).
arista('Cordoba', 'Santa Fe', 280).
arista('Cordoba', 'Misiones', 950).
arista('Santa Fe', 'Misiones', 570).

conexion(A, B, D) :- arista(A, B, D).
conexion(A, B, D) :- arista(B, A, D).

camino_aux(Destino, Destino, _, [Destino], 0) :- !.
camino_aux(Origen, Destino, Visitados, [Origen|CaminoResto], DistanciaTotal) :-
    conexion(Origen, Intermedio, DistanciaPaso),
    \+ member(Intermedio, Visitados),
    camino_aux(Intermedio, Destino, [Intermedio|Visitados], CaminoResto, DistanciaResto),
    DistanciaTotal is DistanciaPaso + DistanciaResto.

existe_camino(Origen, Destino) :-
    camino_aux(Origen, Destino, [Origen], _, _), !.

distancia(Origen, Destino, Distancia) :-
    camino_aux(Origen, Destino, [Origen], _, Distancia).

mostrar_camino(Origen, Destino) :-
    camino_aux(Origen, Destino, [Origen], Camino, Distancia),
    imprimir_ruta(Camino),
    format(' (Distancia total: ~w km)~n', [Distancia]).

imprimir_ruta([Ultima]) :- write(Ultima).
imprimir_ruta([Ciudad, Siguiente|Resto]) :-
    write(Ciudad), write(' -> '),
    imprimir_ruta([Siguiente|Resto]).
