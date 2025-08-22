import 'package:flutter/material.dart';


class CustomColorTheme{

    late Color Background;
    late Color col1;
    late Color col2;
    late Color col3;
    late Color col4;

    CustomColorTheme(this.Background,this.col1,this.col2,this.col3,this.col4){}
}


class ColorController{

    CustomColorTheme dark;
    CustomColorTheme light;
    bool actThemeIsDark;


    ColorController(this.actThemeIsDark,this.dark,this.light);

    Color Background(){
        switch(this.actThemeIsDark){
            case true:{return dark.Background;}
            case false:{return light.Background;}
        }
    }

    Color col1(){
        switch(this.actThemeIsDark){
            case true:{return dark.col1;}
            case false:{return light.col1;}
        }
    }

    Color col2(){
        switch(this.actThemeIsDark){
            case true:{return dark.col2;}
            case false:{return light.col2;}
        }
    }

    Color col3(){
        switch(this.actThemeIsDark){
            case true:{return dark.col3;}
            case false:{return light.col3;}
        }
    }

    Color col4(){
        switch(this.actThemeIsDark){
            case true:{return dark.col4;}
            case false:{return light.col4;}
        }
    }


}