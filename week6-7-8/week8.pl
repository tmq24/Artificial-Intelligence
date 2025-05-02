/*
Xay dung co so tri thuc.
Trang thai: Moi trang thai cua bai toan duoc bieu dien bang gia tri cua hai bien x va y (la luong nuoc trong binh X va Y).
Luat 1: Neu binh Y rong, thi do nuoc day binh Y.
Luat 2: Neu binh X day, thi do het nuoc ra.
Luat 3: Neu binh Y khong rong va binh X chua day, do nuoc tu Y sang X cho den khi het nuoc trong Y hoac binh X day.
Dieu kien dung: Dung khi x hoac y dat den gia tri z.
*/

/*
Chu thich:
- Nhap:
   - Vx: Dung tich binh X (lit)
   - Vy: Dung tich binh Y (lit)
   - z: So lit nuoc can dong

- Dieu kien de bai toan giai duoc:
   - z <= max(Vx, Vy)
   - z > 0
   - Vx, Vy > 0
   - UCLN(Vx, Vy) phai la uoc cua z

- Vi du cho bai toan khong giai duoc:
    solve(4, 7, 9) : vi 9 > 7 va 9 > 4
    solve(6, 3, 4) : vi UCLN(6,3) = 3 khong phai la uoc cua 4
*/

% Luat 1: Neu binh Y rong, thi do nuoc day binh Y
rule1(state(X, Y), state(X, Vy), _, Vy) :- 
    Y = 0.

% Luat 2: Neu binh X day, thi do het nuoc ra
rule2(state(X, Y), state(0, Y), Vx, _) :- 
    X = Vx.

% Luat 3: Neu binh Y khong rong va binh X chua day, do nuoc tu Y sang X
rule3(state(X, Y), state(X1, Y1), Vx, _) :-
    Y > 0,
    X < Vx,
    Available is Vx - X,
    (Y >= Available ->
        % Neu Y du nuoc lam day X
        X1 is Vx,
        Y1 is Y - Available
    ;
        % Neu Y khong du nuoc lam day X
        X1 is X + Y,
        Y1 is 0
    ).

% Kiem tra trang thai muc tieu
goal(state(Z, _), Z).
goal(state(_, Z), Z).

% Tim loi giai bang BFS
solve_bfs(State, Z, Vx, Vy, Path) :-
    bfs([[State]], Z, Vx, Vy, [State], RevPath),
    reverse(RevPath, Path).

bfs([[State|Path]|_], Z, _, _, _, [State|Path]) :-
    goal(State, Z), !.

bfs([Path|Paths], Z, Vx, Vy, Visited, Solution) :-
    Path = [State|_],
    findall([Next,State|Path],
            (
                (rule1(State, Next, Vx, Vy);
                 rule2(State, Next, Vx, Vy);
                 rule3(State, Next, Vx, Vy)),
                \+ member(Next, Visited)
            ),
            NewPaths),
    append(Paths, NewPaths, Queue),
    findall(Next, member([Next|_], NewPaths), NextStates),
    append(Visited, NextStates, NewVisited),
    bfs(Queue, Z, Vx, Vy, NewVisited, Solution).

% Giai bai toan
solve(Vx, Vy, Z) :-
    format('Bai toan dong nuoc:~n'),
    format('Binh X: ~w lit~n', [Vx]),
    format('Binh Y: ~w lit~n', [Vy]),
    format('Can dong: ~w lit~n~n', [Z]),
    Initial = state(0, 0),
    solve_bfs(Initial, Z, Vx, Vy, Path),
    format('Cac buoc thuc hien:~n'),
    print_unique_path(Path).

% In ket qua (loai bo trang thai trung lap)
print_unique_path([]).
print_unique_path([State|Rest]) :-
    \+ member(State, Rest),
    print_state(State),
    print_unique_path(Rest).
print_unique_path([_|Rest]) :-
    print_unique_path(Rest).

print_state(state(X, Y)) :-
    format('Binh X: ~w lit, Binh Y: ~w lit~n', [X, Y]).

/* Vi du:
1 ?- consult("week8.pl").
true.

2 ?- solve_water_jug(5, 3, 4).
Bai toan dong nuoc:
Binh X: 5 lit
Binh Y: 3 lit
Can dong: 4 lit

Cac buoc thuc hien:
Binh X: 0 lit, Binh Y: 0 lit
Binh X: 0 lit, Binh Y: 3 lit
Binh X: 3 lit, Binh Y: 0 lit
Binh X: 3 lit, Binh Y: 3 lit
Binh X: 5 lit, Binh Y: 1 lit
Binh X: 0 lit, Binh Y: 1 lit
Binh X: 1 lit, Binh Y: 0 lit
Binh X: 1 lit, Binh Y: 3 lit
Binh X: 4 lit, Binh Y: 0 lit
true .
*/