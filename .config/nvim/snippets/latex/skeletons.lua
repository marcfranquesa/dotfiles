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

                % stop autoindenting
                \usepackage{parskip}

                \usepackage{fancyhdr}
                \pagestyle{fancy}
                \fancyhf{}
                \fancyhead[R]{}
                \fancyhead[L]{}
                \fancyfoot[C]{Page \thepage}

                \author{Marc Franquesa Monés}
                \title{<>}
                \date{<>}

                \begin{document}

                \maketitle

                <>

                \end{document}
            ]],
            {
                i(1, "Title"),
                i(2, "\\today"),
                i(3),
            }
        ),
        {}
    ),
}
