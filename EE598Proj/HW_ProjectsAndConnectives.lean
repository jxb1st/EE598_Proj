import Mathlib

/- ============================================================================
   X.1 PROJECTS - AI Conversation and Project Proposal
   ============================================================================ -/

/-
Q1: What are some interesting areas of computer science that could benefit from
formalization in Lean 4?

A1: Several areas could benefit: (1) Theory of computation - automata, Turing
machines, computability; (2) Programming language semantics - operational and
denotational semantics; (3) Cryptographic protocols - security proofs; (4)
Distributed algorithms - consensus protocols; (5) Data structures - functional
data structures with verified complexity bounds.

Q2: Has anyone formalized finite automata theory in Lean 4 or Mathlib?

A2: Mathlib has some automaton-related definitions, but comprehensive finite
automata theory with DFAs, NFAs, regular expressions, and their equivalences
is not fully developed. There's room for substantial contribution.

Q3: What would be the core components of a finite automata formalization?

A3: (1) Deterministic Finite Automata (DFA) definition; (2) Nondeterministic
Finite Automata (NFA) definition; (3) Regular expressions; (4) Conversion
algorithms (NFA to DFA, regex to NFA); (5) Equivalence proofs; (6) Closure
properties; (7) Pumping lemma; (8) Myhill-Nerode theorem.

Q4: Which of these components already exist in Mathlib?

A4: Mathlib has basic language and string definitions. Some automata
infrastructure exists but is limited. Most of the theoretical results
(pumping lemma, Myhill-Nerode) are not formalized.

Q5: What would be a realistic scope for 50 hours of work (10 hours/week for
5 weeks)?

A5: Focus on core definitions and 2-3 major results. Realistic goals:
(1) Define DFA and NFA with state type and alphabet; (2) Define language
acceptance; (3) Prove DFA/NFA equivalence; (4) Define regular expressions;
(5) Prove one direction of regex-NFA equivalence; (6) Prove pumping lemma.

Q6: What are the main challenges in formalizing automata theory?

A6: (1) Handling finite sets and finite types properly; (2) State reachability
and graph-like reasoning; (3) Inductive definitions for regular expressions;
(4) Powerset construction for NFA to DFA; (5) Ensuring termination for
recursive definitions.

Q7: How should states and alphabets be represented?

A7: Use type parameters: `structure DFA (Q : Type) (Σ : Type) where ...`.
This allows flexibility. For finite automata, can add `[Fintype Q]` and
`[DecidableEq Q]` constraints when needed.

Q8: What's the best way to represent the transition function?

A8: For DFA: `δ : Q → Σ → Q` (total function). For NFA: `δ : Q → Σ → Set Q`
or `δ : Q → Σ → List Q` depending on whether using classical or constructive
approach.

Q9: How do I define language acceptance?

A9: Define a function `accepts : DFA Q Σ → List Σ → Bool` that simulates the
automaton. For formal languages, define `language (M : DFA Q Σ) : Set (List Σ)`
as the set of strings accepted by M.

Q10: What's involved in proving DFA-NFA equivalence?

A10: Two directions: (1) Every DFA is an NFA (trivial); (2) Every NFA can be
converted to DFA via powerset construction. The second requires defining the
powerset automaton and proving it accepts the same language.

Q11: How difficult is the powerset construction proof?

A11: Moderate difficulty. Need to show: for any string w, w is accepted by NFA
iff w is accepted by the powerset DFA. Requires careful tracking of sets of
states and epsilon transitions if included.

Q12: Should epsilon transitions be included?

A12: For a 50-hour project, start without epsilon-NFAs to reduce complexity.
Can be added as future work if time permits.

Q13: How should regular expressions be defined?

A13: As an inductive type:
```lean
inductive RegExp (Σ : Type) where
  | empty : RegExp Σ
  | epsilon : RegExp Σ
  | char : Σ → RegExp Σ
  | union : RegExp Σ → RegExp Σ → RegExp Σ
  | concat : RegExp Σ → RegExp Σ → RegExp Σ
  | star : RegExp Σ → RegExp Σ
```

