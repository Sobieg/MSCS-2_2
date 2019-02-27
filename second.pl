:-dynamic subject/1.
:-dynamic object/1.
:-dynamic interest/3.

/*субъекты -- если остаток от деления на 3 у числа равен 1*/

object(O):-subject(O).

object(o2).
object(o3).
object(o5).
object(o6).
object(o8).

subject(s1).
subject(s4).
subject(s7).

right(r).
right(w).

interest(o2, bank, 1).
interest(o3, bank, 2).
interest(o5, bank, 3).
interest(o5, it, 1).
interest(o6, resources, 1).
interest(o8, bank, 4).
interest(o8, resources, 2).


%%DEBUG

interest(s1, bank, 1).

%%DEBUG END


try_access(S, O, R):-
	not(subject(S)), write("there is no subject "), write(S);
	not(object(O)), write("there is no subject/object "), write(O);
	(
		(R == r), %%чтение объектов
		forall(interest(S, _si, _sn), %% для всех компаний (_sn) во всех сферах интересов (_si) субъекта S
			(
				forall(interest(O, _oi, _on), %%  взять все компании (_on) во всех сферах интересов (_oi) объекта O
					(
						not(_si == _oi), not(_sn == _on), write("conflict of interest: "), 
							write(S), write(" have "), write(_si), write(" #"), write(_sn), write(" as well as "), 
							write(O), write(" have "), write(_oi), write(" #"), write(_on)
					)
				)
			)
		)
	);
	forall(interest(O, _oi, _on),
		(
			assert(interest(S, _oi, _on))
		)
	).



print_matrix:-
	forall(interest(_o, _i, _n), 
		(
			write(_o), write(": "), write(_i), write(" #"), write(_n), nl
		)
	), true.























