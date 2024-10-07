
% Определение всех возможных значений каждого критерия
months([jan, feb, mar, apr]).
reactors([adtina, comati, dynotis, tamura]).
principles([tp, dd, fusor, poly]).
countries([ecuador, france, qatar, zambia]).

% Подсказка 1: Реактор, запущенный в Марте - это либо DD реактор, либо реактор, построенный во Франции.
hint1(Solution) :- member(mar-_-dd-_, Solution); member(mar-_-_-france, Solution).

% Подсказка 2: Реактор Comati DX5 был запущен НЕ в Январе.
hint2(Solution) :- \+ member(jan-comati-_-_, Solution).

% Реактор, запущенный в Марте, TP реактор и реактор в Замбии - это три разных реактора.
hint3(Solution) :-
    member(mar-Reactor1-_-_, Solution),
    member(_-Reactor2-tp-_, Solution),
    member(_-Reactor3-_-zambia, Solution),
    Reactor1 \= Reactor2,
    Reactor1 \= Reactor3,
    Reactor2 \= Reactor3.

% Подсказка 4: Реактор, запущенный в Январе - это либо TP реактор, либо реактор из Катара.
hint4(Solution) :- member(jan-_-tp-_, Solution); member(jan-_-_-qatar, Solution).

% Подсказка 5: Из двух реакторов, TP реактор и реактор, запущенный в Феврале, один - это Comati DX5, а другой из Эквадора.
hint5(Solution) :- (member(feb-comati-_-_, Solution), member(_-_-tp-ecuador, Solution)); (member(_-comati-_-ecuador, Solution), member(feb-_-tp-_, Solution)).

% Подсказка 6: Реактор Tamura BX12 построен в Замбии.
hint6(Solution) :- member(_-tamura-_-zambia, Solution).

% Подсказка 7: Реактор, запущенный в Апреле, Adtina V и fusor-реактор - это три разных реактора.
hint7(Solution) :-
    member(apr-Reactor1-_-_, Solution),
    member(_-adtina-_-_, Solution),
    member(_-Reactor2-fusor-_, Solution),
    \+ member(apr-_-fusor-_, Solution),
    
    Reactor1 \= adtina,
    Reactor1 \= Reactor2,
    adtina \= Reactor2
    .
%fusor 

% Подсказка 8: Реактор из Катара - это либо реактор, запущенный в Марте, либо Dynotis X1.
hint8(Solution) :- member(mar-_-_-qatar, Solution); member(_-dynotis-_-qatar, Solution).

% Проверка, подходят ли все подсказки для данного набора решений
 valid_solution(Solution) :- 
    hint1(Solution), 
    hint2(Solution), 
    hint3(Solution), 
    hint4(Solution), 
    hint5(Solution), 
    hint6(Solution), 
    hint7(Solution), 
    hint8(Solution).


% Поиск решения
sol(Solution) :-
    months(Months),
    reactors(Reactors),
    principles(Principles),
    countries(Countries),
    
    permutation([Month1, Month2, Month3, Month4], Months),
    permutation([React1, React2, React3, React4], Reactors),
    permutation([Princip1, Princip2, Princip3, Princip4], Principles),
    permutation([Country1, Country2, Country3, Country4], Countries),

    Solution = [Month1-React1-Princip1-Country1,
                Month2-React2-Princip2-Country2,
                Month3-React3-Princip3-Country3,
                Month4-React4-Princip4-Country4],

    valid_solution(Solution).

