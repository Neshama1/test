// <one line to give the program's name and a brief idea of what it does.>
// SPDX-FileCopyrightText: 2024 Miguel <email>
// SPDX-License-Identifier: GPL-3.0-or-later

#ifndef APPQUERY_H
#define APPQUERY_H

#include <QDebug>
#include <QVariantList>
#include <QVariantMap>

#include <KAuth/Action>
#include <KAuth/ExecuteJob>

#include <packagekitqt5/PackageKit/Daemon>
#include <packagekitqt5/PackageKit/Transaction>

#include <AppStreamQt5/appstreamqt_export.h>
#include <AppStreamQt5/component.h>
#include <AppStreamQt5/image.h>
#include <AppStreamQt5/provided.h>
#include <AppStreamQt5/release-list.h>
#include <AppStreamQt5/systeminfo.h>
#include <AppStreamQt5/video.h>
#include <AppStreamQt5/bundle.h>
#include <AppStreamQt5/contentrating.h>
#include <AppStreamQt5/launchable.h>
#include <AppStreamQt5/relation-check-result.h>
#include <AppStreamQt5/screenshot.h>
#include <AppStreamQt5/translation.h>
#include <AppStreamQt5/category.h>
#include <AppStreamQt5/developer.h>
#include <AppStreamQt5/metadata.h>
#include <AppStreamQt5/relation.h>
#include <AppStreamQt5/spdx.h>
#include <AppStreamQt5/utils.h>
#include <AppStreamQt5/component-box.h>
#include <AppStreamQt5/icon.h>
#include <AppStreamQt5/pool.h>
#include <AppStreamQt5/release.h>
#include <AppStreamQt5/suggested.h>
#include <AppStreamQt5/version.h>

using namespace KAuth;

/**
 * @todo write docs
 */
class AppQuery : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QVariantList randomList READ randomList)
    Q_PROPERTY(QVariantList appList READ appList)
    Q_PROPERTY(QStringList categories READ categories)

public:
    Q_INVOKABLE QVariantList search(QString query);
    Q_INVOKABLE void install(QString package);
    Q_INVOKABLE void remove(QString package);
    Q_INVOKABLE void packageState(QString package);

public:
    /**
     * Default constructor
     */
    AppQuery();

    /**
     * Destructor
     */
    ~AppQuery();

    /**
     * @return the randomList
     */
    QVariantList randomList() const;

    /**
     * @return the appList
     */
    QVariantList appList() const;

    /**
     * @return the categories
     */
    QStringList categories() const;

public Q_SLOTS:

Q_SIGNALS:

signals:
    void sgState(QString state);
    void sgInstallFinished(PackageKit::Transaction::Exit status);
    void sgRemoveFinished(PackageKit::Transaction::Exit status);
    void sgPercentage(uint percentage);

public slots:
    void slInstallFinished(PackageKit::Transaction::Exit status, uint runtime);
    void slRemoveFinished(PackageKit::Transaction::Exit status, uint runtime);
    void slPercent(KJob* job, ulong percent);
    void slFinished(KJob* job);
    void slPercentage(uint percentage);

private:
    QVariantList m_randomList;
    QVariantList m_appList;
    QStringList m_categories;
    //AuthHelper authHelper;
};

#endif // APPQUERY_H
