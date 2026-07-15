# skill_remove() / informs when the skill isn't installed

    Code
      result <- skill_remove("demo-skill", path = root)
    Message
      i demo-skill is not installed at '<root>'

# skill_remove() / removes an unmodified installed skill and cleans up the manifest

    Code
      result <- skill_remove("demo-skill", path = root)
    Message
      v Removed demo-skill

# skill_remove() / skips a locally modified skill without force

    Code
      result <- skill_remove("demo-skill", path = root)
    Message
      ! demo-skill has local changes or is untracked — skipping (`force = TRUE` to remove anyway)

# skill_remove() / removes a locally modified skill when force = TRUE

    Code
      result <- skill_remove("demo-skill", path = root, force = TRUE)
    Message
      v Removed demo-skill

# skill_remove() / removes multiple skills at once

    Code
      result <- skill_remove(c("demo-skill", "other-skill"), path = root)
    Message
      v Removed demo-skill
      v Removed other-skill

# skill_remove() / errors when skill is not a non-empty character vector

    Code
      skill_remove(character())
    Condition
      Error in `skill_remove()`:
      ! `skill` must be a non-empty character vector.

# skill_remove() / only removes skills installed under the same target

    Code
      result <- skill_remove("demo-skill", path = root, target = "opencode")
    Message
      v Removed demo-skill

