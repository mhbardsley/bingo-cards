/* Bingo cards program
    Author: Matthew Bardsley
*/

/* rowsToLists(Rows, Lists)
    Applies the rowToList functor to each list in Lists, to a list in Rows
*/

rowsToLists(Rows, Lists) :-
    maplist(rowToList, Rows, Lists).

/* rowToList(Row, List)
    Defines a row functor on the List type
*/

rowToList(Row, List) :-
    Row =.. [row | List].

/* createRow(Songs, X, Row, RemainingSongs)
    Creates a random Row of songs, and any Songs not chosen are retained in RemainingSongs
*/

createRow(Songs, 0, [], Songs).

createRow(Songs, X, [NewSong | RestOfRow], Remaining) :-
    X > 0,
    random_member(NewSong, Songs),
    delete(Songs, NewSong, NewSongs),
    R is X-1,
    once(createRow(NewSongs, R, RestOfRow, Remaining)).

/* createCard(Songs, X, Y, Card)
    Card is a result of populating a single Card with songs, in multiple rows and columns as given by the X and Y coordinates
*/

createCard(_, _, 0, []).
createCard(Songs, X, Y, [NewRow | OtherRows]) :-
    Y > 0,
    createRow(Songs, X, NewRow, Remaining),
    Q is Y-1,
    once(createCard(Remaining, X, Q, OtherRows)).

/* createCards(Songs, N, X, Y)
    Creates N cards, with X columns and Y rows.
*/

createCards(_, [], _, _).
createCards(Songs, [Person | OtherPeople], X, Y) :-
    createCard(Songs, X, Y, NewCard),
    string_concat('output/card', Person, Temp),
    string_concat(Temp, '.csv', Result),
    rowsToLists(Rows, NewCard),
    csv_write_file(Result, Rows),
    once(createCards(Songs, OtherPeople, X, Y)).

/* getListFromStream(Stream, List)
    Takes an input Stream, and converts each line to a new list item
*/

getListFromStream(Stream, []) :-
    at_end_of_stream(Stream).

getListFromStream(Stream, [X | List]) :-
    \+ at_end_of_stream(Stream),
    read_line_to_string(Stream, X),
    once(getListFromStream(Stream, List)).

/* generateCards
    Runs the main program, by taking each input stream, unifying with given variables, then running the generation algorithm
*/

generateCards :-
    open('input/list.txt', read, Stream1),
    getListFromStream(Stream1, List),
    close(Stream1),
    open('input/people.txt', read, Stream2),
    getListFromStream(Stream2, People),
    close(Stream2),
    open('input/config.txt', read, Stream3),
    read_line_to_string(Stream3, X),
    read_line_to_string(Stream3, Y),
    close(Stream3),
    atom_number(X, A),
    atom_number(Y, B),
    createCards(List, People, A, B).

:- generateCards, halt.