[<< back](gemfile.md) | [Indice](../README.md) | [next >>](nose)

# Rakefile

Podemos ver que aunque el `Rakefile` apenas tiene nada de código, gracias a las dependencias:

```
require "bundler/setup"
require "bundler/gem_tasks"
require "bump/tasks"
```

se crea una gran cantidad de funcionalidad

```
rake build                    # Build snake_game-0.0.1.gem into the pkg directory
rake build:checksum           # Generate SHA512 checksum if snake_game-0.0.1.gem into the checksums directory
rake bump:current[no_args]    # Show current gem version
rake bump:file[no_args]       # Show version file path
rake bump:major[no_args]      # Bump major part of gem version
rake bump:minor[no_args]      # Bump minor part of gem version
rake bump:patch[no_args]      # Bump patch part of gem version
rake bump:pre[no_args]        # Bump pre part of gem version
rake bump:set                 # Sets the version number using the VERSION environment variable
rake bump:show-next[no_args]  # Show next major|minor|patch|pre version
rake clean                    # Remove any temporary products
rake clobber                  # Remove any generated files
rake install                  # Build and install snake_game-0.0.1.gem into system gems
rake install:local            # Build and install snake_game-0.0.1.gem into system gems without network access
rake release[remote]          # Create tag v0.0.1 and build and push snake_game-0.0.1.gem to rubygems.org
```

Vamos a probarlas...
