Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB5336EB49
	for <lists+netfilter-devel@lfdr.de>; Thu, 29 Apr 2021 15:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233651AbhD2N1r (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 29 Apr 2021 09:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232867AbhD2N1q (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 29 Apr 2021 09:27:46 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66476C06138B
        for <netfilter-devel@vger.kernel.org>; Thu, 29 Apr 2021 06:27:00 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id i9-20020a4ad0890000b02901efee2118aaso7103457oor.7
        for <netfilter-devel@vger.kernel.org>; Thu, 29 Apr 2021 06:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=MK1JNYymHNZjAuSw7w569yYJuYIhIGNffTSHi9WTjH0=;
        b=Yd/gwrGrA1sXWFejRB5GQuk2YX01TKu6lkmF8GkjKFgVgVp+sIlsmvfjcSFIEXFNZ/
         MCy6Fp8h0OD9TPLZMpM7f6oNppu3qEdJpY2hQXctwxi0ozyv5OKJdOFKBLezXPilsNPJ
         kNqGDlw3fXr9wayUygDSALko2P58TFZ9cnWjlnXnHIoYVIHeRhm59PJFN2J1nGemS7Mx
         JYLZZTwCsHLba6XRSmIfq39kC6Xp9jTOSOXJ62Nroq+ECGZ1lqOONaPXm2PUzIwnStXE
         ergumm4kFoY73WwlN4tUsZ0cmpLpk1g0T4wqEVoiN4yEj9hJODhxtaTDH7atcQ/MeH0m
         Xx2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=MK1JNYymHNZjAuSw7w569yYJuYIhIGNffTSHi9WTjH0=;
        b=Q/0yMddqZHuArPeuiNJ4trs3bgTeKmh690htm2hvWPptllFMbJFLyY3V7Cq568eGoX
         rp8Sua/uFtLbvooKpl+9m0xvdWsq6bUX8fzfDalxkV5wP2qvfQOdYi33KoUmAasQMGAY
         jWms+cR+Omnvs3dMl58j2ezYlymTwjx/Ch2BHc0y1T2EBSazCJ9g2Zz0o4gUYisUVD+k
         EsXtjm33tcbOT+Ea6CdSQO11ezPmxgstRaPIfX//wRO/oiOCCra8O/oPueUnN6Ueh0+H
         aEHMe9MpNByn3e+IgXDWab2hfgE92kOIJQ8Vz4VTm+oMaxXVG+vYwqUXB7Yg6+ax4Dqv
         8gAg==
X-Gm-Message-State: AOAM533gMGufktLn07gy/NDviCBHQs4Wo+mxEp2TcQO+GI3raF5STOYU
        /NThzrC3DefN0De06iAHNenqGrgRR0VXnZgMhlE=
X-Google-Smtp-Source: ABdhPJxy3IcTJLo9Flz1NoUT33SKwmzRdoeclwlNbRKReu6DLEAugmhlFjWDpSC3XkrtT7Xn2ngFPDEEIeb75pCdIXo=
X-Received: by 2002:a4a:3419:: with SMTP id b25mr999ooa.18.1619702819672; Thu,
 29 Apr 2021 06:26:59 -0700 (PDT)
MIME-Version: 1.0
Sender: 93531103abala@gmail.com
Received: by 2002:a05:6838:7871:0:0:0:0 with HTTP; Thu, 29 Apr 2021 06:26:59
 -0700 (PDT)
From:   kayla manthey <sgtmanthey1@gmail.com>
Date:   Thu, 29 Apr 2021 13:26:59 +0000
X-Google-Sender-Auth: pVvA5bdclhqjCKiPXE12jA8NFs0
Message-ID: <CAGEfFFfxqTmuP5mn5ySJXqSvWxRdLsZHSLOG2uL7ei9zvL=H0Q@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

K=C3=A9rem, szeretn=C3=A9m tudni, hogy megkapta-e az el=C5=91z=C5=91 =C3=BC=
zeneteimet.
