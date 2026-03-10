# EE598_Proj

## Project Description

This project formalizes core finite automata theory in Lean 4, with a focus on reusable definitions and small verified examples that can be extended toward larger theorems. The current scope includes deterministic and nondeterministic finite automata (DFA/NFA), language acceptance semantics over finite words, and a minimal regular-expression syntax layer; stretch goals include NFA-to-DFA powerset construction and selected regular-language results.

## Planned Deliverables

- Lean definitions for DFA/NFA and language semantics
- Worked examples of small automata and acceptance proofs
- Incremental documentation of design decisions and proof strategy

## Completed Work

- Added `EE598Proj/Defs.lean` with reusable core abstractions:
  - `Word` and `Language`
  - `DFA` with `eval` and `Accepts`
  - `NFA` with `stepSet`, `eval`, and `Accepts`
  - `RegExp` datatype and denotational semantics `RegExp.denote`
- Added `EE598Proj/Examples.lean` with concrete finite-alphabet models:
  - DFA example `endsWithOneDFA`
  - NFA example `containsOneNFA`
  - acceptance/rejection examples proved with `simp`
  - regex example `oneRe` with membership/non-membership checks
- Updated `EE598Proj.lean` to import the new modules so they build as part of the library target.

## How It Was Implemented

- Used parameterized type definitions (`Q`, alphabet type) so the API is reusable across different state/alphabet models.
- Encoded automaton execution as recursive evaluators over words:
  - `DFA.eval : Q -> Word Alpha -> Q`
  - `NFA.eval : Set Q -> Word Alpha -> Set Q`
- Defined acceptance as propositions (`Prop`) instead of booleans, making downstream theorem statements more direct.
- Implemented regex semantics by mapping constructors to `Language Alpha`, including:
  - union via set union,
  - concat via witness words `u` and `v` with `u ++ v = w`,
  - star via a list of words whose flattening equals `w`.
- Verified correctness of the added modules with `lake build` (project builds successfully).

## Limitations and Next Steps

- Epsilon transitions are not included yet.
- NFA-to-DFA powerset construction is planned but not implemented.
- No global equivalence theorem is proved yet (only local examples).
- Next milestone is helper lemmas for simulation behavior, then conversion correctness.

## NYT Article Reflection

My main takeaway is that convenience and productivity gains from AI tools are real, but they can create hidden dependency if students stop validating outputs against primary sources. For this Lean project, I will use AI for brainstorming and rough planning, but treat all generated claims as unverified until checked against textbooks, mathlib docs, and actual Lean typechecking behavior. I also view citation discipline and reproducibility as the key guardrails: if an argument or source cannot be traced, it should not be used as project evidence.
