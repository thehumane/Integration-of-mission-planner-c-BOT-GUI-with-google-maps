#ifndef CONTROLLER_H
#define CONTROLLER_H

#include <QObject>

class Controller : public QObject
{
    Q_OBJECT
    Q_DISABLE_COPY(Controller)
    Q_PROPERTY(int zoomLevel READ zoomLevel WRITE setZoomLevel NOTIFY zoomLevelChanged)
public:
    Controller();
    ~Controller();
     int   zoomLevel();
    Q_INVOKABLE void setZoomLevel(int level);
    void readSettings();
signals:
    void zoomLevelChanged(int zoomValue);
private:
    qint32 m_zoomLevel;
};

#endif // CONTROLLER_H
