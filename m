Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67CBB1625FC
	for <lists+netfilter-devel@lfdr.de>; Tue, 18 Feb 2020 13:19:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbgBRMTu (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 18 Feb 2020 07:19:50 -0500
Received: from smtp-out.kfki.hu ([148.6.0.46]:49111 "EHLO smtp-out.kfki.hu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726086AbgBRMTu (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 18 Feb 2020 07:19:50 -0500
Received: from localhost (localhost [127.0.0.1])
        by smtp1.kfki.hu (Postfix) with ESMTP id E574B3C80103;
        Tue, 18 Feb 2020 13:19:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        blackhole.kfki.hu; h=mime-version:x-mailer:message-id:date:date
        :from:from:received:received:received; s=20151130; t=1582028386;
         x=1583842787; bh=HZS2XOQ5uwv9+gtaxWiw8Xt7RS0NkqkIoxaJBDtsbUM=; b=
        qWHVAR/4TcJyBg86mhl0RfdCPaU0TBMJ+dCXWpiimewwhOuD5BDe8pX5N+cpsE0F
        L/2n2PUv1P51kj5NRq2xhkZxo6Ix323CJifHioKjqn0MrZXkawtFyecnujZgu5x9
        2BRjtHCZ9MPzLez87losab5WiR+nBpqZfYMESxvCS58=
X-Virus-Scanned: Debian amavisd-new at smtp1.kfki.hu
Received: from smtp1.kfki.hu ([127.0.0.1])
        by localhost (smtp1.kfki.hu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP; Tue, 18 Feb 2020 13:19:46 +0100 (CET)
Received: from blackhole.kfki.hu (blackhole.kfki.hu [IPv6:2001:738:5001:1::240:2])
        by smtp1.kfki.hu (Postfix) with ESMTP id B1E453C80100;
        Tue, 18 Feb 2020 13:19:45 +0100 (CET)
Received: by blackhole.kfki.hu (Postfix, from userid 1000)
        id 89AD621D5C; Tue, 18 Feb 2020 13:19:45 +0100 (CET)
From:   Jozsef Kadlecsik <kadlec@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Hillf Danton <hdanton@sina.com>
Subject: [PATCH 0/1] ipset patch for nf
Date:   Tue, 18 Feb 2020 13:19:44 +0100
Message-Id: <20200218121945.14513-1-kadlec@netfilter.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi Pablo,

Please consider to apply the next patch to the nf tree. It's larger than
usual, but the issue could not be solved simpler.

- Fix "INFO: rcu detected stall in hash_xxx" reports of syzbot
  by introducing region locking and using workqueue instead of timer base=
d
  gc of timed out entries in hash types of sets in ipset.

Best regards,
Jozsef

The following changes since commit 83d0585f91da441a0b11bc5ff93f4cda56de67=
03:

  Merge branch 'Fix-reconnection-latency-caused-by-FIN-ACK-handling-race'=
 (2020-02-02 13:45:05 -0800)

are available in the Git repository at:

  git://blackhole.kfki.hu/nf f431c76a1f36bcd6bbfd

for you to fetch changes up to f431c76a1f36bcd6bbfd668a98127ac60226b86f:

  netfilter: ipset: Fix "INFO: rcu detected stall in hash_xxx" reports (2=
020-02-18 11:19:06 +0100)

----------------------------------------------------------------
Jozsef Kadlecsik (1):
      netfilter: ipset: Fix "INFO: rcu detected stall in hash_xxx" report=
s

 include/linux/netfilter/ipset/ip_set.h |  11 +-
 net/netfilter/ipset/ip_set_core.c      |  34 +-
 net/netfilter/ipset/ip_set_hash_gen.h  | 633 +++++++++++++++++++++++----=
------
 3 files changed, 472 insertions(+), 206 deletions(-)
