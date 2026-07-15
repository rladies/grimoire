describe("parse_skill_description()", {
  it("extracts the description field from YAML frontmatter", {
    expect_equal(
      parse_skill_description(fixture_skill_md("A test skill.")),
      "A test skill."
    )
  })

  it("returns NA when there is no frontmatter", {
    expect_true(is.na(parse_skill_description("# No frontmatter here\n")))
  })

  it("returns NA when description is absent", {
    text <- "---\nname: demo-skill\n---\n\nBody\n"
    expect_true(is.na(parse_skill_description(text)))
  })

  it("never evaluates R expressions embedded in untrusted frontmatter", {
    marker <- withr::local_tempfile()
    text <- paste0(
      "---\ndescription: !expr file.create(",
      deparse(marker),
      ")\n---\n\nBody\n"
    )
    result <- parse_skill_description(text)
    expect_match(result, "file.create", fixed = TRUE)
    expect_false(fs::file_exists(marker))
  })
})

describe("available_skills()", {
  it("lists skill names with descriptions", {
    testthat::local_mocked_bindings(
      resolve_ref = function(repo, ref = NULL) "v0.1.0",
      resolve_commit_sha = function(repo, ref) "deadbeef",
      get_repo_tree = function(repo, sha) fixture_tree(),
      download_file_raw = function(repo, sha, path) {
        fixture_skill_md("A test skill.")
      },
      .env = parent.frame()
    )

    expect_snapshot(result <- available_skills())

    expect_equal(result$skill, c("demo-skill", "other-skill"))
    expect_equal(result$description, c("A test skill.", "A test skill."))
  })

  it("skips description lookups when descriptions = FALSE", {
    calls <- 0L
    testthat::local_mocked_bindings(
      resolve_ref = function(repo, ref = NULL) "v0.1.0",
      resolve_commit_sha = function(repo, ref) "deadbeef",
      get_repo_tree = function(repo, sha) fixture_tree(),
      download_file_raw = function(repo, sha, path) {
        calls <<- calls + 1L
        fixture_skill_md()
      },
      .env = parent.frame()
    )

    result <- available_skills(descriptions = FALSE)

    expect_equal(calls, 0L)
    expect_equal(names(result), "skill")
    expect_equal(result$skill, c("demo-skill", "other-skill"))
  })

  it("lists real skills from the live rladies/grimoire repo", {
    skip_if_not(curl::has_internet(), "no internet connection")

    result <- available_skills(descriptions = FALSE)

    expect_true("rladies-blog-post" %in% result$skill)
  })
})
