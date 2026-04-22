Script files bashbasics.sh and shellcommands.sh may give error: File not found 

May need to use dos2unix [filename] to convert to Unix before running

To download shell.sh: 

wget https://raw.githubusercontent.com/upsresearch2/linux/refs/heads/main/shell.sh

Then,
 
chmod +x shell.sh #File is executable by all (=u+g+o)=you, your team and anyone else who has access to the machine

or 

chmod u+x shell.sh # Only you can run the script

Happy Scripting!

# Troubleshooting
"Syntax error near unexpected token 'newline' '<!DOCTYPE html>'
The script file is recognized as HTML. Need to download raw file. or use wget with the raw file url (https://raw.git......).

