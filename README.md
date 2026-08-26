# Carnival of the Liar (working title)

**Jam theme:** Trust No One
**Engine:** Godot 4

## Premise

Player is an inspector hired by a carnival manager to investigate whether
the carnival's stall owners are running their games fairly. The manager
hands the player a stack of **psychology profiles** describing lying
patterns (e.g. "always alternates lie/truth," "lies only when wearing
red," "only tells the truth when sad") — but the profiles are **not
labeled with names**. The player must figure out which profile belongs
to which owner, and in doing so, uncover the true rules of each carnival
game and whether each owner is actually cheating.

## Core Loop

1. Player has a set of unlabeled psychology profiles and a set of stall
   owners (same count, 1:1 match, unknown pairing).
2. Player spends limited **investigation actions** on owners:
   - Ask about the stall's rule (owner states a 2-4 line rule, possibly
     a lie, depending on their true, still-unknown profile).
   - **Play the stall's game** — a short, hands-on minigame. The rule the
     owner stated is the rule the player is told they are playing under;
     playing it is how the player finds out whether that rule is what the
     game actually does.
3. Playing is the evidence engine. If the game behaves as stated, that
   statement was true; if the payout, scoring, or win condition deviates
   from what was claimed, that statement was a lie. Each played round
   therefore stamps one of the owner's statements as truth or lie —
   which is exactly the input the profiles are matched against.
4. Using the (limited) evidence gathered, player tentatively matches
   profiles to owners — profiles that are inconsistent with the observed
   truth/lie record are ruled out. Because each profile is used exactly
   once, evidence about one owner narrows down the possibilities for the
   others too (elimination logic, like a logic grid puzzle).
5. Investigation actions are scarce relative to the number of owners —
   the player cannot fully interrogate or play every stall, so some
   assignments must be solved purely by elimination.
6. Player submits a final report: profile-to-owner matches, plus which
   owners were actually following their true rule vs. cheating.
7. Manager reacts based on report accuracy.

## Why This Fits the Theme

The player can't take any single piece of information at face value —
not the stated rules (owners lie per their pattern), not even which
pattern applies to whom (profiles are unlabeled and must be earned
through evidence). The only thing the player can trust is what they
personally made happen at the stall: trust is built by *playing* and
cross-checking outcomes against claims, never by being told.

## Design Decisions (locked)

- Lying patterns are told on the profile card itself (not inferred from
  scratch) — the puzzle is *matching*, not decoding an unknown pattern.
- "Playing the game" is a **real, playable minigame**, not a scripted
  round the player watches. The player's own hands-on result is the
  proof that a stated rule was honoured or broken — being the one who
  discovers the discrepancy is the point, and it makes the evidence feel
  earned rather than narrated.
- Minigames are **deliberately tiny and legible** (a handful of seconds,
  one mechanic each, outcome unambiguous) so that a single playthrough
  reads clearly as "matched the stated rule" or "did not," and so the
  authoring cost per owner stays inside jam scope.
- Each minigame is **deterministic or seeded** — no luck-based ambiguity.
  A player must never be unable to tell a cheat from bad luck.
- Investigation actions are a **limited, shared resource** across all
  owners (not unlimited/free revision) — this creates budgeting
  tension and forces elimination logic rather than brute-force checking
  every owner individually.
- Each stated rule is short: 2-4 lines, to keep writing/reading light,
  and must be *mechanically checkable* by playing the stall's minigame.

## Minigame Design Constraints

Every stall minigame must satisfy:

- **Playable in ~10-20 seconds**, one input mechanic, no tutorial beyond
  the owner's stated rule.
- **Verifiable against the stated rule**: the stated rule names a concrete
  quantity the player can check while playing (payout amount, number of
  attempts allowed, what counts as a win, which target scores).
- **Deterministic**: same inputs → same result, so a discrepancy is
  always the owner's doing.
- **Reuses a shared minigame framework**: a common start/play/result
  contract so a new stall is mostly data plus a small scene, not a new
  system.
- **Skippable-by-cost, not by boredom**: playing costs an action, so
  players choose *which* stalls to verify — the minigame is never busywork
  padding out a decision already made.

## Open Design Questions (still to settle)

- Exact number of owners/profiles for the jam build (target ~5-6).
- Exact investigation action budget (target: fewer total actions than
  needed to fully interrogate every owner independently, so elimination
  is mandatory).
- Whether "ask rule" and "play the game" are separate actions, or
  bundled as one "visit" action per owner.
- How many distinct minigames to build vs. reskin — one unique minigame
  per stall is the ideal, a small set of shared mechanics with different
  stated rules is the scope-safe fallback.
- Whether the player can replay a stall's minigame for free once it has
  been paid for (re-verification vs. action cost).
- What happens on a player *loss* in a minigame — whether losing still
  yields the truth/lie evidence, or whether the evidence needs a win.
  (Leaning: evidence is always yielded; losing must never cost progress.)
- Whether the manager's own profile intel can ever be wrong (a possible
  later twist, not required for jam scope).
- Fail-state / ending variation based on report accuracy.
- UI for tracking evidence and assignment state (logic-grid style
  confirmed/possible/ruled-out per profile-owner pair).
