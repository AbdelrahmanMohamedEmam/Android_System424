

*Installation: 
	-install flutter Sdk 
	-install text editor (android studio or VS code)
	-intsall android emulator or work with your android after enabling developer mode

*Package Installation:\
	-at pubspec.yaml file add your plugins into dependencies or dev_dependecies an run the command "pub get"
		or use built in button in android studio "get packages"	

*Accessing Database or mocking server using variable "baseUrl" in main.dart file 
	you can also change between real database and mocking through "config.txt" file
	
*Run unit test:
	-switch to main test file from android studio tool bar
	-use inline test run/debug feature to initialize the test
	
*generation of code coverage report:
	-run the command "flutter test -- coverage" in android studio terminal.
	-you will get file.info which is converted to HTML through lenuix
	-download text editor named "atom" open file.info from it 
	-then click "ctrl -> alt -> C"

*Run for developers:
	-after installing required tools 
	-open project then run it on emulator using the green arrow
	
*Build and run production apk file:
	-through CMD:
		cd 'the directory of the project'
		flutter run build apk -- release
		
*generating documentation report:
	-through CMD:
		cd 'the directory of the project'
		"DartDoc"
		
		
		