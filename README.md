templater.bash
=======

Usage: `./templater.bash template_filename field1 [field2 … fieldN]`

REMEMBER TO HTML ENCODE THE DOLLAR SIGN IN YOUR TEMPLATE $ as \&dollar; if you ever use it by itself and not as a **field**.  

It is not done automatically because it is context-dependent.

## Creates a standalone script which:
  1. contains your template as Base64, so you can run it elsewhere without the template file  
  2. runs as template_filename_generator.bash field1 \[field2 … fieldN]  
  3. when run, decodes the template and sed-replaces ${1}…${N} → its arguments into the html file  
  4. it then saves the html file  

# Use case
You might want to use if you use many templates and there are only small things that change  
such as images or resources and it is not comfortable to change everything by hand [.](Yeah+sup+browski)  
This way you can have multiple generators to create dispensable html files.

---
# Example use

Note: The **templater.bash** is the only file that matters outside the template **you construct with the fields** in html.

1. run: `./templater.bash example-minimal.html computer_image.png tablet_image.png phone_image.png`  
this takes the file `example-minimal.html`, that has fields with $1, $2 and $3 expecting expecting 3 images.

2. With that file the script has created a generator named `example-minimal.bash`

3. to call that generator and complete the fields you can directly run (it is already executable):  
`./example-minimal.bash computer tablet phone`  

that will create the file `example-minimal_generated.html`


