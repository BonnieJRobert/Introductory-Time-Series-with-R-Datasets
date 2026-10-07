---
name: pr-creation
description: Guide for creating pull requests in this repository. Use this whenever asked to open, create, or submit a PR, or to push committed changes for review.
license: MIT
---

# Creating Pull Requests

Follow this process when asked to create a pull request for changes made in this repository.

## 1. Verify the working tree

- Run `git status` and `git --no-pager diff` to confirm all intended changes are present and nothing unrelated is staged.
- Confirm you are not on `main`/`master` directly; create or switch to a feature branch if needed (`git checkout -b <branch-name>`).
- Use a short, descriptive, kebab-case branch name summarizing the change (e.g. `fix-enrollment-csv-path`).

## 2. Commit the changes

- Stage only the relevant files (`git add <paths>`), avoiding unrelated or generated files.
- Write a concise, imperative commit message summarizing the change (e.g. `Fix duplicate rows in supply model join`).
- Append the required trailer unless the user explicitly asked not to:

  ```
  Co-authored-by: Copilot <223556219+Copilot@users.noreply.github.com>
  ```

## 3. Push the branch

- Push with upstream tracking: `git push -u origin <branch-name>`.
- If the branch already exists remotely, a plain `git push` is sufficient.

## 4. Open the PR with `gh`

Prefer the `gh` CLI over MCP tools for GitHub operations.

**Write the PR body to a temporary Markdown file and use `--body-file`; do not pass the body inline as a `--body "..."` string.** On PowerShell, backtick (`` ` ``) is the escape character, so inline code spans (`` `like_this` ``) and other backtick-containing Markdown get silently mangled (stray `\`, inserted tabs/newlines) when embedded in a double-quoted string. Using a file sidesteps this entirely and also avoids quoting issues with newlines and special characters.

```powershell
# Create the body file with the `create`/`edit` file tools (not here-strings or echo),
# then create the PR:
gh pr create --title "<concise title>" --body-file <path-to-temp-body>.md --base main
```

If you ever do need to pass a body inline, escape literal backticks as `` `` `` (double backtick) in the PowerShell string, or avoid Markdown code spans in that string altogether — but prefer `--body-file` instead.

After creating or editing, verify the rendered body matches intent: `gh pr view <number> --json body -q .body`.

Note: `gh pr edit --body-file` can fail with an unrelated `GraphQL: Projects (classic) is being deprecated...` error on some repos. If that happens, update the body directly via the REST API instead:

```powershell
gh api repos/<owner>/<repo>/pulls/<number> -X PATCH -F body=@<path-to-temp-body>.md
```

Delete the temporary body file once the PR is created/updated and verified.

Guidelines for the body:
- Open with a friendly, human-touch line before the **Summary** header: `Please review the (<count>) files changed in this PR.` — get `<count>` from `gh pr view <number> --json files -q '.files | length'` (or `gh api repos/<owner>/<repo>/pulls/<number>/files --paginate -q '.[].filename' | Measure-Object -Line` for PRs with truncated diffs) so the number is accurate, not guessed.
- Briefly describe **what** changed.  Do not include **why**.
- Use the following structure, formatted with headers: **Summary**, **Key Changes**, **Validation**.
- Link related issues using `Fixes #<number>` or `Closes #<number>` when applicable, using fully-qualified `owner/repo#<number>` for issues outside this repository.
- **Summary**: Keep it concise — start with a short summary of one or two sentances
- **Key Changes**: Summary is followed by a bullet list of key changes.
- **Validation**: Describe how validation was tested, if at all.  Note the validation/tests run (or explicitly state none were needed, e.g. documentation-only change).

## 5. Confirm and report

- After creation, run `gh pr view --web` or share the PR URL returned by `gh pr create`.
- Report the PR URL and a brief (1-3 sentence) summary back to the user.

## 6. Stacked PR's
 
- If the PR is part of a stacked PR, include a link to the previous PR's in the body for context. (e.g. this PR builds on top of #123)

## Notes

- If no changes are committed yet, commit them first (step 2) — do not attempt to create a PR with an empty diff.
- If the repository requires a specific base branch other than `main`, confirm with the user before proceeding.
- Do not force-push unless explicitly requested.
