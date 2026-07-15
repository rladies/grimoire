# skill_status() / reports nothing installed

    Code
      result <- skill_status(path = root)
    Message
      No skills installed at '<root>'.

# skill_status() / reports installed skills and modification state

    Code
      result <- skill_status(path = root)
    Message
      ! demo-skill ("v0.1.0") — locally modified
      v other-skill ("v0.1.0")

# skill_status() / keeps different targets isolated

    Code
      default_status <- skill_status(path = root)
    Message
      No skills installed at '<root>'.

---

    Code
      opencode_status <- skill_status(path = root, target = "opencode")
    Message
      v demo-skill ("v0.1.0")

