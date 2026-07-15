# check_skill_arg() / errors on an empty or non-character value

    Code
      check_skill_arg(character())
    Condition
      Error:
      ! `skill` must be a non-empty character vector.

---

    Code
      check_skill_arg(1)
    Condition
      Error:
      ! `skill` must be a non-empty character vector.

