return {
    parse({ trig = "beg", wordTrig = true }, "\\begin{$1}\n\t${2:$SELECT_DEDENT}\n\\end{$1}"),
    parse("mm", [[\\($1\\)]]),
    parse("it", [[\textit{$1}]]),
}
