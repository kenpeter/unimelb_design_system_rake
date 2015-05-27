# Usage
# ./my_unimelb_design_system_rake.sh unimelb-design-system
# unimelb-design-system is checked out from https://github.com/marcom-unimelb/unimelb-design-system

UOM_DESIGN_SYSTEM_DIR="unimelb-design-system"
MY_SCRIPT_DIR="my_rake"
MY_DIFF_FILE="unimelb_design_system_1.0_rakefile.diff"

# cd
cd ../$UOM_DESIGN_SYSTEM_DIR 

# Clean up
rm ./build -rf

# http://stackoverflow.com/questions/6588674/what-does-bundle-exec-rake-mean

# Build 1.0
# You can find it out here: https://github.com/marcom-unimelb/unimelb-design-system/tags
# The 1.0 build uses ruby 2.2.1
git checkout 2db206f5f94cdc4d02c822f7a62fcd60a50a46f9

# Copy
cp ../$MY_SCRIPT_DIR/$MY_DIFF_FILE .
patch -p1 < $MY_DIFF_FILE 

rvm 2.2.1 exec bundle exec rake assets:compile VERSION=1.0

# Self clean up
git checkout Rakefile
rm $MY_DIFF_FILE 


# Build master
# Branch my-master is from https://github.com/kenpeter/unimelb-design-system/tree/my-master
git checkout my-master

# I want to see the full source, so comment out the code
sed -i '/e.js_compressor/s/^/#/' ./Rakefile
sed -i '/e.css_compressor/s/^/#/' ./Rakefile

rvm 2.2.2 exec bundle exec rake assets:compile VERSION=master

# Self clean up
git checkout Rakefile
