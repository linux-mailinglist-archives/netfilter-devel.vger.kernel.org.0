Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66B48E90DF
	for <lists+netfilter-devel@lfdr.de>; Tue, 29 Oct 2019 21:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbfJ2UkP (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 29 Oct 2019 16:40:15 -0400
Received: from mail-lf1-f48.google.com ([209.85.167.48]:34082 "EHLO
        mail-lf1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbfJ2UkP (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 29 Oct 2019 16:40:15 -0400
Received: by mail-lf1-f48.google.com with SMTP id f5so11585603lfp.1
        for <netfilter-devel@vger.kernel.org>; Tue, 29 Oct 2019 13:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=Dx5+JNmfFKuuzPwW0hD/ajE50QP8y6YwVy2D4hsmGSA=;
        b=Wyf2O3Iojssz26GvQywcBT1LpkwnbmWNaHH1ljItgz9d4hiQ0i+zR2PUX7gKs0Y9/b
         Ds9xipzpUGXba7/XgcgG605/S0oqr+/9qPP0BGXrw8AsWB/q0stkNuTatwm7/80ciQEV
         N9B8ojnkvfnP3GCcCcDrRTtlQoBme7UqG10Ilwtxk5bG/yzPUu13E1oEeqqJCUCd5KlO
         XBXBnFjeYW6atv1jJZMVKFvMyIB7nKSgKGu1W4aRwrd9MBp0RPwLG1Oq20RjOX1Dfzqc
         dL5eo5RpjCQsgqFeFXD0h9Ru8tSQZbIxNEb5AL65Ujc30uQ+9BQHPQEmH3hJk0zrresP
         KdzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Dx5+JNmfFKuuzPwW0hD/ajE50QP8y6YwVy2D4hsmGSA=;
        b=fUtt9kswwzjXtCL60OAQO77oQtFiUf7MLGKdNLlEbGs3EKrIk5oWtFuCPBReHmF326
         4g6FkxvI3p8uNy+4HeTXg64ZyDcU/3t6UysG6SCSEN1t5iRwPCFObVilMS282BPPDzc9
         MbwUha7G2InV+6DSwpj9LJ/Y6O0L7WI0EfJg/zDwXv0AuCSFvdyJQWGPfvK7qPqd1hwD
         YmqgyGh+0RbsAwd2vCH5t2aci9WQK1fVW5fbyg7NJY07+sfRLkTVOSEp89GZx+9cFQD0
         QgEyUVLZ7qNDqklqDqmZQokdkq8qcdklGN31uPY4RjNtwnAkf/FyhqwJl71SIisybJ8r
         zWsw==
X-Gm-Message-State: APjAAAX36haP6pI5H+O64kaktVovpXAnUU9pC4959hjpp6fAXoa9obkH
        HDukHEu+CjQYIqGkTruxV+30tZZfKxPRpFMOz5rZEvy0Z70=
X-Google-Smtp-Source: APXvYqxkk8D8ONMPHpyVIBzDGOSTyblnmBtyClgqKbh4U8Mpdp8SuagMA1dn8Uf9OpdOvXTu+T8xmFo6ngJ8Z/XegdA=
X-Received: by 2002:a19:9202:: with SMTP id u2mr3654080lfd.1.1572381612690;
 Tue, 29 Oct 2019 13:40:12 -0700 (PDT)
MIME-Version: 1.0
From:   Oskar Berggren <oskar.berggren@gmail.com>
Date:   Tue, 29 Oct 2019 20:40:01 +0000
Message-ID: <CAHOuc7MXK7nqU84y7KnoO_4DdJPL2ts33c0tDENyS3bgHhZgeg@mail.gmail.com>
Subject: ipset make modules_install always fail unless module already loaded?
To:     netfilter-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi,

In Makefile.am there is this block:

modules_install:
if WITH_KMOD
    ${MAKE} -C $(KBUILD_OUTPUT) M=$$PWD/kernel/net \
            KDIR=$$PWD/kernel modules_install
    @modinfo -b ${INSTALL_MOD_PATH} ip_set_hash_ip | ${GREP} /extra/
>/dev/null || echo "$$DEPMOD_WARNING"
    @lsmod | ${GREP} '^ip_set' >/dev/null && echo "$$MODULE_WARNING"
else
    @echo Skipping kernel modules due to --with-kmod=no
endif

I'm rusty on shell script, but it seems to me that the line with lsmod
will print the warning
and return exit code 0 if a matching module is loaded but if such a
module is NOT loaded,
grep will give exit code 1 (intended) and it will not print the
warning (intended) but then the
whole line will return exit code 1 cause make to stop with an error.
If being run from another
script it can/will stop that script from continuing.

In short - make modules_install will only run successfully if an ipset
module is already loaded. At least I seem to get this problem.

/Oskar
