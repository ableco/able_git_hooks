# Able Git Hooks

AbleGitHooks installs git hooks so that the scripts can be managed outside of the `.git/hooks` folder.

All scripts in the `hooks/<hook_name>` folders will be run and expected to return 0.

For example this gem installs a rubocop hook in `hooks/pre-commit/rubocop` that prevents commits
that do not pass rubocop check.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'able_git_hooks'
```

And then execute:

    $ bundle

## Usage

Execute the generator command to copy the files:

    $ bundle exec rails generate able_git_hooks:install


For the ESLint default configuration you'll need to install

- eslint-plugin-import
- eslint-plugin-react
- eslint-plugin-prettier
