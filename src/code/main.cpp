#include <QApplication>
#include <QQmlApplicationEngine>
#include <QCommandLineParser>
#include <QDate>
#include <QIcon>
#include <QQmlContext>

#include <MauiKit3/Core/mauiapp.h>

#include <KAboutData>
#include <KI18n/KLocalizedString>

#include "../project_version.h"

#include "appquery.h"

//Useful for setting quickly an app template
#define ORG_NAME "KDE"
#define PROJECT_NAME "Nova Store"
#define COMPONENT_NAME "novastore"
#define PROJECT_DESCRIPTION "Nova Store helps you find and install applications. You can search or browse by category, and look at screenshots"
#define PROJECT_YEAR "2024"
#define PRODUCT_NAME "novastore"
#define PROJECT_PAGE "https://novastore.kde.org"
#define REPORT_PAGE "https://bugs.kde.org/enter_bug.cgi?product=novastore"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QApplication app(argc, argv);

    app.setOrganizationName(QStringLiteral(ORG_NAME));
    app.setWindowIcon(QIcon(":/logo.png"));

    KLocalizedString::setApplicationDomain(COMPONENT_NAME);

    KAboutData about(QStringLiteral(COMPONENT_NAME), i18n(PROJECT_NAME), PROJECT_VERSION_STRING, i18n(PROJECT_DESCRIPTION),
                     KAboutLicense::LGPL_V3, QString("© %1-%2 %3 Development Team").arg(PROJECT_YEAR, QString::number(QDate::currentDate().year()), ORG_NAME), QString(GIT_BRANCH) + "/" + QString(GIT_COMMIT_HASH));

    about.addAuthor(i18n("Miguel Beltrán"), i18n("Developer"), QStringLiteral("novaflowos@gmail.com"));

    about.setHomepage(PROJECT_PAGE);
    about.setProductName(PRODUCT_NAME);
    about.setBugAddress(REPORT_PAGE);
    about.setOrganizationDomain(PROJECT_URI);
    about.setProgramLogo(app.windowIcon());
    //about.addComponent("Akonadi");
    about.addCredit(i18n("MauiKit Developers"));

    KAboutData::setApplicationData(about);
    MauiApp::instance()->setIconName("qrc:/logo.svg");

    QCommandLineParser parser;
    parser.setApplicationDescription(about.shortDescription());
    parser.process(app);
    about.processCommandLine(&parser);

    QQmlApplicationEngine engine;

    AppQuery appquery;
    qmlRegisterSingletonInstance<AppQuery>("org.kde.novastore", 1, 0, "AppQuery", &appquery);



    engine.rootContext()->setContextObject(new KLocalizedContext(&engine));

    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
