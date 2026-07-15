# use_skill() / installs a skill's files and records a manifest entry

    Code
      result <- use_skill("demo-skill", path = root)
    Message
      
      -- Fetching 1 skill from "rladies/grimoire" ------------------------------------
      v Installed demo-skill ("v0.1.0") to '<root>/skills/demo-skill'

# use_skill() / installs multiple skills at once

    Code
      result <- use_skill(c("demo-skill", "other-skill"), path = root)
    Message
      
      -- Fetching 2 skills from "rladies/grimoire" -----------------------------------
      v Installed demo-skill ("v0.1.0") to '<root>/skills/demo-skill'
      v Installed other-skill ("v0.1.0") to '<root>/skills/other-skill'

# use_skill() / skips an already-installed skill without force

    Code
      use_skill("demo-skill", path = root)
    Message
      
      -- Fetching 1 skill from "rladies/grimoire" ------------------------------------
      i demo-skill already exists at '<root>/skills/demo-skill' — skipping (`force = TRUE` to overwrite)

# use_skill() / overwrites an already-installed skill when force = TRUE

    Code
      use_skill("demo-skill", path = root, force = TRUE)
    Message
      
      -- Fetching 1 skill from "rladies/grimoire" ------------------------------------
      v Installed demo-skill ("v0.1.0") to '<root>/skills/demo-skill'

# use_skill() / errors on an unknown skill name

    Code
      use_skill("not-a-skill", path = root)
    Message
      
      -- Fetching 1 skill from "rladies/grimoire" ------------------------------------
    Condition
      Error in `use_skill()`:
      x Unknown skill: "not-a-skill"
      i Run `available_skills()` to see valid names.

# use_skill() / errors when skill is not a non-empty character vector

    Code
      use_skill(character())
    Condition
      Error in `use_skill()`:
      ! `skill` must be a non-empty character vector.

---

    Code
      use_skill(1)
    Condition
      Error in `use_skill()`:
      ! `skill` must be a non-empty character vector.

# use_skill() / errors on an invalid target

    Code
      use_skill("demo-skill", path = root, target = "bogus")
    Condition
      Error in `match.arg()`:
      ! 'arg' should be one of "default", "claude", "opencode", "agents"

# use_skill() / removes the partial install directory when a download fails

    Code
      use_skill("demo-skill", path = root)
    Message
      
      -- Fetching 1 skill from "rladies/grimoire" ------------------------------------
    Condition
      Error in `download_file_to()`:
      ! network blip

