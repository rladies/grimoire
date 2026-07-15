describe("target_prefix()", {
  it("maps each target to its directory prefix", {
    expect_equal(target_prefix("default"), "")
    expect_equal(target_prefix("claude"), ".claude")
    expect_equal(target_prefix("opencode"), ".opencode")
    expect_equal(target_prefix("agents"), ".agents")
  })
})

describe("resolve_target_path()", {
  it("leaves path unchanged for the default target", {
    expect_equal(
      resolve_target_path("my-project", "default"),
      fs::path("my-project")
    )
  })

  it("appends the target directory otherwise", {
    expect_equal(
      resolve_target_path("my-project", "opencode"),
      fs::path("my-project", ".opencode")
    )
    expect_equal(resolve_target_path(".", "claude"), fs::path(".", ".claude"))
  })
})

describe("compute_skill_checksum()", {
  it("is stable for identical content", {
    dir1 <- withr::local_tempdir()
    dir2 <- withr::local_tempdir()
    writeLines("a", fs::path(dir1, "SKILL.md"))
    fs::dir_create(fs::path(dir1, "references"))
    writeLines("b", fs::path(dir1, "references", "foo.md"))
    writeLines("a", fs::path(dir2, "SKILL.md"))
    fs::dir_create(fs::path(dir2, "references"))
    writeLines("b", fs::path(dir2, "references", "foo.md"))

    expect_equal(compute_skill_checksum(dir1), compute_skill_checksum(dir2))
  })

  it("changes when file content changes", {
    dir <- withr::local_tempdir()
    writeLines("a", fs::path(dir, "SKILL.md"))
    before <- compute_skill_checksum(dir)
    writeLines("changed", fs::path(dir, "SKILL.md"))
    after <- compute_skill_checksum(dir)
    expect_false(identical(before, after))
  })

  it("returns NA for an empty directory", {
    dir <- withr::local_tempdir()
    expect_true(is.na(compute_skill_checksum(dir)))
  })
})

describe("read_manifest() / write_manifest()", {
  it("round-trips a manifest", {
    root <- withr::local_tempdir()
    manifest <- list(
      repo = "rladies/grimoire",
      skills = list(
        "demo-skill" = list(
          ref = "v0.1.0",
          sha = "deadbeef",
          checksum = "abc",
          installed_at = "2026-01-01T00:00:00Z"
        )
      )
    )
    write_manifest(root, manifest)
    roundtripped <- read_manifest(root)
    expect_equal(roundtripped$repo, "rladies/grimoire")
    expect_equal(roundtripped$skills[["demo-skill"]]$sha, "deadbeef")
  })

  it("returns an empty manifest when no file exists", {
    root <- withr::local_tempdir()
    manifest <- read_manifest(root)
    expect_null(manifest$repo)
    expect_equal(manifest$skills, list())
  })

  it("defaults skills to an empty list when the manifest file lacks one", {
    root <- withr::local_tempdir()
    fs::dir_create(fs::path(root, "skills"), recurse = TRUE)
    jsonlite::write_json(
      list(repo = "rladies/grimoire"),
      manifest_path(root),
      auto_unbox = TRUE
    )

    manifest <- read_manifest(root)
    expect_equal(manifest$repo, "rladies/grimoire")
    expect_equal(manifest$skills, list())
  })
})

describe("update_manifest_entry()", {
  it("adds a skill entry and persists it", {
    root <- withr::local_tempdir()
    update_manifest_entry(
      root,
      "rladies/grimoire",
      "demo-skill",
      "v0.1.0",
      "deadbeef",
      "checksum123"
    )
    manifest <- read_manifest(root)
    expect_equal(manifest$skills[["demo-skill"]]$checksum, "checksum123")
    expect_equal(manifest$repo, "rladies/grimoire")
  })
})

describe("skill_is_modified()", {
  it("returns NA when there is no checksum to compare against", {
    dest <- withr::local_tempdir()
    expect_true(is.na(skill_is_modified(dest, NULL)))
  })

  it("returns NA when the directory does not exist", {
    missing <- fs::path(withr::local_tempdir(), "missing")
    expect_true(is.na(skill_is_modified(missing, "abc")))
  })

  it("returns FALSE when on-disk content matches the checksum", {
    dest <- withr::local_tempdir()
    writeLines("content", fs::path(dest, "SKILL.md"))
    checksum <- compute_skill_checksum(dest)

    expect_false(skill_is_modified(dest, checksum))
  })

  it("returns TRUE when local files have been edited", {
    dest <- withr::local_tempdir()
    writeLines("content", fs::path(dest, "SKILL.md"))
    checksum <- compute_skill_checksum(dest)

    writeLines("hand-edited", fs::path(dest, "SKILL.md"))
    expect_true(skill_is_modified(dest, checksum))
  })
})

describe("check_skill_arg()", {
  it("passes silently for a non-empty character vector", {
    expect_no_error(check_skill_arg("demo-skill"))
    expect_no_error(check_skill_arg(c("demo-skill", "other-skill")))
  })

  it("errors on an empty or non-character value", {
    expect_snapshot(check_skill_arg(character()), error = TRUE)
    expect_snapshot(check_skill_arg(1), error = TRUE)
  })
})
