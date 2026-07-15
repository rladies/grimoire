describe("skill_remove()", {
  it("informs when the skill isn't installed", {
    root <- withr::local_tempdir()
    expect_snapshot(
      result <- skill_remove("demo-skill", path = root),
      transform = redact_path(root)
    )
    expect_equal(result, character())
  })

  it("removes an unmodified installed skill and cleans up the manifest", {
    root <- withr::local_tempdir()
    install_skills(root, "demo-skill")

    expect_snapshot(result <- skill_remove("demo-skill", path = root))

    expect_equal(result, "demo-skill")
    expect_false(fs::dir_exists(skill_dir(root, "demo-skill")))
    expect_false(fs::file_exists(manifest_path(root)))
    expect_false(fs::dir_exists(fs::path(root, "skills")))
  })

  it("keeps the manifest when other skills remain installed", {
    root <- withr::local_tempdir()
    install_skills(root, c("demo-skill", "other-skill"))

    testthat::capture_messages(skill_remove("demo-skill", path = root))

    expect_true(fs::file_exists(manifest_path(root)))
    manifest <- read_manifest(root)
    expect_equal(names(manifest$skills), "other-skill")
  })

  it("skips a locally modified skill without force", {
    root <- withr::local_tempdir()
    install_skills(root, "demo-skill")
    skill_file <- fs::path(skill_dir(root, "demo-skill"), "SKILL.md")
    writeLines("hand-edited", skill_file)

    expect_snapshot(result <- skill_remove("demo-skill", path = root))

    expect_equal(result, character())
    expect_true(fs::dir_exists(skill_dir(root, "demo-skill")))
  })

  it("removes a locally modified skill when force = TRUE", {
    root <- withr::local_tempdir()
    install_skills(root, "demo-skill")
    skill_file <- fs::path(skill_dir(root, "demo-skill"), "SKILL.md")
    writeLines("hand-edited", skill_file)

    expect_snapshot(
      result <- skill_remove("demo-skill", path = root, force = TRUE)
    )

    expect_equal(result, "demo-skill")
    expect_false(fs::dir_exists(skill_dir(root, "demo-skill")))
  })

  it("removes multiple skills at once", {
    root <- withr::local_tempdir()
    install_skills(root, c("demo-skill", "other-skill"))

    expect_snapshot(
      result <- skill_remove(c("demo-skill", "other-skill"), path = root)
    )

    expect_equal(sort(result), c("demo-skill", "other-skill"))
    expect_false(fs::dir_exists(fs::path(root, "skills")))
  })

  it("errors when skill is not a non-empty character vector", {
    expect_snapshot(skill_remove(character()), error = TRUE)
  })

  it("only removes skills installed under the same target", {
    root <- withr::local_tempdir()
    install_skills(root, "demo-skill", target = "opencode")

    testthat::capture_messages(skill_remove("demo-skill", path = root))
    expect_true(fs::dir_exists(fs::path(
      root,
      ".opencode",
      "skills",
      "demo-skill"
    )))

    expect_snapshot(
      result <- skill_remove("demo-skill", path = root, target = "opencode")
    )
    expect_equal(result, "demo-skill")
    expect_false(fs::dir_exists(fs::path(
      root,
      ".opencode",
      "skills",
      "demo-skill"
    )))
  })
})
