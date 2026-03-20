import EE598Proj.Defs

namespace LeanW26

variable {Q Alpha : Type}

/-! # Lemmas for DFA and NFA eval

Basic properties: base case, cons unfolding, append, and monotonicity.
-/

-- DFA lemmas

/-- Eval on empty word gives back the same state. -/
@[simp]
theorem DFA.eval_nil (M : DFA Q Alpha) (q : Q) :
    M.eval q [] = q := rfl

/-- Eval on `a :: w`: step once, then eval the rest. -/
@[simp]
theorem DFA.eval_cons (M : DFA Q Alpha) (q : Q) (a : Alpha) (w : Word Alpha) :
    M.eval q (a :: w) = M.eval (M.step q a) w := rfl

/-- Eval distributes over append: `eval q (u ++ v) = eval (eval q u) v`. -/
theorem DFA.eval_append (M : DFA Q Alpha) (q : Q) (u v : Word Alpha) :
    M.eval q (u ++ v) = M.eval (M.eval q u) v := by
  induction u generalizing q with
  | nil => simp [eval]
  | cons a u ih => simp [eval, ih]

/-- Unfolding lemma for `DFA.Accepts`. -/
theorem DFA.Accepts_iff (M : DFA Q Alpha) (w : Word Alpha) :
    M.Accepts w ↔ M.eval M.start w ∈ M.accept := by
  rfl

-- NFA lemmas

/-- NFA eval on empty word gives back the same state set. -/
@[simp]
theorem NFA.eval_nil (M : NFA Q Alpha) (S : Set Q) :
    M.eval S [] = S := rfl

/-- NFA eval on `a :: w`: step once, then eval the rest. -/
@[simp]
theorem NFA.eval_cons (M : NFA Q Alpha) (S : Set Q) (a : Alpha) (w : Word Alpha) :
    M.eval S (a :: w) = M.eval (M.stepSet S a) w := rfl

/-- stepSet is monotone: bigger input set gives bigger output set. -/
theorem NFA.stepSet_mono (M : NFA Q Alpha) {S T : Set Q} (h : S ⊆ T) (a : Alpha) :
    M.stepSet S a ⊆ M.stepSet T a := by
  intro q' ⟨q, hqS, hq'⟩
  exact ⟨q, h hqS, hq'⟩

/-- NFA eval is monotone in the state set. -/
theorem NFA.eval_mono (M : NFA Q Alpha) {S T : Set Q} (h : S ⊆ T) (w : Word Alpha) :
    M.eval S w ⊆ M.eval T w := by
  induction w generalizing S T with
  | nil => exact h
  | cons a w ih => exact ih (M.stepSet_mono h a)

/-- NFA eval distributes over append. -/
theorem NFA.eval_append (M : NFA Q Alpha) (S : Set Q) (u v : Word Alpha) :
    M.eval S (u ++ v) = M.eval (M.eval S u) v := by
  induction u generalizing S with
  | nil => simp [eval]
  | cons a u ih => simp [eval, ih]

end LeanW26
