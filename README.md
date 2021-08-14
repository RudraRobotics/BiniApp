To install the qtmqtt without any issue:
1. git clone https://github.com/qt/qtmqtt.git --branch <qt-version>  
2. cd qtmqtt; qmake; make; sudo make install  
Add the symlink to /usr/include directory:  
sudo ln -s /home/ubuntu/Qt/5.12.11/gcc_64/include/QtCore/5.12.11/QtCore /usr/include/ 

Mission planner features:  
1. Multiple destination selection.  
2. Mission execute, cancel and update feature.  
3. Real time display of all deployed robots in given map.   

  #### TODO:  
  1. Adding edit and delete feature in mapping setup page.  
  2. Mission planer page specific for catering mode, where the grid navigation page will not be presetn for selecting location names.  
