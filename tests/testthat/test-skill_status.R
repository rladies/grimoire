describe("skill_status()", {
  it("reports nothing installed", {
    root <- withr::local_tempdir()
    expect_snapshot(
      result <- skill_status(path = root),
      transform = redact_path(root)
    )
    expect_equal(nrow(result), 0)
  })

  it("reports installed skills and modification state", {
    root <- withr::local_tempdir()
    install_skills(root, c("demo-skill", "other-skill"))
    writeLines(
      "hand-edited",
      fs::path(skill_dir(root, "demo-skill"), "SKILL.md")
    )

    expect_snapshot(result <- skill_status(path = root))

    result <- result[order(result$skill), ]
    expect_equal(result$skill, c("demo-skill", "other-skill"))
    expect_equal(result$modified, c(TRUE, FALSE))
    expect_equal(result$ref, c("v0.1.0", "v0.1.0"))
  })

  it("keeps different targets isolated", {
    root <- withr::local_tempdir()
    install_skills(root, "demo-skill", target = "opencode")

    expect_snapshot(
      default_status <- skill_status(path = root),
      transform = redact_path(root)
    )
    expect_snapshot(
      opencode_status <- skill_status(path = root, target = "opencode")
    )

    expect_equal(nrow(default_status), 0)
    expect_equal(opencode_status$skill, "demo-skill")
  })
})
