# Integration-of-mission-planner-c-BOT-GUI-with-google-maps
This a project I worked for National Institute of Oceanography under my summer internship (May '22 -July'22)

A mission planner helps plan missions for an organization or military entity. Job duties vary, but they may include preparing an autopilot route for aircraft or deciding what vehicle is necessary to complete the mission.

The mission planner’s cBot-GUI is based on QT-5 software.

Google Maps is the standard for consumer maps.  For Qt developers, this presents a dilemma as there is no C++ APIs available for Google Maps.  Enter Qt's WebEngineView which provides a Chromium-based embedded web browser window for QML. WebEngineView allows one to seamlessly integrate a Google Map into a QML application.  With Google Maps comes with Google's services such as directions andsearch and info services


 # Introduction

Consumers of today demand and expect a user interface that is more contemporary, dependable, and responsive, as well as one that is increasingly faster and more intuitive. Expectations are high because people all over the world are accustomed to the high bar that smartphones set. Qt is a multi-platform framework that works with a wide range of hardware and operating systems. To be able to deploy your source code everywhere you need it, all you need to do is write it once. There is no need for teams of programmers to create code, particularly for various operating systems or hardware architectures.

In addition to providing user interaction with map overlay objects and the display itself, Maps and Navigation provide QtQuick user interface types for presenting geographic information on a map. Additionally, it has tools for navigation and geocoding (the process of determining a geographic point from a street address) (including driving and walking directions).

The industry standard for consumer mapping is Google Maps. Since there are no C++ APIs for Google Maps, this presents a problem for Qt developers. Here comes Qt's WebEngineView, which offers a QML-based embedded web browser window powered by Chromium. A Google Map may be smoothly included in a QML application using WebEngineView. Google's services, including those for navigation, search, and information, are included with Google Maps

# Motivation and Solution

There are various native ways to integrate maps into a Qt application, including the Location module and map plugin system. The following map plugins are available and shipped with Qt: Mapbox, Open Street Maps, Here, and ESRI. One may argue that these plugins are better because they are all written in C++, have a shared Qt/QML API, and provide map caching. Additionally, Qt map plugins consume fewer system resources than the WebEngineView method employed here to display a Google map. However, certain applications require Google Maps due to factors like quality, features, or cache value.

Basically, it works best to load an external HTML file containing the javascript code required to load the map into QWebView. By using this technique, you may create JavaScript methods that can manage the map (markers, etc.) inside an HTML file, which you can then quickly call from Qt code.

