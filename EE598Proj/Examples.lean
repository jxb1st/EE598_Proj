import EE598Proj.Defs
import EE598Proj.Lemmas
import EE598Proj.Powerset

namespace LeanW26

/-! # Examples over binary alphabet

Concrete DFA, NFA, and RegExp with acceptance/rejection proofs.
-/

/-- Binary alphabet. -/
inductive Bit where
  | zero
  | one
  deriving DecidableEq, Repr

open Bit

-- DFA that accepts words ending with `one`

/-- DFA over `Bit`: accepts if the last symbol is `one`.
`false` = last was not one, `true` = last was one. -/
def endsWithOneDFA : DFA Bool Bit where
  start := false
  step := fun _ a =>
    match a with
    | zero => false
    | one => true
  accept := {q | q = true}

theorem endsWithOneDFA_accepts_one : endsWithOneDFA.Accepts [one] := by
  simp [DFA.Accepts, DFA.eval, endsWithOneDFA]

theorem endsWithOneDFA_rejects_one_zero : ¬ endsWithOneDFA.Accepts [one, zero] := by
  simp [DFA.Accepts, DFA.eval, endsWithOneDFA]

theorem endsWithOneDFA_accepts_zero_one : endsWithOneDFA.Accepts [zero, one] := by
  simp [DFA.Accepts, DFA.eval, endsWithOneDFA]

theorem endsWithOneDFA_rejects_nil : ¬ endsWithOneDFA.Accepts [] := by
  simp [DFA.Accepts, DFA.eval, endsWithOneDFA]

-- NFA that accepts words containing at least one `one`

/-- NFA over `Bit`: accepts if the word contains at least one `one`.
`false` = haven't seen one yet, `true` = seen one. -/
def containsOneNFA : NFA Bool Bit where
  start := {q | q = false}
  step := fun q a =>
    match q, a with
    | false, zero => {q' | q' = false}
    | false, one => {q' | q' = true}
    | true, _ => {q' | q' = true}
  accept := {q | q = true}

theorem containsOneNFA_accepts_zero_one : containsOneNFA.Accepts [zero, one] := by
  refine ⟨true, ?_, ?_⟩
  · simp [NFA.eval, NFA.stepSet, containsOneNFA]
  · simp [containsOneNFA]

theorem containsOneNFA_rejects_zero_zero : ¬ containsOneNFA.Accepts [zero, zero] := by
  simp [NFA.Accepts, NFA.eval, NFA.stepSet, containsOneNFA]

theorem containsOneNFA_accepts_one : containsOneNFA.Accepts [one] := by
  refine ⟨true, ?_, ?_⟩
  · simp [NFA.eval, NFA.stepSet, containsOneNFA]
  · simp [containsOneNFA]

theorem containsOneNFA_rejects_nil : ¬ containsOneNFA.Accepts [] := by
  simp [NFA.Accepts, NFA.eval, containsOneNFA]

-- Regular expression examples

/-- Regex that matches exactly `[one]`. -/
def oneRe : RegExp Bit := RegExp.char one

theorem oneRe_accepts_one : [one] ∈ RegExp.denote oneRe := by
  simp [oneRe, RegExp.denote]

theorem oneRe_rejects_zero : [zero] ∉ RegExp.denote oneRe := by
  simp [oneRe, RegExp.denote]

/-- Regex matching `zero | one` (any single bit). -/
def bitRe : RegExp Bit := RegExp.union (RegExp.char zero) (RegExp.char one)

theorem bitRe_accepts_zero : [zero] ∈ RegExp.denote bitRe := by
  simp [bitRe, RegExp.denote]

theorem bitRe_accepts_one : [one] ∈ RegExp.denote bitRe := by
  simp [bitRe, RegExp.denote]

-- Using the eval_append lemma on a concrete DFA

/-- eval_append applied to `endsWithOneDFA`. -/
theorem endsWithOneDFA_eval_append (u v : Word Bit) :
    endsWithOneDFA.eval endsWithOneDFA.start (u ++ v) =
    endsWithOneDFA.eval (endsWithOneDFA.eval endsWithOneDFA.start u) v :=
  DFA.eval_append endsWithOneDFA endsWithOneDFA.start u v

-- Powerset construction: check it gives same results as the NFA

/-- Powerset DFA of `containsOneNFA` accepts `[zero, one]`. -/
theorem powerset_containsOne_accepts : containsOneNFA.toDFA.Accepts [zero, one] := by
  rw [NFA.toDFA_correct]
  exact containsOneNFA_accepts_zero_one

/-- Powerset DFA of `containsOneNFA` rejects `[zero, zero]`. -/
theorem powerset_containsOne_rejects : ¬ containsOneNFA.toDFA.Accepts [zero, zero] := by
  rw [NFA.toDFA_correct]
  exact containsOneNFA_rejects_zero_zero

end LeanW26
