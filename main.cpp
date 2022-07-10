#include <QGuiApplication>
#include <QQmlContext>
#include <QQmlApplicationEngine>
#include <QtWebEngine>
#include "controller.h"
int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);
    QtWebEngine::initialize();

    QQmlApplicationEngine engine;
    QQmlContext *context = engine.rootContext();

    // Controller is our Qt interface to save and retrieve zoom settings of map
    Controller *m_controller = new Controller();
    m_controller->readSettings();
    context->setContextProperty("controller", m_controller);
    context->setContextProperty(QStringLiteral("googleMapsUrl"),QUrl("qrc:/html/googleMaps.html"));
    engine.load(QUrl(QLatin1String("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;
    return app.exec();
}
