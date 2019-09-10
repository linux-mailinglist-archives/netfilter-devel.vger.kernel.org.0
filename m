Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE9AAF13C
	for <lists+netfilter-devel@lfdr.de>; Tue, 10 Sep 2019 20:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbfIJSsF (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 10 Sep 2019 14:48:05 -0400
Received: from mail-yb1-f170.google.com ([209.85.219.170]:33662 "EHLO
        mail-yb1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbfIJSsF (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 10 Sep 2019 14:48:05 -0400
Received: by mail-yb1-f170.google.com with SMTP id a17so6498132ybc.0
        for <netfilter-devel@vger.kernel.org>; Tue, 10 Sep 2019 11:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=bkXdj1CFWudvq7DOtA73wfJMgU7n6+lwm3No/pECNFI=;
        b=Hv8reNl7MEyOra6QFrFCCpCETnw4/3mkq0bdnXvH79I71bhZOcXXlxqGHJfQ1LIoLQ
         PWr1QzsC4ksc5CAnM4PoDW5QNKBeTE+9FS+Yh2XagOfANkdo+mBOvA9JEW5Vs82cmn2p
         CEwGaxAcQoC6fBHY9uEalZUG4XezjnoN6aZHX8rti6l3TnVQIsOGZ+Jh0h3eq1UO/oxG
         eOb1oylKcTQ+tiUm5AOk+xArRF9mgvuWP/uRI9dC+4rBD22iFI/qWonoAR2TGluyCppW
         mp13ghDmz9qYCbm5BYSfI1IS/2Z48dvAz2DK37EG4Pia+YBZPBSAFzbphEVkNJjXezA7
         Q3vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=bkXdj1CFWudvq7DOtA73wfJMgU7n6+lwm3No/pECNFI=;
        b=lGMD3YZlgyRPk6az1yJHpUFQmDg8N5mZrV7oX0z8uWruDrv93jcxFz/TCvv5nBN+ev
         9MPuq4BII0mg4JVLf2xFBr0QHcVEbNCD59pqUHtHG9tQcvZOECAWN/ft8/+MudJuxFQj
         RTQO8Etqyrz4D0DJhlM1rosyFPBkQYDbcfMgsrDCIIcYs0JlOcPzi0BSVIzM6tPVv2EA
         TVzgY5WnHU2j4OXfn/SJsd5QxvnF2a9K8yYsMQxFu1Yipfng5bNnKhwcLBiF6I0eOuEU
         JUBshaI2DaThvF3JaGZAgn+v+nrHrztXYiOeJDDnBq8Cgu+ly5wnck/slVaP3y/B1q/4
         h9DA==
X-Gm-Message-State: APjAAAUXDwf2nu44iY/ZnNX/PEtA0zsltG6ZSK1OWunF+DD1T6+eQcK3
        HlUGdStGXUZ3DF7vN9Ff6zUTqVFvgKrJSm/yxBSKqB5L2Cs=
X-Google-Smtp-Source: APXvYqxhlBZIpxKg7ozAJ6AsOczJcBOzU+nIhs/Wd93KrwoJQNevprhv01IC5zpkYcapAhNuNjTz21hGpJfqRG2X4Xc=
X-Received: by 2002:a25:dc13:: with SMTP id y19mr10037768ybe.245.1568141284379;
 Tue, 10 Sep 2019 11:48:04 -0700 (PDT)
MIME-Version: 1.0
From:   Fabio Pedretti <pedretti.fabio@gmail.com>
Date:   Tue, 10 Sep 2019 20:47:29 +0200
Message-ID: <CA+fnjVBoZ4k4K0VXVAAjiVknts0=RJADEJ-dB1Xbdq6MVG9eQQ@mail.gmail.com>
Subject: iptables release
To:     netfilter-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi, is there a plan to push a new release of iptables?
It has some fixes which are routinely reported in distros having
latest stable release 1.8.3.
Thanks
