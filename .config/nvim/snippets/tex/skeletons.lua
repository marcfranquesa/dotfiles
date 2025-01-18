local helpers = require("snippets-helper")
local line_begin = require("luasnip.extras.expand_conditions").line_begin

return {
    -- basic document
    s(
        { trig = "!doc", snippetType = "autosnippet" },
        fmta(
            [[
                \documentclass[12pt]{article}

                \usepackage{geometry}
                \geometry{
                    a4paper,
                    total={165mm,235mm},
                    left=25mm,
                    top=30mm,
                }

                \usepackage{graphicx} % images
                \usepackage{svg} % svgs

                \usepackage{parskip} % stop autoindenting

                % language
                %   english
                %   spanish
                %   catalan
                \usepackage{csquotes}
                \usepackage[<>]{babel}

                \usepackage{fancyhdr}
                \pagestyle{fancy}
                \fancyhf{}
                \fancyhead[R]{}
                \fancyhead[L]{}
                \fancyfoot[C]{\thepage}

                \author{Marc Franquesa Monés}
                \title{<>}
                \date{<>}

                \begin{document}

                \maketitle

                <>

                \end{document}
            ]],
            {
                i(1, "english"),
                i(2, "Title"),
                i(3, "\\today"),
                i(4),
            }
        ),
        {}
    ),
}
