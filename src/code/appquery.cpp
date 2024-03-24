// <one line to give the program's name and a brief idea of what it does.>
// SPDX-FileCopyrightText: 2024 Miguel <email>
// SPDX-License-Identifier: GPL-3.0-or-later

#include "appquery.h"
#include <QRandomGenerator>
#include <QIcon>
#include <QStringList>

using namespace PackageKit;
using namespace AppStream;
using namespace KAuth;

AppQuery::AppQuery()
{
    // Cargar aplicaciones de escritorio

    AppStream::Pool m_pool;
    m_pool.load();

    auto apps = m_pool.componentsByKind(AppStream::Component::KindDesktopApp);
    int count = apps.toList().count();

    qDebug() << "Aplicaciones totales de escritorio:" << count;

    // Generar indices aleatorios para cada aplicación:

    int randomIndex[6];

    for (int i=0; i<6; i++) {
        while (randomIndex[i] == QRandomGenerator::global()->bounded(count)) {
        }
        randomIndex[i] = QRandomGenerator::global()->bounded(count);
    }

    // Obtener listado de aplicaciones aleatorias:

    int i=0;
    for (const AppStream::Component &app : apps) {

        for (int j=0; j<6; j++) {
            if (i==randomIndex[j]) {

                QVariantMap appData;

                appData["pkgId"] = app.id();
                appData["pkgName"] = app.name();
                appData["pkgPackageName"] = app.packageNames();
                appData["pkgSummary"] = app.summary();
                appData["pkgDescription"] = app.description();
                appData["pkgCategories"] = app.categories();

                //Icon packageIcon = app.icon(QSize(64, 64));
                //appData["pkgIcon"] = QIcon::fromTheme(packageIcon.name()).name();

                Icon packageIcon = app.icon(QSize(64, 64));
                appData["pkgIcon"] = packageIcon.url().toLocalFile();

                QList<AppStream::Screenshot> screenshots = app.screenshotsAll();
                QStringList pkgScreenshots;

                for (int i = 0; i < screenshots.count() || i < 5; i++) {
                    QString screenshot = screenshots.value(i).imagesAll().value(0).url().url();
                    pkgScreenshots << screenshot;
                }

                appData["pkgScreenshots"] = pkgScreenshots;

                if (screenshots.count() < 5) {
                    appData["pkgScreenshotsCount"] = screenshots.count();
                }
                else {
                    appData["pkgScreenshotsCount"] = 5;
                }

                appData["pkgDeveloper"] = app.developer().name();
                appData["pkgProjectLicense"] = app.projectLicense();
                appData["pkgUrlHomepage"] = app.url(AppStream::Component::UrlKindHomepage).url();
                appData["pkgUrlContact"] = app.url(AppStream::Component::UrlKindContact).url();
                appData["pkgUrlDonation"] = app.url(AppStream::Component::UrlKindDonation).url();

                if (app.releasesPlain().entries().count() != 0) {
                    appData["pkgVersion"] = app.releasesPlain().entries()[0].version();
                }
                else {
                    appData["pkgVersion"] = "0";
                }

                m_randomList.append(appData);
            }
        }

        i++;
    }

    // Obtener listado completo de aplicaciones:

    i=0;
    for (const AppStream::Component &app : apps) {

        QVariantMap appData;

        appData["pkgId"] = app.id();
        appData["pkgName"] = app.name();
        appData["pkgPackageName"] = app.packageNames();
        appData["pkgSummary"] = app.summary();
        appData["pkgDescription"] = app.description();
        appData["pkgCategories"] = app.categories();

        Icon packageIcon = app.icon(QSize(64, 64));
        appData["pkgIcon"] = packageIcon.url().toLocalFile();

        QList<AppStream::Screenshot> screenshots = app.screenshotsAll();
        QStringList pkgScreenshots;

        for (int i = 0; i < screenshots.count() || i < 5; i++) {
            QString screenshot = screenshots.value(i).imagesAll().value(0).url().url();
            pkgScreenshots << screenshot;
        }

        appData["pkgScreenshots"] = pkgScreenshots;

        if (screenshots.count() < 5) {
            appData["pkgScreenshotsCount"] = screenshots.count();
        }
        else {
            appData["pkgScreenshotsCount"] = 5;
        }

        appData["pkgDeveloper"] = app.developer().name();
        appData["pkgProjectLicense"] = app.projectLicense();
        appData["pkgUrlHomepage"] = app.url(AppStream::Component::UrlKindHomepage).url();
        appData["pkgUrlContact"] = app.url(AppStream::Component::UrlKindContact).url();
        appData["pkgUrlDonation"] = app.url(AppStream::Component::UrlKindDonation).url();

        if (app.releasesPlain().entries().count() != 0) {
            appData["pkgVersion"] = app.releasesPlain().entries()[0].version();
        }
        else {
            appData["pkgVersion"] = "0";
        }

        m_appList.append(appData);

        i++;
    }

    // Obtener listado de categorias:

    QStringList categories = {"Audio", "Video", "Development", "Education", "Science", "Game", "Graphics", "Network", "Office", "Settings", "System", "Utility", "Qt", "GTK", "Java"};
    m_categories << categories;

    /*
    QList<AppStream::Category> pkgCategories = getDefaultCategories(true);

    for (int j=0; j<pkgCategories.count(); j++) {
        QString pkgCategory = pkgCategories[j].name();
        m_categories << pkgCategory;
    }
    */
}

