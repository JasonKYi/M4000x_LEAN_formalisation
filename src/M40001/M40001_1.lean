-- begin header
import tactic.ring

meta def tactic.interactive.lefta := `[left, assumption]
meta def tactic.interactive.righta := `[right, assumption]

namespace M40001
-- end header

/- Section
1.7 Sets and Propositions
-/

universe u
variable {Ω : Type*}

-- Let $Ω$ be a fixed set with subsets $X$ and $Y$, then

/- Theorem
(1) $\bar{X ∪ Y} = \bar{X} ∩ \bar{Y}$,
-/
theorem de_morg_set_a (X Y : set Ω) : - (X ∪ Y) = - X ∩ - Y :=
begin
-- What exactly does $\bar{(X ∪ Y)}$ and $\bar{X} ∩ \bar{Y}$ mean? Well, lets find out!
    ext,
-- As we can see, to show that $\bar{X ∪ Y} = \bar{X} ∩ \bar{Y}$, we in fact need to prove $x ∈ \bar{(X ∪ Y)} ↔ x ∈ \bar{X} ∩ \bar{Y}$.
    split,
-- Thus, by considering both cases logically, we see that this is indeed true!
    {dsimp, intro h, 
    push_neg at h,
    assumption,
    },
    {dsimp, intro h,
    push_neg,
    assumption
    }
end

/- Theorem
(2) $\bar{X ∩ Y} = \bar{X} ∪ \bar{Y}$.
-/
theorem de_morg_set_b (X Y : set Ω) : - (X ∩ Y) = - X ∪ - Y :=
begin
-- Similar reasoning as the above theorem!
    ext, split,
    {dsimp, intro h, push_neg at h,
    cases h,
        {lefta},
        {righta},
    },
    {intro h, dsimp at h, dsimp, 
    rintro ⟨ha, hb⟩,
    cases h,
    all_goals {contradiction}
    }
end

/- Section
1.7.1 "For All" and "There Exists"
-/

/- Theorem
Given a propositon $P$ whose truth value is dependent on $x ∈ X$, then $∀ x ∈ X, ¬ P(x) ⇔ ¬ (∃ x ∈ X, P(x))$, and
-/
theorem neg_exist_is_all (X : Type) (P : X → Prop) : (∀ x : X, ¬ P x) ↔ ¬ (∃ x : X, P x) :=
begin
-- (⇒) Let's first prove the forward implication, i.e. given $∀ x ∈ X, ¬ P(x)$, we need to show that $¬ (∃ x ∈ X, P(x))$.
    split,
-- Let's prove this by contradiction! Let's suppose that our statement is in fact FALSE and there is actually a $x$ out there where $P(x)$ is true!
    {rintro h ⟨x, hx⟩,
-- But $∀ x ∈ X$, $P (x)$ is false, thus a contradiction! 
    from (h x) hx
    },
-- (⇐) Now let's consider the other direction. (Completing the proof is left as an exercise for the reader!)
    {intros ha x hx,
    have : ∃ (x : X), P x,  
        existsi x, assumption,
    contradiction,
    }
end

/- Theorem
$¬ (∀ x ∈ X, ¬ P(x)) ⇔ ∃ x ∈ X, P(x)$.
-/
theorem neg_all_is_exist (X : Type) (P : X → Prop) : ¬ (∀ x : X, ¬ P x) ↔ ∃ x : X, P x :=
begin
-- Try to do this one also!
    split,
    {intro h,
    apply classical.by_contradiction,
    push_neg, contradiction
    },
    {rintro ⟨x, hx⟩ h,
    from (h x) hx
    }
end

end M40001