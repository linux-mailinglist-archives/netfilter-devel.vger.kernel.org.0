Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3B20477225
	for <lists+netfilter-devel@lfdr.de>; Thu, 16 Dec 2021 13:48:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236942AbhLPMsV (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 16 Dec 2021 07:48:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236919AbhLPMsU (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 16 Dec 2021 07:48:20 -0500
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B2AC061574
        for <netfilter-devel@vger.kernel.org>; Thu, 16 Dec 2021 04:48:20 -0800 (PST)
Received: by mail-ua1-x932.google.com with SMTP id n7so2936160uaq.12
        for <netfilter-devel@vger.kernel.org>; Thu, 16 Dec 2021 04:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=IFM2LEJFqORmc+uY2h53u1IkBzlrlFEbt1savFSaK0o=;
        b=FJ4hbZpiQCYBTBPP1Nw592hvQlEGN4e3VSwFlEN6+SQWe3NrY8tWvx59FwzhxLHRcA
         FQQAU9v0s5i2QECKKYD00VRVGGh9Y8XEDY4R6ace3ZJyZWy546QseJ6vv7kK5UDsYLkc
         PIlW3cqJg3DwI+fDiSDKm9+Px+7y5rfKYjTA4Et6tJ1OuaGkYIrt7nWk90wrbXRoLQBZ
         Ja4KTkPhodg+BP17pHMhBIBLnMlQ/TTaJ6pxbv9SAJ7m7Y7g7DFRPqT8hc1o6vIpi0iH
         A+x8Zb/J1U3af4dO9bI/X032qGBv3qm2MOpjam0gNpCyujt6xtVW2tVAqQCijwCOW1SV
         6bqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=IFM2LEJFqORmc+uY2h53u1IkBzlrlFEbt1savFSaK0o=;
        b=bDaZbAstx5Z7OW9WM1Z5+TH7ZdnoZ+UwoRorU+TZ+uO8y1q834u9N89TbnsFt4vHMi
         9L/JU0daQKg9Paka/XMeH4s84IM5hOW+huTfsR6Rz1MNpYL0lsSEfdVHYqX6ikHKh3Hg
         BNdhvzNdDNWV7o3/ETqX5Q+GOs4wxLI24tBHCP5cotMSAMW3DAnuQHb0MZQ7b8mVYqLo
         PCU/Hcjy58njo1b/x+1Nmn4c6OAJ4FLR8KFXZ9XsuNFmAWPWE1VA0703rghMJEiXyy6e
         yRRDIkzfGA+QqtRYfsEBUizvXffoAyWc8nPT0WJlmDDBzzpyvnSjM9h8fAeiaiE/3oLm
         CuKg==
X-Gm-Message-State: AOAM533i+hfBHQZLwXt/rKI3bDLYGdrw2J0aqiQhFXIIb8WK/CHz5404
        JM6iUJv59ugnspudTZLMsNik/gEFxlKHPOfmXpQ=
X-Google-Smtp-Source: ABdhPJwFTHmvsu2rRuFhImFWhwh5PyZXjiBaIcE2mE2RBazz4GGE0rTyd96lwf2oHzGTzNU+h7QcxZ+skRVmieZXxyc=
X-Received: by 2002:ab0:448:: with SMTP id 66mr2870312uav.21.1639658899575;
 Thu, 16 Dec 2021 04:48:19 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a67:cb06:0:0:0:0:0 with HTTP; Thu, 16 Dec 2021 04:48:19
 -0800 (PST)
Reply-To: schaefflermariaelisabeth5@gmail.com
From:   Maria-Elisabeth Schaeffler <madinayahaya@gmail.com>
Date:   Thu, 16 Dec 2021 04:48:19 -0800
Message-ID: <CAGm1fvGdRZLh_QoVEGMpNu=FKxORpPmW9ZTxniU68bSnEPvS-A@mail.gmail.com>
Subject: =?UTF-8?Q?Herzlichen_Gl=C3=BCckwunsch_an_Sie_und_Ihre_Familie?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

--=20
Ich bin Maria Elisabeth Schaeffler, eine deutsche Gesch=C3=A4ftsfrau, Inves=
torin
und Gesch=C3=A4ftsf=C3=BChrerin der Schaeffler Gruppe. Ich bin einer der Ei=
gent=C3=BCmer
der Schaeffler Gruppe. Ich habe 25 Prozent meines pers=C3=B6nlichen Verm=C3=
=B6gens
f=C3=BCr wohlt=C3=A4tige Zwecke verschenkt. Und ich habe auch zugestimmt, d=
ie
restlichen 25% in diesem Jahr 2021 an Einzelpersonen zu geben. Aufgrund des
Ausbruchs des Corona-Virus in Europa und dem Rest der Welt habe ich
beschlossen, Ihnen und einigen anderen zuf=C3=A4lligen Personen 2.500.000.0=
0 Euro
zu spenden. Kontaktieren Sie mich f=C3=BCr weitere Informationen.
Kontaktieren Sie uns einfach unter:  schaefflermariaelisabeth5@gmail.com

Elisabeth_Schaeffler=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Mit freundlichen Gr=C3=BC=C3=9Fen,
Frau Maria-Elisabeth Schaeffler,
Gesch=C3=A4ftsf=C3=BChrerin der Schaeffler Gruppe
