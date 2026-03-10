import EE598Proj.Defs

namespace LeanW26

inductive Bit where
  | zero
  | one
  deriving DecidableEq, Repr

open Bit

def endsWithOneDFA : DFA Bool Bit where
  start := false
  step := fun _ a =>
    match a with
    | zero => false
    | one => true
  accept := {q | q = true}

example : endsWithOneDFA.Accepts [one] := by
  simp [DFA.Accepts, DFA.eval, endsWithOneDFA]

example : ¬ endsWithOneDFA.Accepts [one, zero] := by
  simp [DFA.Accepts, DFA.eval, endsWithOneDFA]

def containsOneNFA : NFA Bool Bit where
  start := {q | q = false}
  step := fun q a =>
    match q, a with
    | false, zero => {q' | q' = false}
    | false, one => {q' | q' = true}
    | true, _ => {q' | q' = true}
  accept := {q | q = true}

example : containsOneNFA.Accepts [zero, one] := by
  refine ⟨true, ?_, ?_⟩
  · simp [NFA.eval, NFA.stepSet, containsOneNFA]
  · simp [containsOneNFA]

example : ¬ containsOneNFA.Accepts [zero, zero] := by
  simp [NFA.Accepts, NFA.eval, NFA.stepSet, containsOneNFA]

def oneRe : RegExp Bit := RegExp.char one

example : [one] ∈ RegExp.denote oneRe := by
  simp [oneRe, RegExp.denote]

example : [zero] ∉ RegExp.denote oneRe := by
  simp [oneRe, RegExp.denote]

end LeanW26
