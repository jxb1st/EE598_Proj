# Formalizing Finite Automata in Lean 4

## Goal

The goal of this project is to formalize some basic finite automata theory in Lean 4. I defined DFA, NFA, and regular expressions, and proved some properties about them. The main result is the NFA-to-DFA powerset construction and a proof that it is correct (the converted DFA accepts the same language as the original NFA). I also built some concrete examples using a binary alphabet and checked that they work as expected.

## Project Structure

```
EE598Proj/
├── Defs.lean       -- Core types and definitions
├── Lemmas.lean     -- Basic lemmas about DFA/NFA evaluation
├── Powerset.lean   -- NFA to DFA conversion and correctness proof
└── Examples.lean   -- Concrete examples with binary alphabet
```

## Main Definitions

| Definition | File | Description |
|---|---|---|
| `Word Alpha` | `Defs.lean` | A word is just a `List Alpha` |
| `Language Alpha` | `Defs.lean` | A language is `Set (Word Alpha)` |
| `DFA Q Alpha` | `Defs.lean` | DFA with `start` state, `step` function, and `accept` set |
| `DFA.eval` | `Defs.lean` | Runs a DFA on a word from some state, gives the final state |
| `DFA.Accepts` | `Defs.lean` | Whether a DFA accepts a word (eval from start ends in accept) |
| `NFA Q Alpha` | `Defs.lean` | Like DFA but `start` and `step` give sets of states |
| `NFA.stepSet` | `Defs.lean` | Move all states in a set forward by one symbol |
| `NFA.eval` | `Defs.lean` | Runs an NFA on a word from a set of states |
| `NFA.Accepts` | `Defs.lean` | Whether some reachable state is in accept |
| `RegExp Alpha` | `Defs.lean` | Regular expression type (`empty`, `epsilon`, `char`, `union`, `concat`, `star`) |
| `RegExp.denote` | `Defs.lean` | Maps a regex to the language (set of words) it describes |
| `NFA.toDFA` | `Powerset.lean` | Converts NFA to DFA using the powerset/subset construction |
| `endsWithOneDFA` | `Examples.lean` | Example DFA that accepts words ending with `one` |
| `containsOneNFA` | `Examples.lean` | Example NFA that accepts words containing `one` |
| `oneRe`, `bitRe` | `Examples.lean` | Example regular expressions over binary alphabet |

## Main Theorems

| Theorem | File | Description |
|---|---|---|
| `DFA.eval_nil` | `Lemmas.lean` | Eval on empty word `[]` gives back the same state |
| `DFA.eval_cons` | `Lemmas.lean` | Eval on `a :: w` = step once then eval the rest |
| `DFA.eval_append` | `Lemmas.lean` | `eval q (u ++ v) = eval (eval q u) v` |
| `NFA.eval_nil` | `Lemmas.lean` | Same as above but for NFA |
| `NFA.eval_cons` | `Lemmas.lean` | Same as above but for NFA |
| `NFA.stepSet_mono` | `Lemmas.lean` | If `S ⊆ T` then `stepSet S a ⊆ stepSet T a` |
| `NFA.eval_mono` | `Lemmas.lean` | NFA eval is monotone in the state set |
| `NFA.eval_append` | `Lemmas.lean` | Same append lemma but for NFA |
| `NFA.toDFA_eval` | `Powerset.lean` | The converted DFA evals the same as the original NFA |
| `NFA.toDFA_correct` | `Powerset.lean` | **Main result**: `toDFA.Accepts w ↔ NFA.Accepts w` |
| `endsWithOneDFA_accepts_one` | `Examples.lean` | The DFA accepts `[one]` |
| `endsWithOneDFA_rejects_one_zero` | `Examples.lean` | The DFA rejects `[one, zero]` |
| `containsOneNFA_accepts_zero_one` | `Examples.lean` | The NFA accepts `[zero, one]` |
| `containsOneNFA_rejects_zero_zero` | `Examples.lean` | The NFA rejects `[zero, zero]` |
| `powerset_containsOne_accepts` | `Examples.lean` | Powerset DFA also accepts `[zero, one]` |
| `powerset_containsOne_rejects` | `Examples.lean` | Powerset DFA also rejects `[zero, zero]` |

(There are a few more acceptance/rejection theorems in `Examples.lean` not listed here.)

## Building

Need Lean 4 (v4.28.0) and Mathlib:

```bash
lake build
```

## References

1. M. Sipser, *Introduction to the Theory of Computation*, 3rd ed., Cengage, 2012.
2. J. E. Hopcroft, R. Motwani, J. D. Ullman, *Introduction to Automata Theory, Languages, and Computation*, 3rd ed., Pearson, 2006.
3. Mathlib docs: https://leanprover-community.github.io/mathlib4_docs/
4. CSLib Automata in Lean 4: https://github.com/leanprover/cslib/blob/main/Cslib/Computability/Automata/DA/Basic.lean
5. Lean 4 manual: https://lean-lang.org/lean4/doc/

## Future Work

- Add epsilon transitions to the NFA model
- Thompson's construction (convert regex to NFA) and prove it correct
- Prove closure properties (regular languages closed under union, concat, star)
- Pumping lemma for regular languages
- Make `DFA.Accepts` decidable on finite types so we can compute it
