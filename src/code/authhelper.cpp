/*
 *   SPDX-FileCopyrightText: 2016 Aleix Pol Gonzalez <aleixpol@blue-systems.com>
 *
 *   SPDX-License-Identifier: GPL-2.0-only OR GPL-3.0-only OR LicenseRef-KDE-Accepted-GPL
 */

#include "authhelper.h"

AuthHelper::AuthHelper()
{
    qDebug() << "600";
}

ActionReply AuthHelper::install(const QVariantMap &args)
{
    qDebug("entra 800");

    ActionReply reply;

    QString package = args["package"].toString();
    QString user = args["user"].toString();
    QString password = args["password"].toString();

    // Install

    qDebug() << package;
    PackageKit::Transaction *getID = PackageKit::Daemon::resolve(package);

    connect(getID, &PackageKit::Transaction::package, this, [ = ] (PackageKit::Transaction::Info info, const QString &packageID) {

        qDebug() << "ID paquete:" << packageID;

        PackageKit::Transaction *transaction = PackageKit::Daemon::installPackage(packageID);

        //connect(transaction, &PackageKit::Transaction::errorCode, this, &packagekitqtexample::error);

        connect(transaction, &PackageKit::Transaction::percentageChanged, this, [ = ] {
            if (transaction->percentage() <= 100) {
                qDebug() << "Percentage changed";
                qDebug() << transaction->percentage();
                HelperSupport::progressStep(transaction->percentage());
            }
        });

        connect(transaction,
            SIGNAL(finished(PackageKit::Transaction::Exit, uint)),
            SLOT(slInstallFinished(PackageKit::Transaction::Exit, uint)));
    });

    QString contents = "Started";
    reply.addData("contents", contents);
    return reply;
}

void AuthHelper::slInstallFinished(PackageKit::Transaction::Exit status, uint runtime)
{
    // sgInstallFinished(status);
}

KAUTH_HELPER_MAIN("org.kde.novastore.appquery", AuthHelper)
