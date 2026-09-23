[windows]
set shell := ["powershell.exe", "-c"]

[linux]
set shell := ["bash", "-c"]

alias bc := before_commit
alias rd := run_desktop

before_commit: check check_format

check:
    dart analyze --fatal-infos
    @echo "Dart analysis passed"

check_format:
    dart format lib --output none --set-exit-if-changed
    dart format test --output none --set-exit-if-changed
    @echo "Code formatted correctly"

run_desktop:
    cd example && flutter run -d {{ os() }}