Q14: What's the pumping lemma proof strategy?

A14: Proof by contradiction using pigeonhole principle. For any regular
language L with DFA of n states, any string w of length ≥ n must visit some
state twice, creating a pumpable loop. Requires formalizing state sequences
and pigeonhole.

Q15: Are there existing Lean projects I should look at for guidance?

A15: Check: (1) Mathlib's computability library; (2) Mathlib's language
theory (if any); (3) Lean 3 formalizations that might exist; (4) Similar
projects in Coq (for proof strategies).

Q16: What prior art exists in other proof assistants?

A16: Coq has several automata formalizations (e.g., CoqAutomata library).
Isabelle/HOL has comprehensive regular language theory. These can guide proof
strategies but code won't transfer directly.

Q17: What would make this project a good contribution?

A17: (1) Well-documented API for automata; (2) Reusable abstractions;
(3) Integration with Mathlib conventions; (4) Comprehensive examples and tests;
(5) Clear README with motivation and usage.


Q18: Give me a citation list of relevant sources.

A18: Key references:
1. Hopcroft, Motwani, Ullman - "Introduction to Automata Theory, Languages,
   and Computation" (classic textbook)
2. Sipser - "Introduction to the Theory of Computation" (standard reference)
3. Kozen - "Automata and Computability" (concise treatment)
4. Mathlib documentation on computability theory
5. Braibant & Pous - "An efficient Coq tactic for deciding Kleene algebras"
6. Doczkal & Smolka - "Regular Language Representations in Coq" (AFAIK,
   describes Coq formalization strategies)

-/

/-
Final Project Proposal
===

Title: Formalizing Finite Automata Theory in Lean 4

Objective:
Create a formalized library of finite automata theory including deterministic
and nondeterministic automata, regular expressions, and fundamental theorems
about regular languages.

Concrete Goals:
1. Define DFA and NFA structures with parameterized state and alphabet types
2. Implement language acceptance functions with formal semantics
3. Prove equivalence of DFAs and NFAs via powerset construction
4. Define regular expressions as an inductive type
5. Prove regular expressions can be converted to NFAs
6. Formalize and prove the pumping lemma for regular languages

Timeline (5 weeks, 10 hours/week):
- Week 1: Core definitions (DFA, NFA, basic properties)
- Week 2: Language acceptance and simple closure properties
- Week 3: Powerset construction and DFA-NFA equivalence proof
- Week 4: Regular expression definitions and conversion to NFA
- Week 5: Pumping lemma formalization and proof

Expected Outcomes:
- Standalone Lean 4 library with well-documented API
- Proof-of-concept for contributing to Mathlib's computability section
- Foundation for future work on parsing, language decision procedures
- Pedagogical resource for teaching formal methods

Why This Project Is Interesting:
- Automata theory is foundational to CS but underrepresented in Lean
- Provides practical verification tools for language processing
- Connects computation theory with type theory
- Creates reusable abstractions for future projects

Repository Structure:
- Public GitHub repository with MIT license
- Comprehensive README with examples
- Well-commented code following Mathlib conventions
- Test suite with example automata
- Documentation of design decisions

-/

/- ============================================================================
   III.3 CONNECTIVES - Exercise 1
   ============================================================================ -/

variable (p q r : Prop)

example : p ∧ (q ∧ r) → (p ∧ q) ∧ r :=
  fun ⟨hp, hq, hr⟩ => ⟨⟨hp, hq⟩, hr⟩

/- ============================================================================
   III.3 CONNECTIVES - Exercise 2
   ============================================================================ -/

example : (p ↔ q) ↔ (p → q) ∧ (q → p) :=
  ⟨fun ⟨hpq, hqp⟩ => ⟨hpq, hqp⟩, fun ⟨hpq, hqp⟩ => ⟨hpq, hqp⟩⟩

/- ============================================================================
   III.3 CONNECTIVES - Exercise 3.1
   ============================================================================ -/

example : p ∨ q ↔ q ∨ p :=
  ⟨fun hpq => match hpq with
    | Or.inl hp => Or.inr hp
    | Or.inr hq => Or.inl hq,
   fun hqp => match hqp with
    | Or.inl hq => Or.inr hq
    | Or.inr hp => Or.inl hp⟩

