import os
import toml
file = os.path.abspath('$HOME/dotfiles/helix/config.toml')
data = toml.loads(file)

if os.path.isfile(file):
    
	print(data)
    # Modify field
    # data['component']['model']='NEWMODELNAME' 

    # To use the dump function, you need to open the file in 'write' mode
    # It did not work if I just specify file location like in load
    # f = open("scenario.toml",'w')
    # toml.dump(data, f)
    # f.close()

else:
    os.EX_OSFILE  	# built-in method of os for throwing a native OS error
                  	# 	regarding files.
					#	From docs.python.org: "Exit code that means some 
					#		system file did not exist, could not be opened, 
					#		or had some other kind of error."
					#		https://docs.python.org/3/library/os.html