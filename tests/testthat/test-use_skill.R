describe("use_skill()", {
  it("installs a skill's files and records a manifest entry", {
    local_mocked_download()
    root <- withr::local_tempdir()

    expect_snapshot(
      result <- use_skill("demo-skill", path = root),
      transform = redact_path(root)
    )

    dest <- skill_dir(root, "demo-skill")
    expect_true(fs::file_exists(fs::path(dest, "SKILL.md")))
    expect_true(fs::file_exists(fs::path(dest, "references", "foo.md")))
    expect_equal(result, as.character(dest))

    manifest <- read_manifest(root)
    expect_equal(manifest$skills[["demo-skill"]]$ref, "v0.1.0")
    expect_false(is.na(manifest$skills[["demo-skill"]]$checksum))
  })

  it("installs multiple skills at once", {
    local_mocked_download()
    root <- withr::local_tempdir()

    expect_snapshot(
      result <- use_skill(c("demo-skill", "other-skill"), path = root),
      transform = redact_path(root)
    )

    expect_length(result, 2)
    expect_true(fs::dir_exists(skill_dir(root, "demo-skill")))
    expect_true(fs::dir_exists(skill_dir(root, "other-skill")))
  })

  it("skips an already-installed skill without force", {
    root <- withr::local_tempdir()
    install_skills(root, "demo-skill")
    skill_file <- fs::path(skill_dir(root, "demo-skill"), "SKILL.md")
    writeLines("hand-edited", skill_file)

    local_mocked_download()
    expect_snapshot(
      use_skill("demo-skill", path = root),
      transform = redact_path(root)
    )

    expect_equal(readLines(skill_file), "hand-edited")
  })

  it("overwrites an already-installed skill when force = TRUE", {
    root <- withr::local_tempdir()
    install_skills(root, "demo-skill")
    skill_file <- fs::path(skill_dir(root, "demo-skill"), "SKILL.md")
    writeLines("hand-edited", skill_file)

    local_mocked_download()
    expect_snapshot(
      use_skill("demo-skill", path = root, force = TRUE),
      transform = redact_path(root)
    )

    expect_equal(readLines(skill_file)[1], "---")
    expect_false(identical(readLines(skill_file), "hand-edited"))
  })

  it("errors on an unknown skill name", {
    local_mocked_download()
    root <- withr::local_tempdir()
    expect_snapshot(use_skill("not-a-skill", path = root), error = TRUE)
  })

  it("errors when skill is not a non-empty character vector", {
    expect_snapshot(use_skill(character()), error = TRUE)
    expect_snapshot(use_skill(1), error = TRUE)
  })

  it("errors on an invalid target", {
    root <- withr::local_tempdir()
    expect_snapshot(
      use_skill("demo-skill", path = root, target = "bogus"),
      error = TRUE
    )
  })

  it("installs under the requested target directory", {
    root <- withr::local_tempdir()
    install_skills(root, "demo-skill", target = "opencode")

    expect_true(fs::dir_exists(fs::path(
      root,
      ".opencode",
      "skills",
      "demo-skill"
    )))
    expect_false(fs::dir_exists(fs::path(root, "skills", "demo-skill")))
  })

  it("removes the partial install directory when a download fails", {
    root <- withr::local_tempdir()
    calls <- 0L
    testthat::local_mocked_bindings(
      resolve_ref = function(repo, ref = NULL) "v0.1.0",
      resolve_commit_sha = function(repo, ref) "deadbeef",
      get_repo_tree = function(repo, sha) fixture_tree(),
      download_file_to = function(repo, sha, path, dest) {
        calls <<- calls + 1L
        if (calls > 1L) {
          stop("network blip")
        }
        fs::dir_create(fs::path_dir(dest), recurse = TRUE)
        writeLines("content", dest)
        invisible(dest)
      }
    )

    expect_snapshot(use_skill("demo-skill", path = root), error = TRUE)
    expect_false(fs::dir_exists(skill_dir(root, "demo-skill")))
  })
})
