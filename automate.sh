# Get the repo link from the environment
# by  checking the key GITHUB_REPO

#==========================================
# NOTE
#==========================================
# This makes an assumption that your app 
# is a node application which build to give output
# into the dist folder.
# It is also assumed that you are using yarn as the package
# manager
#==========================================
REPO=$GITHUB_REPO
DESTINATION='project'
function update_machine(){
	sudo apt update
	# Make sure packages that are not used are
	# removed to save up disk space
	sudo apt autoremove -y

	sudo apt install -y nginx nodejs npm
}
function remove_folder_if_exists(){
	#Remove the destination folder if it exists
	rm -rf $DESTINATION
}
# This function @clone is to clone the repo from github
# assuming that we have the repo is hosted on github
function clone(){
	# Check if the REPO starts with a github domain
	# if so, go ahead and clone the repo, otherwise 
	# stop the execution and echo an error message
	if [[ $REPO != https://github.com/* ]]; then
		echo "There was no environment GITHUB_REPO set"
		echo " the repo must be in the form https://github.com/<username>/<repo>"
		echo "Please export the GITHUB_REPO to the environment"
	else
		git clone $REPO $DESTINATION
		# If the clone command exited with a non-zero code,
		# just print an error to the screen and stop there
		# since no more work can go on.
		if [[ $? -ne 0 ]]; then
			echo "
			There was a problem cloning the repo 
			Just to make sure everything is on our 
			side make sure you specify a repo that exists or 
			make sure your internet is reliable
			"
			exit 1
		fi


	fi
}

# This function install the dependencies for node to be able to
# run the application
function install_requirements_and_build(){
	# Install yarn package manager on a global scope
	sudo npm install -g yarn
	cd $DESTINATION
	# Install dependencies
	yarn install
	# build the application
	yarn build
	# Move outputs to the nginx document root
	sudo mv dist/bundle.js /var/www/html
	sudo mv dist/index.html /var/www/html

}
# This function contains functionality to make sure 
# the working directory for building the application
# is deleted after the build
function clean_work_path(){
	sudo rm -rf $DESTINATION
}

# The main method to run all the steps to build the
# application
main(){
	update_machine
	remove_folder_if_exists
	clone
	install_requirements_and_build
	clean_work_path
}