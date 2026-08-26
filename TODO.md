# TODO — Carnival of the Liar

High-level steps only. Break each into details when you get there.

## 1. Lock the puzzle design
- [x] Decide owner/profile count for the jam build. -> 3 days: 3 / 4 / 5.
- [x] Decide investigation action budget (and whether ask/observe are separate or bundled). -> (number of owners x2) + 1.
- [ ] Write and hand-validate (or script-validate) that the puzzle is
      solvable within the action budget with a unique solution.
- [ ] Decide how many distinct minigames get built vs. reskinned
      (ideal: one per stall; fallback: shared mechanics, different
      stated rules).
- [ ] Decide whether losing a minigame still yields truth/lie evidence
      (leaning yes — a loss must never cost puzzle progress).
- [ ] Decide whether a paid-for stall can be replayed for free.

## 2. Write content
- [ ] Write all lying-pattern profiles.
- [ ] Write stated rule + true rule for each owner, making sure every
      stated rule names something the player can *check while playing*
      (payout, attempts allowed, win condition, target values).
- [ ] Design each stall's minigame concept: one mechanic, ~10-20s, and
      exactly how the true rule visibly deviates from the stated one.
- [ ] Write manager intro dialogue and report/ending reactions.
- [ ] Define visual "tells" for any condition-based lying patterns
      (outfit color, mood icon, etc).

## 3. Data structure / architecture
- [ ] Define owner data as a Godot Resource (stated rule, true rule,
      lie condition, tell, minigame scene + its rule parameters).
- [ ] Define the minigame rule-parameter schema — the same fields drive
      both what the owner *claims* and what the game *actually* runs, so
      a lie is just a mismatch between two parameter sets.
- [ ] Define profile data as a Resource (pattern description, logic
      for lie/truth evaluation).
- [ ] Decide save/state format for tracking player's evidence gathered
      and current profile-owner assignments.

## 4. Core systems
- [x] Dialogue/statement display system (simple, since lines are short).
- [ ] Investigation action system (spend action → get evidence, track
      remaining budget).
- [ ] Shared minigame framework: common start/play/result contract so a
      new stall is data + a small scene, not a new system.
- [ ] Build each stall's playable minigame against that framework
      (deterministic/seeded — never luck-ambiguous).
- [ ] Verdict system: compare the played result against the stated rule
      and stamp that statement as truth or lie in the evidence log.
- [ ] Post-round summary screen: "he said X, the game did Y" so the
      player can read the discrepancy without guesswork.
- [ ] Profile-to-owner assignment UI (drag/drop or click-to-match grid).
- [ ] Evidence tracking UI (confirmed / possible / ruled-out per pair).

## 5. Flow / scenes
- [ ] Manager intro scene.
- [ ] Hub scene (choose which owner to investigate / which action to
      spend).
- [ ] Owner interaction scene (statement → play the stall's minigame →
      result/verdict).
- [ ] Report/submission scene.
- [ ] Ending/result scene (manager reaction based on accuracy).

## 6. Art & audio
- [ ] Owner portraits (+ any tell variants, e.g. red outfit).
- [ ] Manager portrait.
- [ ] Carnival background/UI art.
- [ ] Minigame art per stall (playfield, props, win/lose feedback).
- [ ] SFX/music pass.

## 7. Polish & playtesting
- [ ] Playtest full puzzle solvability with a fresh player.
- [ ] Playtest that each minigame is readable enough that players
      actually *notice* the rule discrepancy on their own.
- [ ] Tune minigame difficulty so losing is possible but never blocks
      the investigation.
- [ ] Tune action budget based on playtest difficulty.
- [ ] Bug pass, edge cases (revisiting owners, re-assigning profiles).
- [ ] Final build export + jam submission checklist.
