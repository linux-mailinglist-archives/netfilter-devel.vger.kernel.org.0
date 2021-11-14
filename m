Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C86644F8A6
	for <lists+netfilter-devel@lfdr.de>; Sun, 14 Nov 2021 15:58:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234325AbhKNPBs (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 14 Nov 2021 10:01:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234744AbhKNPBp (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 14 Nov 2021 10:01:45 -0500
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B92C061746
        for <netfilter-devel@vger.kernel.org>; Sun, 14 Nov 2021 06:58:51 -0800 (PST)
Received: by a3.inai.de (Postfix, from userid 25121)
        id EB7375877993C; Sun, 14 Nov 2021 15:58:48 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id E716560D27781;
        Sun, 14 Nov 2021 15:58:48 +0100 (CET)
Date:   Sun, 14 Nov 2021 15:58:48 +0100 (CET)
From:   Jan Engelhardt <jengelh@inai.de>
To:     Jeremy Sowden <jeremy@azazel.net>
cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: Re: [ulogd2 PATCH v3 14/16] build: remove unnecessary `AC_SUBST`
 calls
In-Reply-To: <20211114140058.752394-15-jeremy@azazel.net>
Message-ID: <72852nsr-op91-6618-2r4-73995n6rs64@vanv.qr>
References: <20211114140058.752394-1-jeremy@azazel.net> <20211114140058.752394-15-jeremy@azazel.net>
User-Agent: Alpine 2.25 (LSU 592 2021-09-18)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org


On Sunday 2021-11-14 15:00, Jeremy Sowden wrote:

>We don't use the variables being passed to `AC_SUBST` in these calls as
>output variables, so remove them.

>-AC_SUBST(PQINCPATH)
>-AC_SUBST(PQLIBPATH)
>-AC_SUBST(PQLIBS)

Eh, but why? These are all still used.

output/pgsql/Makefile.am:AM_CPPFLAGS = -I$(top_srcdir)/include -I$(PQINCPATH)

>-AC_SUBST(MYSQL_INC)
>-AC_SUBST([libdl_LIBS])
>-AC_SUBST([libpthread_LIBS])

src/Makefile.am:ulogd_LDADD   = ${libdl_LIBS} ${libpthread_LIBS}

