Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC9F43E56B0
	for <lists+netfilter-devel@lfdr.de>; Tue, 10 Aug 2021 11:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238881AbhHJJWd (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 10 Aug 2021 05:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237758AbhHJJVh (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 10 Aug 2021 05:21:37 -0400
Received: from smtp-out.kfki.hu (smtp-out.kfki.hu [IPv6:2001:738:5001::48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F61AC0617A2;
        Tue, 10 Aug 2021 02:21:01 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by smtp2.kfki.hu (Postfix) with ESMTP id C1DA1CC00E1;
        Tue, 10 Aug 2021 11:20:55 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at smtp2.kfki.hu
Received: from smtp2.kfki.hu ([127.0.0.1])
        by localhost (smtp2.kfki.hu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP; Tue, 10 Aug 2021 11:20:51 +0200 (CEST)
Received: from blackhole.kfki.hu (blackhole.szhk.kfki.hu [148.6.240.2])
        by smtp2.kfki.hu (Postfix) with ESMTP id DE260CC00F4;
        Tue, 10 Aug 2021 11:20:51 +0200 (CEST)
Received: by blackhole.kfki.hu (Postfix, from userid 1000)
        id C7FC3340D60; Tue, 10 Aug 2021 11:20:51 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by blackhole.kfki.hu (Postfix) with ESMTP id C3C35340D5D;
        Tue, 10 Aug 2021 11:20:51 +0200 (CEST)
Date:   Tue, 10 Aug 2021 11:20:51 +0200 (CEST)
From:   Jozsef Kadlecsik <kadlec@netfilter.org>
To:     netfilter@vger.kernel.org, netfilter-devel@vger.kernel.org
Subject: [ANNOUNCE] ipset 7.15 released
Message-ID: <37635e40-d279-8f10-a3d1-c33d36923836@netfilter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi,

The new ipset 7.15 release contains a single fix against the previous 
version: a condition was wrongly placed in the hash:ip,port,net kernel 
module. Please upgrade to the new release.

Kernel part changes:
  - netfilter: ipset: Fix maximal range check in hash_ipportnet4_uadt() 
    (Nathan Chancellor)

You can download the source code of ipset from:
        https://ipset.netfilter.org
        ftp://ftp.netfilter.org/pub/ipset/
        git://git.netfilter.org/ipset.git

Best regards,
Jozsef
-
E-mail  : kadlec@blackhole.kfki.hu, kadlecsik.jozsef@wigner.mta.hu
PGP key : http://www.kfki.hu/~kadlec/pgp_public_key.txt
Address : Wigner Research Centre for Physics, Hungarian Academy of Sciences
          H-1525 Budapest 114, POB. 49, Hungary
