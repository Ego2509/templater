#!/usr/bin/env bash
#
# REMEMBER TO HTML ENCODE THE DOLLAR SIGN IN YOUR TEMPLATE: $ as &dollar;
# if you ever use it. It is not done automatically because it is 
# context-dependent.
# 
# Usage: templater.bash template_filename field1 [field2 … fieldN]
#
# Creates a standalone script which:
#   • contains your template as Base64, so you can run it elsewhere without the template file
#   • runs as template_filename_generator.bash field1 [field2 … fieldN]
#   • when run, decodes the template and sed-replaces ${1}…${N} → its arguments into the html file
#   • it then saves the html file
#
# You might want to use if you use many templates and there are only small things that change
# such as images or resources.                                                                                                                                                                                                                                                                                                                                                                        sup browski
# This way you can have multiple generators to create dispensable html files.
#
# example use case: ./templater.bash example-minimal.html computer_image.png tablet_image.png phone_image.png
# this took the file example-minimal.html, that has fields with $1, $2 and $3,
# so the file expects 3 images.
#
# With that file it made a generator named example-minimal.bash
#
# to call that generator: (it is already executable)
# ./example-minimal.bash computer tablet phone
#
# that will create the file example-minimal_generated.html
#
# author: @Ego2509

if (( $# < 2 )); then
  printf "Usage: $0 template_filename field1 [field2 … fieldN]\n\
REMEMBER TO HTML ENCODE THE DOLLAR SIGN IN YOUR TEMPLATE\
IF IT IS NOT A FIELD YOU WANT TO REPLACE!: \$ as &dollar;\
the output will be ${1%.html}_generator.bash and with that file\
you can generate the ${1%.html}_generated.html file" >&2
  exit 1
fi

# coloring
P="\033[1;"
em=${P}36m    # cyan
em1=${P}32m   # green
rst=${P}0m    # reset

msg() { 
    type=$1;shift;
    builtin printf "[${em}$type$rst] ${@}\n";
}

tpl="$1"; shift
fields=( "$@" )

msg $em1"info" "filename ${tpl%.html}"

msg debug "base64 encoding $tpl"

# base64-encode the template
b64=$(base64 < "$tpl")

# "[field1] [field2]…" for help in script with and without color
usage_fields=$(printf ' [%s]' "${fields[@]}")
usage_fields=${usage_fields:1}

msg debug "\$usage_fields: $usage_fields"

usage_fields_colored=$(printf ' [${em1}%s${rst}]' "${fields[@]}")
usage_fields_colored=${usage_fields_colored:1}

msg debug "\$usage_fields_colored: $usage_fields_colored"

# arguments tests
checks=""
for ((i=1; i<=${#fields[@]}; i++)); do
  checks+="test -z \$$i && usage"$'\n'
done

msg debug "\$checks: $checks"

# build the sed-commands
sed_cmds=""
for ((i=1; i<=${#fields[@]}; i++)); do
  sed_cmds+=" -e \"s|\\\$$i|\$$i|g\""
done

msg debug "\$sed_cmds:$sed_cmds"

msg $em1"output"

# emit the generated script
cat <<EOF | tee ${tpl%.html}_generator.bash
#!/usr/bin/env bash
# Usage: \$(basename "\$0") $usage_fields

# coloring
P="\\033[1;"
em=\${P}36m    # cyan
em1=\${P}32m   # green
em2=\${P}35m   # magenta
rst=\${P}0m    # reset


usage() {
  builtin printf "Usage: \$em\$0\$rst $usage_fields_colored\n"; >&2
  exit 1
}

$checks

template_b64="$b64"

# decode the embedded template, run sed, write output.html
builtin echo \$template_b64 | base64 -d -i | sed $sed_cmds > generated_output.html

EOF

chmod +x ./${tpl%.html}_generator.bash

msg $em1"info" "successfully generated ${tpl%.html}_generator.bash"
msg $em1"info" "You can now replace the fields in your template."
msg $em1"info" "use ./${tpl%.html}_generator.bash to see further details"
