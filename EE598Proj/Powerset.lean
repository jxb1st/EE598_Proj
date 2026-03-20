import EE598Proj.Defs
import EE598Proj.Lemmas

namespace LeanW26

variable {Q Alpha : Type}

/-! # NFA to DFA powerset construction

Convert an NFA to a DFA where each DFA state is a set of NFA states.
Then prove the converted DFA accepts the same language.
-/

/-- Convert NFA to DFA via subset construction.
DFA states are `Set Q`, start is the NFA start set, step uses `stepSet`. -/
def NFA.toDFA (M : NFA Q Alpha) : DFA (Set Q) Alpha where
  start := M.start
  step := fun S a => M.stepSet S a
  accept := {S | ∃ q, q ∈ S ∧ q ∈ M.accept}

/-- The converted DFA evals the same way as the original NFA. -/
theorem NFA.toDFA_eval (M : NFA Q Alpha) (S : Set Q) (w : Word Alpha) :
    M.toDFA.eval S w = M.eval S w := by
  induction w generalizing S with
  | nil => rfl
  | cons a w ih => exact ih (M.stepSet S a)

/-- Main correctness theorem: the powerset DFA accepts the same language as the NFA. -/
theorem NFA.toDFA_correct (M : NFA Q Alpha) (w : Word Alpha) :
    M.toDFA.Accepts w ↔ M.Accepts w := by
  unfold DFA.Accepts NFA.Accepts
  show M.toDFA.eval M.toDFA.start w ∈ M.toDFA.accept ↔ _
  rw [toDFA_eval]
  simp [toDFA]

end LeanW26
