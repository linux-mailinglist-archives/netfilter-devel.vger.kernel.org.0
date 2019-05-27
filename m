Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C69582BBDC
	for <lists+netfilter-devel@lfdr.de>; Mon, 27 May 2019 23:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbfE0Vxt (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 27 May 2019 17:53:49 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:45516 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726905AbfE0Vxs (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 27 May 2019 17:53:48 -0400
Received: by mail-oi1-f194.google.com with SMTP id w144so12751470oie.12
        for <netfilter-devel@vger.kernel.org>; Mon, 27 May 2019 14:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=7ZTtahQitbGmJ9uuOxkCfQEHBqEdsZ7ddbeEF/b3ksQ=;
        b=L9RHC6vUWOzxdbIjOpjOkWauJqBQhmayPowcx2ppQjMeVNXpiZZIHB4PvECjQzRy1k
         QJzNfaIrLTEka59qP/EhqvUrD6mPFmst0W7/w3yq819zZ767pDCJumQry3Rv0YdTvSWb
         0PEI9mc04WWQIyHdonGGmfN8NM33my6IctZZi/d08M+XEg5QMCtWPAFQt8k7NJKg893P
         4dnItl6p741OYTrSbKMJ5EHCV9x0EZxkLoolGbr7irkyVckHVEAJmJpxHlzekxJCzV+i
         EsxtSLdZKsrJqPsAbEDWaZ6vsf44B+r6RwvyEfbh0LZTbCpYy8xoOjNOLzgN/f+ZgEgF
         24Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=7ZTtahQitbGmJ9uuOxkCfQEHBqEdsZ7ddbeEF/b3ksQ=;
        b=AEx3YcG/jT8iKYv3Z0/ZBRwPZYTniI9BNqoy6CZCQBEo9ppqoQU9hjG2Gvq7kPMWmf
         O5tn5l8kz424aZJ8hPoHmBvwU8VmfqCwrpCJyHjnmUuTsnPpLlJdIMaQs91FIMTvtA5e
         7pU2c50JrhS+5j2SOxgsfr2016DMaIYtM2BRbDOzF/+Yw+VOClzSwyIdpQYjw3LN1m0r
         GpcQe73Vzo7KekANZgaeYF7SlLmiGcF9M+8DET1Vcs1ghhkp+yspRmyTMllD1K3Sxd6N
         qyaMjDSTP55p0F1mVHQNSqbpoewJd9vWutZX1WidS/IO+0CUJdF28iVG4nX6h0Tcwl4k
         yZZQ==
X-Gm-Message-State: APjAAAX/YtcBqKOpIxyT9QmgO97a4IyrBHv/cWnavzs8TKsvp+ymX4fr
        P6J1MjoYa9EqxNa72LrxgM6NGtlL64eg6tSbXEJMDRsU
X-Google-Smtp-Source: APXvYqx2d41yqeBDkED3IstNL9HbQHWo6iCCPPCxT4G/7cILXkRYqBAlRClYLZyNkbBJEVYH+1oTjMMYnXSXBW0/LTs=
X-Received: by 2002:aca:4202:: with SMTP id p2mr679392oia.85.1558994028099;
 Mon, 27 May 2019 14:53:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190524184409.466036-1-shekhar250198@gmail.com> <20190527155454.GY31548@orbyte.nwl.cc>
In-Reply-To: <20190527155454.GY31548@orbyte.nwl.cc>
From:   shekhar sharma <shekhar250198@gmail.com>
Date:   Tue, 28 May 2019 03:23:37 +0530
Message-ID: <CAN9XX2ogpXrNKrAzpa52PgnLNCDy_Xwt4qxFRBU2hmOQr=GLtQ@mail.gmail.com>
Subject: Re: [PATCH nft v1] tests: json_echo: fix python3
To:     Phil Sutter <phil@nwl.cc>,
        Shekhar Sharma <shekhar250198@gmail.com>,
        netfilter-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi,

On Mon, May 27, 2019 at 9:24 PM Phil Sutter <phil@nwl.cc> wrote:
>
> Hi,
>
> On Sat, May 25, 2019 at 12:14:09AM +0530, Shekhar Sharma wrote:
> > This patch converts the 'run-test.py' file to run on both python2 and python3.
> >
> > Signed-off-by: Shekhar Sharma <shekhar250198@gmail.com>
> > ---
> >  tests/json_echo/run-test.py | 45 +++++++++++++++++++------------------
> >  1 file changed, 23 insertions(+), 22 deletions(-)
> >
> > diff --git a/tests/json_echo/run-test.py b/tests/json_echo/run-test.py
> > index 0132b139..f5c81b7d 100755
> > --- a/tests/json_echo/run-test.py
> > +++ b/tests/json_echo/run-test.py
> > @@ -1,5 +1,7 @@
> >  #!/usr/bin/python2
>
> If the script now runs with either python 2 or 3, maybe change the
> shebang to just '/usr/bin/python'?
>

Yes, will change it to 'usr/bin/python' in the next patch.

> > +from nftables import Nftables
> > +from __future__ import print_function
> >  import sys
> >  import os
> >  import json
> > @@ -7,14 +9,13 @@ import json
> >  TESTS_PATH = os.path.dirname(os.path.abspath(__file__))
> >  sys.path.insert(0, os.path.join(TESTS_PATH, '../../py/'))
> >
> > -from nftables import Nftables
>
> Are you aware that the import was put here deliberately after the call
> to sys.path.insert()? Why did you decide to move the import call?
>
I was not aware of that. I just thought that every 'from __ import __
' statement
should be written before 'import __' statements :-) .
Will change it.

> >  # Change working directory to repository root
> >  os.chdir(TESTS_PATH + "/../..")
> >
> >  if not os.path.exists('src/.libs/libnftables.so'):
> > -    print "The nftables library does not exist. " \
> > -          "You need to build the project."
> > +    print("The nftables library does not exist. " \
> > +          "You need to build the project.")
> >      sys.exit(1)
>
> Drop the backslash here?
>

Yes, will do that.

> Cheers, Phil

Will do the necessary changes.
Thanks!

Shekhar
