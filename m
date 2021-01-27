Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4F5305D6B
	for <lists+netfilter-devel@lfdr.de>; Wed, 27 Jan 2021 14:42:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbhA0NmE (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 27 Jan 2021 08:42:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235412AbhA0Nk6 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 27 Jan 2021 08:40:58 -0500
Received: from smtp-out.kfki.hu (smtp-out.kfki.hu [IPv6:2001:738:5001::48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A32C06174A
        for <netfilter-devel@vger.kernel.org>; Wed, 27 Jan 2021 05:40:18 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by smtp2.kfki.hu (Postfix) with ESMTP id 1CEACCC0185;
        Wed, 27 Jan 2021 14:39:01 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at smtp2.kfki.hu
Received: from smtp2.kfki.hu ([127.0.0.1])
        by localhost (smtp2.kfki.hu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP; Wed, 27 Jan 2021 14:38:58 +0100 (CET)
Received: from blackhole.kfki.hu (blackhole.szhk.kfki.hu [IPv6:2001:738:5001:1::240:2])
        by smtp2.kfki.hu (Postfix) with ESMTP id D38C9CC0162;
        Wed, 27 Jan 2021 14:38:58 +0100 (CET)
Received: by blackhole.kfki.hu (Postfix, from userid 1000)
        id C0266340D5D; Wed, 27 Jan 2021 14:38:58 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by blackhole.kfki.hu (Postfix) with ESMTP id BC8C6340D5C;
        Wed, 27 Jan 2021 14:38:58 +0100 (CET)
Date:   Wed, 27 Jan 2021 14:38:58 +0100 (CET)
From:   Jozsef Kadlecsik <kadlec@netfilter.org>
X-X-Sender: kadlec@blackhole.kfki.hu
To:     Reindl Harald <h.reindl@thelounge.net>
cc:     netfilter-devel@vger.kernel.org
Subject: Re: https://bugzilla.kernel.org/show_bug.cgi?id=207773
In-Reply-To: <9ab32341-ca2f-22e2-0cb0-7ab55198ab80@thelounge.net>
Message-ID: <alpine.DEB.2.23.453.2101271435390.11052@blackhole.kfki.hu>
References: <9ab32341-ca2f-22e2-0cb0-7ab55198ab80@thelounge.net>
User-Agent: Alpine 2.23 (DEB 453 2020-06-18)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi,

On Wed, 27 Jan 2021, Reindl Harald wrote:

> for the sake of god may someone look at this?
> https://bugzilla.kernel.org/show_bug.cgi?id=207773

Could you send your iptables rules and at least the set definitions 
without the set contents? I need to reproduce the issue.

Best regards,
Jozsef
-
E-mail  : kadlec@blackhole.kfki.hu, kadlecsik.jozsef@wigner.hu
PGP key : https://wigner.hu/~kadlec/pgp_public_key.txt
Address : Wigner Research Centre for Physics
          H-1525 Budapest 114, POB. 49, Hungary
