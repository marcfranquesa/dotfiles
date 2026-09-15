# Linked PDF windows in tmux

Open a PDF from a Neovim pane with `<Space>o` or forward search with `Enter`.
`open-compiled` remembers its absolute path in that pane's `@zathura_pdf` option.
When switching tmux windows or panes, the matching open Zathura window is raised.
Keyboard focus stays in Neovim; the PDF page and scroll position stay unchanged.
Closed PDFs and panes without a link are left alone.

This macOS integration uses the default full-path Zathura window title.
Allow the terminal app to control System Events and enable its Accessibility
access in System Settings if macOS requests it. No PDF windows are launched by
the switching hook.

After installing these dotfiles, reload with `tmux source-file ~/.config/tmux/tmux.conf`
and reopen each PDF once from its editor pane to establish the link.
