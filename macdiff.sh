#!/bin/sh
# Print differing lines of files in mac1/ and mac2/. Files present in one dir only print as "Only in ...".
diff -r -x Brewfile "${1:-mac1}" "${2:-mac2}"
