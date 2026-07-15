describe("split_repo()", {
  it("splits an owner/repo slug", {
    expect_equal(
      split_repo("rladies/grimoire"),
      list(owner = "rladies", repo = "grimoire")
    )
  })

  it("errors on a malformed slug", {
    expect_snapshot(split_repo("grimoire"), error = TRUE)
    expect_snapshot(split_repo("a/b/c"), error = TRUE)
  })
})

describe("resolve_ref()", {
  it("returns the given ref unchanged", {
    expect_equal(resolve_ref("rladies/grimoire", "v0.2.0"), "v0.2.0")
  })

  it("returns the latest release tag when ref is NULL", {
    testthat::local_mocked_bindings(
      gh = function(endpoint, ...) list(tag_name = "v0.1.0"),
      .package = "gh"
    )
    expect_equal(resolve_ref("rladies/grimoire", NULL), "v0.1.0")
  })

  it("falls back to the default branch when there are no releases", {
    testthat::local_mocked_bindings(
      gh = function(endpoint, ...) {
        if (grepl("releases/latest", endpoint)) {
          stop("404 Not Found")
        }
        list(default_branch = "main")
      },
      .package = "gh"
    )
    expect_snapshot(resolve_ref("rladies/grimoire", NULL))
  })
})

describe("resolve_commit_sha()", {
  it("returns the commit sha for a ref", {
    testthat::local_mocked_bindings(
      gh = function(endpoint, ...) list(sha = "deadbeef"),
      .package = "gh"
    )
    expect_equal(resolve_commit_sha("rladies/grimoire", "main"), "deadbeef")
  })

  it("short-circuits without an API call when ref is already a full sha", {
    testthat::local_mocked_bindings(
      gh = function(endpoint, ...) cli::cli_abort("should not be called"),
      .package = "gh"
    )
    sha <- "0123456789abcdef0123456789abcdef01234567"
    expect_equal(resolve_commit_sha("rladies/grimoire", sha), sha)
  })
})

describe("get_repo_tree()", {
  it("returns the tree entries", {
    testthat::local_mocked_bindings(
      gh = function(endpoint, ...) list(tree = fixture_tree()),
      .package = "gh"
    )
    tree <- get_repo_tree("rladies/grimoire", "deadbeef")
    expect_equal(length(tree), length(fixture_tree()))
  })
})

describe("is_safe_skill_name()", {
  it("accepts ordinary kebab-case names", {
    expect_true(is_safe_skill_name("rladies-blog-post"))
  })

  it("rejects traversal and slash-containing names", {
    expect_false(is_safe_skill_name(".."))
    expect_false(is_safe_skill_name("."))
    expect_false(is_safe_skill_name("foo/bar"))
    expect_false(is_safe_skill_name("foo\\bar"))
  })

  it("rejects names outside the identifier allowlist", {
    expect_false(is_safe_skill_name("foo bar"))
    expect_false(is_safe_skill_name("C:"))
    expect_false(is_safe_skill_name(""))
  })
})

describe("is_safe_relpath()", {
  it("accepts ordinary nested relative paths", {
    expect_true(is_safe_relpath("SKILL.md"))
    expect_true(is_safe_relpath("references/foo.md"))
  })

  it("rejects traversal and absolute paths", {
    expect_false(is_safe_relpath("../../etc/passwd"))
    expect_false(is_safe_relpath("references/../../../etc/passwd"))
    expect_false(is_safe_relpath("/etc/passwd"))
    expect_false(is_safe_relpath(""))
  })

  it("rejects Windows drive-absolute paths", {
    expect_false(is_safe_relpath("C:\\Windows\\System32"))
    expect_false(is_safe_relpath("C:/Windows/System32"))
  })
})

describe("list_remote_skills_from_tree()", {
  it("extracts skill names from SKILL.md blobs only", {
    expect_equal(
      list_remote_skills_from_tree(fixture_tree()),
      c("demo-skill", "other-skill")
    )
  })

  it("silently drops unsafe skill names instead of surfacing them", {
    malicious <- c(
      fixture_tree(),
      list(list(path = "skills/../SKILL.md", type = "blob", sha = "evil"))
    )
    expect_equal(
      list_remote_skills_from_tree(malicious),
      c("demo-skill", "other-skill")
    )
  })
})

describe("list_skill_files()", {
  it("returns full and relative paths for a skill", {
    files <- list_skill_files(fixture_tree(), "demo-skill")
    expect_equal(sort(files$relpath), c("SKILL.md", "references/foo.md"))
    expect_true(all(startsWith(files$path, "skills/demo-skill/")))
  })

  it("errors when the skill has no files", {
    expect_snapshot(list_skill_files(fixture_tree(), "nope"), error = TRUE)
  })

  it("refuses to build relpaths that escape the target directory", {
    malicious <- list(
      list(path = "skills/demo-skill/SKILL.md", type = "blob", sha = "sha1"),
      list(
        path = "skills/demo-skill/../../../etc/passwd",
        type = "blob",
        sha = "evil"
      )
    )
    expect_snapshot(list_skill_files(malicious, "demo-skill"), error = TRUE)
  })
})

describe("download_file_raw()", {
  it("returns the response body as text", {
    testthat::local_mocked_bindings(
      curl_fetch_memory = function(url, ...) {
        list(status_code = 200L, content = charToRaw("hello\n"))
      },
      .package = "curl"
    )
    expect_equal(
      download_file_raw(
        "rladies/grimoire",
        "deadbeef",
        "skills/demo-skill/SKILL.md"
      ),
      "hello\n"
    )
  })

  it("errors on an HTTP failure", {
    testthat::local_mocked_bindings(
      curl_fetch_memory = function(url, ...) {
        list(status_code = 404L, content = raw())
      },
      .package = "curl"
    )
    expect_snapshot(
      download_file_raw("rladies/grimoire", "deadbeef", "skills/nope/SKILL.md"),
      error = TRUE
    )
  })
})

describe("download_file_to()", {
  it("creates the destination directory and downloads the file", {
    dest_dir <- withr::local_tempdir()
    dest <- fs::path(dest_dir, "nested", "SKILL.md")
    called_with <- NULL
    testthat::local_mocked_bindings(
      curl_download = function(url, destfile, ...) {
        called_with <<- url
        writeLines("content", destfile)
        invisible(destfile)
      },
      .package = "curl"
    )
    download_file_to(
      "rladies/grimoire",
      "deadbeef",
      "skills/demo-skill/SKILL.md",
      dest
    )
    expect_true(fs::file_exists(dest))
    expect_equal(
      called_with,
      raw_url("rladies/grimoire", "deadbeef", "skills/demo-skill/SKILL.md")
    )
  })
})
