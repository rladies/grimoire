# skill_update() / reports nothing to update when no skills are installed

    Code
      result <- skill_update(path = root)
    Message
      No skills installed at '<root>' — nothing to update.

# skill_update() / errors when asked to update a skill that isn't installed

    Code
      skill_update("other-skill", path = root)
    Condition
      Error in `skill_update()`:
      x Not installed at '<root>': "other-skill"
      i Use `use_skill()` to install it first.

# skill_update() / skips a skill that is already up to date

    Code
      result <- skill_update("demo-skill", path = root)
    Message
      
      -- Updating 1 skill to "v0.1.0" ------------------------------------------------
      i demo-skill is already up to date ("v0.1.0")

# skill_update() / updates a skill when the resolved sha has moved on

    Code
      result <- skill_update("demo-skill", path = root)
    Message
      
      -- Updating 1 skill to "v0.1.0" ------------------------------------------------
      v Installed demo-skill ("v0.1.0") to '<root>/skills/demo-skill'

# skill_update() / skips a locally modified skill without force

    Code
      result <- skill_update("demo-skill", path = root)
    Message
      
      -- Updating 1 skill to "v0.1.0" ------------------------------------------------
      ! demo-skill has local changes — skipping (`force = TRUE` to overwrite)

# skill_update() / updates a locally modified skill when force = TRUE

    Code
      result <- skill_update("demo-skill", path = root, force = TRUE)
    Message
      
      -- Updating 1 skill to "v0.1.0" ------------------------------------------------
      v Installed demo-skill ("v0.1.0") to '<root>/skills/demo-skill'

# skill_update() / defaults to updating every installed skill

    Code
      result <- skill_update(path = root)
    Message
      
      -- Updating 2 skills to "v0.1.0" -----------------------------------------------
      v Installed demo-skill ("v0.1.0") to '<root>/skills/demo-skill'
      v Installed other-skill ("v0.1.0") to '<root>/skills/other-skill'

# skill_update() / only sees skills installed under the same target

    Code
      result <- skill_update("demo-skill", path = root)
    Message
      No skills installed at '<root>' — nothing to update.

---

    Code
      result <- skill_update("demo-skill", path = root, target = "opencode")
    Message
      
      -- Updating 1 skill to "v0.1.0" ------------------------------------------------
      v Installed demo-skill ("v0.1.0") to '<root>/.opencode/skills/demo-skill'

