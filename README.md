To install the qtmqtt without any issue:
1. git clone https://github.com/qt/qtmqtt.git --branch <qt-version>  
2. cd qtmqtt; qmake; make; sudo make install  
Add the symlink to /usr/include directory:  
sudo ln -s /home/ubuntu/Qt/5.12.11/gcc_64/include/QtCore/5.12.11/QtCore /usr/include/  
  
Features:  
Cross plateform. Specially targeted for mobile/tablet, web and embedded.  
Based on c++, high performance, secure and robust communication.  
