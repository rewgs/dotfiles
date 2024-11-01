# pip
alias pf="pip freeze > requirements.txt"
alias pr="pip install -r requirements.txt"
alias pfrz="pip list --not-required --format=freeze > requirements.txt" # Gets only base packages that are being used

# python web server
alias pyserve="python3 -m http.server 8080"

# pyenv
alias av=activate_venv
alias dv="deactivate"
alias nv=create_new_venv
alias nvhb=create_new_venv_v3.9_with_gui_fix_for_mac

# running python
alias pm="python main.py"
