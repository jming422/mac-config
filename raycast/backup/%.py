#!/usr/bin/env python3

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title %
# @raycast.mode compact
# @raycast.packageName Calculator-inator

# Optional parameters:
# @raycast.icon 🧮
# @raycast.argument1 { "type": "text", "placeholder": "Before" }
# @raycast.argument2 { "type": "text", "placeholder": "After" }

# Documentation:
# @raycast.description Calculate % difference between 2 numbers
# @raycast.author Jonathan Ming
# @raycast.authorURL https://github.com/jming422

import sys

before = float(sys.argv[1])
after = float(sys.argv[2])

diff = (before - after) / before

less_or_more = "more" if diff < 0 else "less"

print(f"{after:,.2f} is {abs(diff):,.2%} {less_or_more} than {before:,.2f}")
