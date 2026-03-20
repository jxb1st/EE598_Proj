import Mathlib

namespace LeanW26

variable {Q Alpha : Type}

/-- A word is a list of symbols from the alphabet. -/
abbrev Word (Alpha : Type) := List Alpha

/-- A language is a set of words. -/
abbrev Language (Alpha : Type) := Set (Word Alpha)

/-- DFA with start state, transition function, and set of accepting states. -/
structure DFA (Q Alpha : Type) where
  start : Q
  step : Q → Alpha → Q
  accept : Set Q

/-- Run a DFA from state `q` on word `w`, return the final state. -/
def DFA.eval (M : DFA Q Alpha) : Q → Word Alpha → Q
  | q, [] => q
  | q, a :: w => M.eval (M.step q a) w

/-- DFA accepts `w` if running from start ends in an accepting state. -/
def DFA.Accepts (M : DFA Q Alpha) (w : Word Alpha) : Prop :=
  M.eval M.start w ∈ M.accept

/-- NFA: like DFA but start and step return sets of states. -/
structure NFA (Q Alpha : Type) where
  start : Set Q
  step : Q → Alpha → Set Q
  accept : Set Q

/-- Move every state in `S` forward by one symbol `a`. -/
def NFA.stepSet (M : NFA Q Alpha) (S : Set Q) (a : Alpha) : Set Q :=
  {q' | ∃ q, q ∈ S ∧ q' ∈ M.step q a}

/-- Run an NFA from state set `S` on word `w`. -/
def NFA.eval (M : NFA Q Alpha) : Set Q → Word Alpha → Set Q
  | S, [] => S
  | S, a :: w => M.eval (M.stepSet S a) w

/-- NFA accepts `w` if some reachable state is in accept. -/
def NFA.Accepts (M : NFA Q Alpha) (w : Word Alpha) : Prop :=
  ∃ q, q ∈ M.eval M.start w ∧ q ∈ M.accept

/-- Regular expression over alphabet `Alpha`.
- `empty`: no words
- `epsilon`: only the empty word
- `char a`: only `[a]`
- `union r s`: words in `r` or `s`
- `concat r s`: a word from `r` followed by one from `s`
- `star r`: zero or more words from `r` concatenated -/
inductive RegExp (Alpha : Type) where
  | empty : RegExp Alpha
  | epsilon : RegExp Alpha
  | char : Alpha → RegExp Alpha
  | union : RegExp Alpha → RegExp Alpha → RegExp Alpha
  | concat : RegExp Alpha → RegExp Alpha → RegExp Alpha
  | star : RegExp Alpha → RegExp Alpha

open RegExp

/-- Map a regex to the language (set of words) it matches. -/
def RegExp.denote : RegExp Alpha → Language Alpha
  | empty => ∅
  | epsilon => {w | w = []}
  | char a => {w | w = [a]}
  | union r s => RegExp.denote r ∪ RegExp.denote s
  | concat r s =>
      {w | ∃ u v, u ∈ RegExp.denote r ∧ v ∈ RegExp.denote s ∧ u ++ v = w}
  | star r =>
      {w | ∃ l : List (Word Alpha), (∀ u ∈ l, u ∈ RegExp.denote r) ∧ List.flatten l = w}

end LeanW26
