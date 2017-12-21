#!/usr/bin/tclsh
# Curly brackets from the same pair should be either in the same line or the opening brace should be on the same line as some declaration and the closing brace should be in the same column as the first non-white-space character.

proc acceptPairs {} {
    global file parens index end

    while {$index != $end} {
        set nextToken [lindex $parens $index]
        set tokenValue [lindex $nextToken 0]

        if {$tokenValue == "\{"} {
            incr index
            set leftParenLine [lindex $nextToken 1]
            set leftParenColumn [lindex $nextToken 2]
            set precedingTokens [getTokens $file $leftParenLine 0 $leftParenLine $leftParenColumn {}]
            set nPrecedingTokens [llength $precedingTokens]
            if {$nPrecedingTokens < 2} {
                report $file $leftParenLine "opening curly bracket should be preceded by a statement followed by a space"
            } else {
                set lastToken [lindex $precedingTokens [expr $nPrecedingTokens - 1]]
                set lastTokenType [lindex $lastToken 3]
                set lastTokenValue [lindex $lastToken 0]
                if {$lastTokenType != "space" || $lastTokenValue != " "} {
                    report $file $leftParenLine "opening curly bracket is not preceded by a single space"
                }

                set firstToken [lindex $precedingTokens 0]
                set firstTokenType [lindex $firstToken 3]
                if {$firstTokenType == "space"} {
                    set firstToken [lindex $precedingTokens 1]
                }
                set leftParenColumn [lindex $firstToken 2]
            }

            acceptPairs

            if {$index == $end} {
                report $file $leftParenLine "opening curly bracket is not closed"
                return
            }

            set nextToken [lindex $parens $index]
            incr index
            set tokenValue [lindex $nextToken 0]
            set rightParenLine [lindex $nextToken 1]
            set rightParenColumn [lindex $nextToken 2]
        } else {
            return
        }
    }
}

foreach file [getSourceFileNames] {
    set parens [getTokens $file 1 0 -1 -1 {leftbrace rightbrace}]
    set index 0
    set end [llength $parens]
    acceptPairs
    if {$index != $end} {
        report $file [lindex [lindex $parens $index] 1] "excessive closing bracket?"
    }
}