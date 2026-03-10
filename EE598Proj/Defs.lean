import Mathlib

namespace LeanW26

variable {Q Alpha : Type}

abbrev Word (Alpha : Type) := List Alpha
abbrev Language (Alpha : Type) := Set (Word Alpha)

structure DFA (Q Alpha : Type) where
  start : Q
  step : Q → Alpha → Q
  accept : Set Q

def DFA.eval (M : DFA Q Alpha) : Q → Word Alpha → Q
  | q, [] => q
  | q, a :: w => M.eval (M.step q a) w

def DFA.Accepts (M : DFA Q Alpha) (w : Word Alpha) : Prop :=
  M.eval M.start w ∈ M.accept

structure NFA (Q Alpha : Type) where
  start : Set Q
  step : Q → Alpha → Set Q
  accept : Set Q

def NFA.stepSet (M : NFA Q Alpha) (S : Set Q) (a : Alpha) : Set Q :=
  {q' | ∃ q, q ∈ S ∧ q' ∈ M.step q a}

def NFA.eval (M : NFA Q Alpha) : Set Q → Word Alpha → Set Q
  | S, [] => S
  | S, a :: w => M.eval (M.stepSet S a) w

def NFA.Accepts (M : NFA Q Alpha) (w : Word Alpha) : Prop :=
  ∃ q, q ∈ M.eval M.start w ∧ q ∈ M.accept

inductive RegExp (Alpha : Type) where
  | empty : RegExp Alpha
  | epsilon : RegExp Alpha
  | char : Alpha → RegExp Alpha
  | union : RegExp Alpha → RegExp Alpha → RegExp Alpha
  | concat : RegExp Alpha → RegExp Alpha → RegExp Alpha
  | star : RegExp Alpha → RegExp Alpha

open RegExp

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
