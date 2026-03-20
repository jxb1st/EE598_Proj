# TODO

## Completed

- [x] Core definitions in `Defs.lean`: `Word`, `Language`, `DFA`, `NFA`, acceptance semantics
- [x] `RegExp` datatype and denotational semantics `RegExp.denote`
- [x] Doc comments on all definitions and theorems
- [x] Helper lemmas in `Lemmas.lean`: eval base cases, cons unfolding, append composition, monotonicity
- [x] NFA-to-DFA powerset construction in `Powerset.lean`
- [x] Correctness theorem: `NFA.toDFA_correct`
- [x] Concrete examples in `Examples.lean`: DFA, NFA, RegExp with named acceptance/rejection theorems
- [x] Powerset construction examples demonstrating preservation of acceptance/rejection
- [x] README with project goal, definitions, theorems, references, and future work

## Future / Stretch Goals

- [ ] Epsilon transitions and ε-closure
- [ ] Thompson's construction (RegExp → NFA)
- [ ] Closure properties of regular languages
- [ ] Pumping Lemma
- [ ] Decidable acceptance for finite types
- [ ] DFA minimization
