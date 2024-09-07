# zsh

## Sourcing order

Definitions:
- Interactive: As the term implies: Interactive means that the commands are run with user-interaction from keyboard. E.g. the shell can prompt the user to enter input.
- Non-interactive: the shell is probably run from an automated process so it can't assume it can request input or that someone will see the output. E.g., maybe it is best to write output to a log file.
- Login: Means that the shell is run as part of the login of the user to the system. Typically used to do any configuration that a user needs/wants to establish his work environment.
- Non-login: Any other shell run by the user after logging on, or which is run by any automated process which is not coupled to a logged in user.

`zsh` files are sourced in the following order:

### interactive login shell 
This is a standard terminal or ssh session.

1. `.zshenv`
2. `.zprofile`
3. `.zshrc`
4. `.zlogin`
5. `.zlogout` (on logout)


### non-interactive login shell
This is any process called by an already-logged-in user that does not and cannot take interactive input from the keyboard, e.g. a script.

1. `.zshenv`
2. `.zprofile`
3. `.zlogin`
4. `.zlogout` (on logout)

Note that `.zshrc` is *not* sourced in this context! **Anything that must be accessible via a login script must not rely on anything setup in `.zshrc`!**


### interactive non-login shell
This like an interactive login shell, except that it's a shell session subsequently called by an already-logged-in user, e.g. after re-sourcing your zsh.

1. `.zshenv`
2. `.zshrc`

Note that `.zprofile`, `.zlogin`, and `.zlogout` are *not* sourced in this context!


### non-interactive non-login shell
This is a subsequent shell context from an already-logged-in shell, e.g. a subshell in a script.

1. `.zshenv`

Note that `.zshrc`, `.zprofile`, `.zlogin`, and `.zlogout` are *not* sourced in this context!


### conclusions
Put most configuration in `.zshenv`. This way, all contexts will use what is defined there in all contexts.

`.zprofile` and `.zlogin` are both specifically for *login* shells -- the only difference is the order in which they're sourced. `.zprofile` is sourced *before* `.zshrc`, and `.zlogin` is sourced *after.* `.zlogin` is therefore pretty rarely utilized.

`.zshrc` is only for *interactive* shells. Place here only what you need for interactivity. If that seems like a small context, it is! `.zshrc` is far too overused -- nearly all use-cases should be placed in `.zshenv`, or perhaps `.zprofile`. `.zshrc` is best utilized for aliases and zsh functions (which I *specifically* use *only* for interactive shell use and/or bound to an alias; all other scripts are `bash`, not `zsh`, and live in their own repo(s)).

`.zlogout` is far and away the least used.


## Misc notes
Window manager should be specified in/launched from `.zprofile` (if tty)
