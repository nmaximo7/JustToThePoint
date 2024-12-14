from autokey import engine

# Define your abbreviation-to-expansion dictionary
abbrev_dict = {
    "ac": "ascending colon",
    "bl": "benign-looking",
    # Add as many abbreviations as you need...
    "_vc": "Multifocal atherosclerotic vascular calcification in aorta and its branches."
}

# Register each abbreviation with Autokey's engine
for source, target in abbrev_dict.items():
    # `prompt=False` means it will replace immediately without prompting
    engine.register_abbreviation(source, target, prompt=False)

# No need for a wait loop; Autokey handles expansions automatically in the background.

