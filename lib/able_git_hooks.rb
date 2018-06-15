require "able_git_hooks/version"
require "able_git_hooks/railtie"

module AbleGitHooks
  SCRIPTS = %w(
    applypatch-msg
    pre-applypatch
    post-applypatch
    pre-commit
    prepare-commit-msg
    commit-msg
    post-commit
    pre-rebase
    post-checkout
    post-merge
    pre-push
    pre-receive
    update
    post-receive
    post-update
    push-to-checkout
    pre-auto-gc
    post-rewrite
    rebase
    sendemail-validate
  )
end
