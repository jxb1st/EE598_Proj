# TODO

## Milestones

- [x] Finalize core definitions in `EE598Proj/Defs.lean`:
   - `Word`, `Language`
   - `DFA`, `NFA`
   - acceptance semantics
- [x] Add concrete examples in `EE598Proj/Examples.lean`:
   - at least one DFA
   - at least one NFA
   - sample accepted/rejected words
- [ ] Prove small helper lemmas for simulation behavior:
   - evaluation on empty word
   - one-step and two-step simplifications
- [x] Define a minimal regular expression datatype and semantics.
- [ ] Prototype NFA-to-DFA powerset construction (without epsilon transitions).
- [ ] State and prove one correctness theorem for the conversion.
- [x] Expand README with architecture notes, limitations, and next steps.
- [ ] Prepare a 2-minute presentation summary and demo script.
