[windows]
set shell := ["powershell.exe", "-c"]

[linux]
set shell := ["bash", "-c"]

alias bc := before_commit
alias rd := run_desktop
alias t := test
alias tc := test_coverage

before_commit: check check_format test

check:
    dart analyze --fatal-infos
    @echo "Dart analysis passed"

check_format:
    dart format lib --output none --set-exit-if-changed
    dart format test --output none --set-exit-if-changed
    @echo "Code formatted correctly"

run_desktop:
    cd example && flutter run -d {{ os() }}

test:
    flutter test

test_coverage:
    flutter test --coverage
    lcov -r coverage/lcov.info "lib/src/premade/**.dart" -o coverage/lcov.info --ignore-errors empty
    genhtml coverage/lcov.info -o coverage/html
    @echo "Coverage generation complete"
