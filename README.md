# puppet-lint-empty_trailing_lines

This plugin will check to see if a manifest has trailing empty lines.


## Installation


### From the command line

```sh
gem install puppet-lint-empty_trailing_lines
```

### In a `Gemfile`

```ruby
gem 'puppet-lint-empty_trailing_lines', :require => false
```

## Checks

This plugin provides a new check to `puppet-lint`.

### What you have done

```puppet
  # There are two empty lines after the code has ended
    file { '/foo':
      ensure => 'file',
    }
  }


```

### What you should have done

```puppet
  # Not left empty lines at the end of the file
    file { '/foo':
      ensure => 'file',
    }
  }
```

### Disabling the check

#### From the command line

#### In your `Rakefile`
