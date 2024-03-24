#pragma once

#include "authhelper.moc"

#include <QObject>
#include <QDebug>
#include <QString>
#include <KAuth/ActionReply>
#include <KAuth/HelperSupport>
#include <KAuth/ExecuteJob>
#include <packagekitqt5/PackageKit/Daemon>
#include <packagekitqt5/PackageKit/Transaction>

#include <QThread>

using namespace KAuth;
using namespace PackageKit;

class AuthHelper : public QObject
{
    Q_OBJECT

public:
    AuthHelper();

public Q_SLOTS:
    ActionReply install(const QVariantMap &args);
    void slInstallFinished(PackageKit::Transaction::Exit status, uint runtime);

signals:
    //void sgInstallFinished(PackageKit::Transaction::Exit status);
    //void sgPercentage(uint percentage);

public:
    //int m_percent;
};
