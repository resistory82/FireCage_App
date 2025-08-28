import 'package:flutter/material.dart';




class SizeController{

    late BuildContext _context;
    bool _contextisset = false;
    late double actDeviceWidth;
    late double actDeviceHeight;

    double menubarTopHeight=0;
    double menubarBottomHeight=0;

    double appbarHeight=0;


    SizeController(BuildContext context) {
        if(!_contextisset){
            _context = context;
            _contextisset = true;
            init();
        }
    }

    void reloadContext(BuildContext context){
        _context = context;
        _contextisset = true;
        init();
    }
    
    void init(){
        actDeviceWidth = getWidth();
        actDeviceHeight = getHeight();
        menubarBottomHeight = MediaQuery.of(_context).padding.bottom;
        menubarTopHeight = MediaQuery.of(_context).padding.top;
        //print("Device Settings -> Height: $actDeviceHeight; Width: $actDeviceWidth; TopBar: $menubarTopHeight; BottomBar: $menubarBottomHeight");
    }
    
    double getWidth() { return MediaQuery.of(_context).size.width;}
    double getHeight() { return MediaQuery.of(_context).size.height;}

    void setAppbarParameters(double appbarheight){
        appbarHeight=appbarheight;
    }

    double setWidthPerc(double percentage) {
        return actDeviceWidth * (percentage / 100);
    }

    double setHeightPerc(double percentage) {
        return (actDeviceHeight - (menubarBottomHeight + appbarHeight) ) * (percentage / 100);
    }

    double wd(double widthpercentage){
        return actDeviceWidth * (widthpercentage / 100);
    }

    double wh(double heigthpercentage) {
        return (actDeviceHeight * (heigthpercentage / 100));
    }



    /*double clamp(double minFonstsize, double respFonsizePerc, double maxFonsize){

        double resp = setWidthPerc(respFonsizePerc);

        if((resp<maxFonsize) && (resp>minFonstsize))    {return resp;}
        else if(resp>maxFonsize)                        {return maxFonsize;}
        else                                            {return minFonstsize;}
    }*/




   // Get the current operating system
    TargetPlatform getOperatingSystem(){
        return Theme.of(_context).platform;
    }

    // Check if the current platform is mobile
    bool isMobile() {
        return getOperatingSystem() == TargetPlatform.iOS || getOperatingSystem() == TargetPlatform.android;
    }

    // Check if the current platform is a tablet
    bool isTablet() {
        double width = getWidth();
        double height = getHeight();
        return (width > 600 && height > 600) || (width > 800 && height > 800);
    }

    // Check if the current platform is desktop
    bool isDesktop() {
        return getOperatingSystem() == TargetPlatform.windows || 
               getOperatingSystem() == TargetPlatform.macOS || 
               getOperatingSystem() == TargetPlatform.linux;
    }

    // Check if the current platform is web
    bool isWeb() {
        return getOperatingSystem() == TargetPlatform.fuchsia; // Assuming Fuchsia for web, adjust as needed
    }

    


    // Get orientation and Ration of the screen
    Orientation getOrientation() {
        return MediaQuery.of(_context).orientation;
    }

    bool isLandscape() {
        return getWidth() > getHeight();
    }

    bool isPortrait() {
        return getHeight() > getWidth();
    }

    double getAspectRatio() {
        return getWidth() / getHeight();
    }

    // Get the current device pixel ratio
    double getDevicePixelRatio() {
        return MediaQuery.of(_context).devicePixelRatio;
    }
    

    double setHeightForWidgetPercent(double percent) {
        // Ensure the percentage is between 0 and 100
        /*if (percent < 0 || percent > 100) {
            throw ArgumentError('Percentage must be between 0 and 100');
        }*/

        double aspectRatio = getWidth() / getHeight();

        // Calculate the height based on the percentage and aspect ratio
        double calculatedHeight = (getHeight() * (percent / 100)) / aspectRatio;

        // Ensure the calculated height does not exceed the screen height
        return calculatedHeight > getHeight() ? getHeight() : calculatedHeight;
    }

    double setWidthForWidgetPercent(double percent) {
        // Ensure the percentage is between 0 and 100
        /*if (percent < 0 || percent > 100) {
            throw ArgumentError('Percentage must be between 0 and 100');
        }*/

       double aspectRatio = getWidth() / getHeight();

        // Calculate the height based on the percentage and aspect ratio
        double calculatedWidth = (getWidth() * (percent / 100)) / aspectRatio;

        // Ensure the calculated height does not exceed the screen height
        return calculatedWidth > getWidth() ? getWidth() : calculatedWidth;
    }

    
}