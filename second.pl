:-dynamic subject/1.
:-dynamic object/1.
:-dynamic interest/3.
:-dynamic writing_flag/1.
:-dynamic not_reading_flag/1.
:-dynamic not_writing_flag/2.

/*субъекты -- если остаток от деления на 3 у числа равен 1*/

object(O):-subject(O).

object(o2).
object(o3).
object(o5).
object(o6).
object(o8).
object(o9).

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



	( %% если нет вообще пересечения интересов
		interest(S, _, _), 
		(
			forall(interest(S, _si, _sn), %% для всех компаний (_sn) во всех сферах интересов (_si) субъекта S
				(
					interest(O, _, _),
					(
						forall(interest(O, _oi, _on), %%  взять все компании (_on) во всех сферах интересов (_oi) объекта O
							(
								(
									_si == _oi, not(_sn == _on), 

										(

											(
												R == r, 
												write("conflict of interest: "), 
												write(S), write(" have "), write(_si), write(" #"), write(_sn), write(" as well as "), 
												write(O), write(" have "), write(_oi), write(" #"), write(_on), nl, assert(not_reading_flag(t))
											);
											(
												R == w,
												write("Can not write to object with same interest, but other company"), nl, 
												assert(not_writing_flag(S, O)), writing_flag(t), retract(writing_flag(t))
											); true
										)
								);

								(
									(R == w, not(not_writing_flag(S, O)), assert(writing_flag(t))), false
								)
							)
						)
					)

				)
			)
		)
	); 

	(
		writing_flag(t), 
			(
				write("Writing done"), retract(writing_flag(t))
			)
	);

	(

		not(not_reading_flag(t)),
		(
			R == r,
			(
				forall(interest(O, _oi, _on),
					(
						(not(interest(S, _oi, _on)), assert(interest(S, _oi, _on))); true
					)
				)
			),
			write("Reading done")
		);
		retract(not_reading_flag(t))
	);

	R == w, not(interest(O, _, _)), write("Can not write to public objects").



create_s(S1, S2):-
	not(subject(S1)), write("there is no subject "), write(S1);
	subject(S2), write("there is subject "), write(S2), write(" already");
	assert(subject(S2)),
	(
		forall( interest(S1, _i, _n), 
			(
				assert(interest(S2, _i, _n))
			)
		)
	).


print_matrix:-
	forall(interest(_o, _i, _n), 
		(
			write(_o), write(": "), write(_i), write(" #"), write(_n), nl
		)
	), true.