/- ============================================================================
   III.3 CONNECTIVES - Exercise 3.2
   ============================================================================ -/

example : (p ∨ q) ∨ r ↔ p ∨ (q ∨ r) :=
  ⟨fun hpqr => match hpqr with
    | Or.inl hpq => match hpq with
      | Or.inl hp => Or.inl hp
      | Or.inr hq => Or.inr (Or.inl hq)
    | Or.inr hr => Or.inr (Or.inr hr),
   fun hpqr => match hpqr with
    | Or.inl hp => Or.inl (Or.inl hp)
    | Or.inr hqr => match hqr with
      | Or.inl hq => Or.inl (Or.inr hq)
      | Or.inr hr => Or.inr hr⟩

/- ============================================================================
   III.3 CONNECTIVES - Exercise 3.3
   ============================================================================ -/

example : ¬(p ∨ q) ↔ ¬p ∧ ¬q :=
  ⟨fun hnpq => ⟨fun hp => hnpq (Or.inl hp), fun hq => hnpq (Or.inr hq)⟩,
   fun ⟨hnp, hnq⟩ hpq => match hpq with
    | Or.inl hp => hnp hp
    | Or.inr hq => hnq hq⟩

/- ============================================================================
   III.3 CONNECTIVES - Exercise 3.4
   ============================================================================ -/

example : ¬(p ∧ ¬p) :=
  fun ⟨hp, hnp⟩ => hnp hp

/- ============================================================================
   III.3 CONNECTIVES - Exercise 3.5
   ============================================================================ -/

example : (¬p ∨ q) → (p → q) :=
  fun hnpq hp => match hnpq with
    | Or.inl hnp => False.elim (hnp hp)
    | Or.inr hq => hq

/- ============================================================================
   III.3 CONNECTIVES - Exercise 3.6
   ============================================================================ -/

example : p ∨ False ↔ p :=
  ⟨fun hpf => match hpf with
    | Or.inl hp => hp
    | Or.inr hf => False.elim hf,
   fun hp => Or.inl hp⟩

/- ============================================================================
   III.3 CONNECTIVES - Exercise 3.7
   ============================================================================ -/

example : p ∧ False ↔ False :=
  ⟨fun ⟨_, hf⟩ => hf, fun hf => False.elim hf⟩

/- ============================================================================
   III.3 CONNECTIVES - Exercise 4
   ============================================================================ -/

example : (p → q) → (¬p ∨ q) :=
  fun hpq => match Classical.em p with
    | Or.inl hp => Or.inr (hpq hp)
    | Or.inr hnp => Or.inl hnp

/- ============================================================================
   III.3 CONNECTIVES - Exercise 5
   ============================================================================ -/

inductive Nor (p q : Prop) : Prop where
  | intro : ¬p → ¬q → Nor p q

def Nor.elim_left {p q : Prop} (hnpq : Nor p q) : ¬p :=
  match hnpq with
  | Nor.intro hnp _ => hnp

def Nor.elim_right {p q : Prop} (hnpq : Nor p q) : ¬q :=
  match hnpq with
  | Nor.intro _ hnq => hnq

/- ============================================================================
   III.3 CONNECTIVES - Exercise 6.1
   ============================================================================ -/

example : ¬p → (Nor p p) :=
  fun hnp => Nor.intro hnp hnp

/- ============================================================================
   III.3 CONNECTIVES - Exercise 6.2
   ============================================================================ -/

example : (Nor p q) → ¬(p ∨ q) :=
  fun hnpq hpq => match hpq with
    | Or.inl hp => (Nor.elim_left hnpq) hp
    | Or.inr hq => (Nor.elim_right hnpq) hq

/- ============================================================================
   III.3 CONNECTIVES - Exercise 6.3
   ============================================================================ -/

example : ¬(p ∨ q) → (Nor p q) :=
  fun hnpq => Nor.intro (fun hp => hnpq (Or.inl hp)) (fun hq => hnpq (Or.inr hq))