AppQuery::~AppQuery()
{
}

QVariantList AppQuery::randomList() const
{
    return m_randomList;
}

QVariantList AppQuery::appList() const
{
    return m_appList;
}

QStringList AppQuery::categories() const
{
    return m_categories;
}

QVariantList AppQuery::search(QString query)
{
    QVariantList appList;

    for (int i = 0; i < m_appList.count(); i++) {

        QVariantMap app = m_appList[i].toMap();

        QString name = app["pkgName"].toString();
        QString summary = app["pkgSummary"].toString();
        QString description = app["pkgDescription"].toString();
        QString packageName = app["pkgPackageName"].toString();

        bool match = false;
        for (QString item : query.split(QRegExp("\\s"), Qt::SkipEmptyParts)) {
            if (name.contains(item, Qt::CaseInsensitive) || summary.contains(item, Qt::CaseInsensitive) || description.contains(item, Qt::CaseInsensitive) || packageName.contains(item, Qt::CaseInsensitive)) {
                match = true;
            }
        }

        if (match) {
            appList.append(app);
        }
    }

    return appList;
}

void AppQuery::install(QString package)
{
    QVariantMap args;
    args["package"] = package;
    args["user"] = "root";
    args["password"] = "qcdhj";

    Action installAction("org.kde.novastore.appquery.install");
    installAction.setHelperId("org.kde.novastore.appquery");
    installAction.setArguments(args);

    qDebug() << "entra 700";

    //Q_ASSERT(installAction.isValid());

    ExecuteJob *job = installAction.execute();

    //connect(job, SIGNAL(sgInstallFinished(PackageKit::Transaction::Exit)),this, SLOT(slInstallFinished(PackageKit::Transaction::Exit, uint)));

    //connect(job, SIGNAL(sgPercentage(uint)),this, SLOT(slPercentage(uint)));

    job->setAutoDelete(false);

    connect(job, SIGNAL(finished(KJob*)),this, SLOT(slFinished(KJob*)));
    connect(job, SIGNAL(percent(KJob*,ulong)),this, SLOT(slPercent(KJob*,ulong)));

    //connect(job, SIGNAL(newData(const QVariantMap &)),this, SLOT(slPercentage(const QVariantMap &)));

    job->start();

    /*
    if (!job->exec()) {
        qDebug() << "KAuth returned an error code:" << job->error();
    }
    else {
        QString contents = job->data()["contents"].toString();
        qDebug() << "KAuth succeeded. Contents: " << contents;
    }
    */
}

void AppQuery::slPercentage(uint percentage)
{

}

void AppQuery::slPercent(KJob* job, ulong percent)
{
    qDebug() << "entra 100";
    //qDebug() << percentage;
    //sgPercentage(percentage);
}

void AppQuery::slFinished(KJob* job)
{
    qDebug() << "entra 200";
}

void AppQuery::slInstallFinished(PackageKit::Transaction::Exit status, uint runtime)
{
    qDebug("entra 1000");
    sgInstallFinished(status);
}

void AppQuery::remove(QString package)
{
    PackageKit::Transaction *getID = PackageKit::Daemon::resolve(package);

    connect(getID, &PackageKit::Transaction::package, this, [ = ] (PackageKit::Transaction::Info info, const QString &packageID) {

        qDebug() << "ID paquete:" << packageID;

        PackageKit::Transaction *transaction = PackageKit::Daemon::removePackage(packageID);

        //connect(transaction, &PackageKit::Transaction::errorCode, this, &packagekitqtexample::error);

        connect(transaction, &PackageKit::Transaction::percentageChanged, this, [ = ] {
            if (transaction->percentage() <= 100) {
                sgPercentage(transaction->percentage());
            }
        });

        connect(transaction,
            SIGNAL(finished(PackageKit::Transaction::Exit, uint)),
            SLOT(slRemoveFinished(PackageKit::Transaction::Exit, uint)));
    });
}

void AppQuery::slRemoveFinished(PackageKit::Transaction::Exit status, uint runtime) {

    sgRemoveFinished(status);
}

void AppQuery::packageState(QString package)
{
    QString *pkgInstalled = new QString;
    *pkgInstalled = "removed";

    PackageKit::Transaction *installed = PackageKit::Daemon::getPackages(Transaction::FilterInstalled | Transaction::FilterApplication);

    connect(installed, &Transaction::package, this, [ = ] (Transaction::Info info, const QString &packageID) {

        // Respuesta tipo: "yast2-samba-client;5.0.0-1.4;noarch;installed:download.opensuse.org-oss"

        if (package == Daemon::packageName(packageID)) {
            *pkgInstalled = "installed";
        }

        connect(installed, &Transaction::finished, this, [ = ] {
            sgState(*pkgInstalled);
        });
    });
}
