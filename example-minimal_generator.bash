# this is the generated file for that example-minimal.html
#!/usr/bin/env bash
# Usage: $(basename "$0") [computer.png] [tablet.png] [phone.png]

# coloring
P="\033[1;"
em=${P}36m    # cyan
em1=${P}32m   # green
em2=${P}35m   # magenta
rst=${P}0m    # reset


usage() {
  builtin printf "Usage: $em$0$rst [${em1}computer.png${rst}] [${em1}tablet.png${rst}] [${em1}phone.png${rst}]\n"; >&2
  exit 1
}

test -z $1 && usage
test -z $2 && usage
test -z $3 && usage


template_b64="PGh0bWw+CiAgPGJvZHk+CiAgICA8aDE+Rmlyc3QgZmllbGQ6JDE8L2gxPgoJPGltZyBzcmM9Imh0
dHBzOi8vYXBpLmljb25pZnkuZGVzaWduL21kaTokMS5zdmciIGFsdD0iJDEgSWNvbiIgLz4KICAg
IDxoMj5TZWNvbmQgZmllbGQ6JDI8L2gyPgoJPGltZyBzcmM9Imh0dHBzOi8vYXBpLmljb25pZnku
ZGVzaWduL21kaTokMi5zdmciIGFsdD0iJDIgSWNvbiIgLz4KICAgIDxoMz5UaGlyZCBmaWVsZDok
MzwvaDM+Cgk8aW1nIHNyYz0iaHR0cHM6Ly9hcGkuaWNvbmlmeS5kZXNpZ24vbWRpOiQzLnN2ZyIg
YWx0PSIkMyBJY29uIiAvPgogIDwvYm9keT4KPC9odG1sPgo="

# decode the embedded template, run sed, write output.html
builtin echo $template_b64 | base64 -d -i | sed  -e "s|\$1|$1|g" -e "s|\$2|$2|g" -e "s|\$3|$3|g" > generated_output.html

