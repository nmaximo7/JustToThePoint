#!/bin/bash
# Check for broken links and images using Linkinator
echo "Checking for broken links and images..."
LINKINATOR_OPTIONS=(
        --include-images
        --skip "mailto:*"
        --verbosity error
        --recurse
        --timeout=10000
        --retry=3
        --exclude "https://www.facebook.com/*"
    )
    
check_links() {
        npx linkinator http://localhost:1313 "${LINKINATOR_OPTIONS[@]}"

}

check_links

echo "Checking the site online..."
npx linkinator https://justtothepoint.com "${LINKINATOR_OPTIONS[@]}" # Check the entire website.
echo "End."
