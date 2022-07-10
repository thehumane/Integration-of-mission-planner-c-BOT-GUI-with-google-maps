#include "controller.h"
#include <QDebug>
#include <QSettings>


Controller::Controller():QObject()
{

}
Controller::~Controller()
{

}
int Controller::zoomLevel()
{
    return m_zoomLevel;
}
void Controller::setZoomLevel(int level)
{
    m_zoomLevel = level;
    QSettings  settings ("QtApp","GoogleMap");
    settings.setValue("zoomLevel",m_zoomLevel);  
}
void Controller::readSettings()
{
    QSettings  settings ("QtApp","GoogleMap");
    m_zoomLevel = settings.value("zoomLevel",10).toInt();
}
