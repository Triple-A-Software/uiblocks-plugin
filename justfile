# UI Blocks — components-only plugin (no binary to build).
# Each component's shipped style.css is `styles/base.css` + `components/<name>/part.css`,
# so the shadcn token base is authored once and stays DRY.

build:
    #!/usr/bin/env bash
    set -euo pipefail
    for dir in components/*/; do
        if [ -f "$dir/part.css" ]; then
            cat styles/base.css "$dir/part.css" > "$dir/style.css"
        fi
    done
    echo "Built $(ls -d components/*/ | wc -l | tr -d ' ') component stylesheets."

# Package always builds first so no archive ships a stale/missing style.css.
package: build
    plugin-cli package

create-release version: build
    plugin-cli package
