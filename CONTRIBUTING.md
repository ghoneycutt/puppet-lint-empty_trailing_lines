# Contribution Guidelines

## Release process

1. Update `spec.version` in `puppet-lint-empty_trailing_lines.gemspec`
1. Commit updated version: `git commit -m 'Release x.y.z' puppet-lint-empty_trailing_lines.gemspec`
1. Create new tag: `git tag -a 'x.y.z' -m 'x.y.z'`
1. Push tag: `git push upstream --tags`

The Github Action release process will release the new tag to rubygems.org
