describe("skill_update()", {
  it("reports nothing to update when no skills are installed", {
    root <- withr::local_tempdir()
    expect_snapshot(
      result <- skill_update(path = root),
      transform = redact_path(root)
    )
    expect_equal(result, character())
  })

  it("errors when asked to update a skill that isn't installed", {
    root <- withr::local_tempdir()
    install_skills(root, "demo-skill")
    expect_snapshot(
      skill_update("other-skill", path = root),
      error = TRUE,
      transform = redact_path(root)
    )
  })

  it("skips a skill that is already up to date", {
    root <- withr::local_tempdir()
    install_skills(root, "demo-skill")

    local_mocked_download()
    expect_snapshot(result <- skill_update("demo-skill", path = root))
    expect_equal(result, character())
  })

  it("updates a skill when the resolved sha has moved on", {
    root <- withr::local_tempdir()
    install_skills(root, "demo-skill", sha = "deadbeef")

    local_mocked_download(sha = "newsha")
    expect_snapshot(
      result <- skill_update("demo-skill", path = root),
      transform = redact_path(root)
    )

    expect_equal(result, "demo-skill")
    manifest <- read_manifest(root)
    expect_equal(manifest$skills[["demo-skill"]]$sha, "newsha")
  })

  it("skips a locally modified skill without force", {
    root <- withr::local_tempdir()
    install_skills(root, "demo-skill", sha = "deadbeef")
    skill_file <- fs::path(skill_dir(root, "demo-skill"), "SKILL.md")
    writeLines("hand-edited", skill_file)

    local_mocked_download(sha = "newsha")
    expect_snapshot(result <- skill_update("demo-skill", path = root))

    expect_equal(result, character())
    expect_equal(readLines(skill_file), "hand-edited")
  })

  it("updates a locally modified skill when force = TRUE", {
    root <- withr::local_tempdir()
    install_skills(root, "demo-skill", sha = "deadbeef")
    skill_file <- fs::path(skill_dir(root, "demo-skill"), "SKILL.md")
    writeLines("hand-edited", skill_file)

    local_mocked_download(sha = "newsha")
    expect_snapshot(
      result <- skill_update("demo-skill", path = root, force = TRUE),
      transform = redact_path(root)
    )

    expect_equal(result, "demo-skill")
    expect_equal(readLines(skill_file)[1], "---")
  })

  it("defaults to updating every installed skill", {
    root <- withr::local_tempdir()
    install_skills(root, c("demo-skill", "other-skill"), sha = "deadbeef")

    local_mocked_download(sha = "newsha")
    expect_snapshot(
      result <- skill_update(path = root),
      transform = redact_path(root)
    )

    expect_equal(sort(result), c("demo-skill", "other-skill"))
  })

  it("only sees skills installed under the same target", {
    root <- withr::local_tempdir()
    install_skills(root, "demo-skill", target = "opencode")

    expect_snapshot(
      result <- skill_update("demo-skill", path = root),
      transform = redact_path(root)
    )
    expect_equal(result, character())

    local_mocked_download(sha = "newsha")
    expect_snapshot(
      result <- skill_update("demo-skill", path = root, target = "opencode"),
      transform = redact_path(root)
    )
    expect_equal(result, "demo-skill")
  })
})
