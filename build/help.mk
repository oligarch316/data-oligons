# ----- Formats

# printf ... <label> <message>
formatInfo = %-6s %s

# printf ... <label>
formatHelpLabel = %s

# printf ... <name> <description>
formatHelpTarget = %-12s %s


# ----- Labels

# inform
font.%: inform = $(info $(shell printf "$(formatInfo)" "font»" "$(1)"))
nix.%:  inform = $(info $(shell printf "$(formatInfo)" "nix»"  "$(1)"))

# help
_help/Makefile:      helpLabel = General
_help/build/font.mk: helpLabel = Font
_help/build/nix.mk:  helpLabel = Nix
_help/build/help.mk: helpLabel = Help


# ----- Print
.PHONY: print

print.%: ; @echo "$($*)" ## Print the Makefile variable named <%>


# ----- Help
.PHONY: help

# Display according to `formatHelpTarget`
helpAction = { printf "  $(formatHelpTarget)\n", $$1, $$NF }

# Match "target" lines containing a trailing "## Help text..." comment
#
# (1) Beginning of line
# (2) Ignore lines where 1st character is <tab> or <hash>
# (3) Target name matching one-or-more of any character(s) (?=lazy)
# (4) <colon> separator
# (5) Dependency list matching zero-or-more of any character(s) (?=lazy)
# (6) <hash><hash> separator
# (7) Help text matching one-or-more of any character(s)
# (8) End of line
#
#   (1)  (2)      (3)     (4)          (5)          (6)        (7)      (8)
# /  ^ [^\t#]     .+?      :           .*?           ##        .+        $  /
#    │    │  ┌─────┴──────┐│ ┌──────────┴──────────┐┌┴─┐┌───────┴───────┐│
#            example.target: example.dependencies... ## Example help text
#
helpPattern = /^[^\t\#].+?:.*?\#\#.+$$/

# Separate by <colon> OR <hash><hash>
#
#      $1                   $2                       $3 ($NF)
# ┌─────┴──────┐  ┌──────────┴───────────┐    ┌───────┴───────┐
# example.target: example.dependencies ... ## Example help text
#
helpSeparator = :|\#\#

help:   $(MAKEFILE_LIST:%=_help/%) ## Print help information
help.%: _help/build/%.mk ;         ## Print help information for section <%>

help.general: _help/Makefile ;

_help/%: helpLabel = $*
_help/%:
	printf "$(formatHelpLabel)\n" "$(helpLabel)"
	$(cmdAwk) -F '$(helpSeparator)' '$(helpPattern) $(helpAction)' $*
