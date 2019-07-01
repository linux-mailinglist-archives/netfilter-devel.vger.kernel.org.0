Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A40AF3B4D8
	for <lists+netfilter-devel@lfdr.de>; Mon, 10 Jun 2019 14:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389705AbfFJMYV (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 10 Jun 2019 08:24:21 -0400
Received: from smtp-out.kfki.hu ([148.6.0.46]:49225 "EHLO smtp-out.kfki.hu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389573AbfFJMYV (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 10 Jun 2019 08:24:21 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp1.kfki.hu (Postfix) with ESMTP id 1C9073C800F3;
        Mon, 10 Jun 2019 14:24:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        blackhole.kfki.hu; h=mime-version:x-mailer:message-id:date:date
        :from:from:received:received:received; s=20151130; t=1560169456;
         x=1561983857; bh=8B1MCq0ya2meUCBTuCgd2+V6uDk8GQV5Sg2CQL8YygQ=; b=
        HwC/T23PwX9MJsnTsE3v8UumTHuLS5YYkZ3Hqs3Pm3gt+BuuAPK2yXvYkKy6Wdis
        LUtzPMxKERnqDaEkxu7kUuLfny1ZtNzYc2V1x3v7VAGl6/gZCsBZB0LNTpxxaZUj
        AeGjDJho5QAbC9Qpr5XNTYRByQLLZMZlIXtVzVYTJdQ=
X-Virus-Scanned: Debian amavisd-new at smtp1.kfki.hu
Received: from smtp1.kfki.hu ([127.0.0.1])
        by localhost (smtp1.kfki.hu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP; Mon, 10 Jun 2019 14:24:16 +0200 (CEST)
Received: from blackhole.kfki.hu (blackhole.szhk.kfki.hu [148.6.240.2])
        by smtp1.kfki.hu (Postfix) with ESMTP id C8EF53C800F5;
        Mon, 10 Jun 2019 14:24:16 +0200 (CEST)
Received: by blackhole.kfki.hu (Postfix, from userid 1000)
        id B5FC722577; Mon, 10 Jun 2019 14:24:16 +0200 (CEST)
From:   Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>
To:     netfilter-devel@vger.kernel.org
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 0/7] ipset patches for nf-next
Date:   Mon, 10 Jun 2019 14:24:09 +0200
Message-Id: <20190610122416.22708-1-kadlec@blackhole.kfki.hu>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi Pablo,

Please consider to pull the next patches for the nf-next tree:

- Remove useless memset() calls, nla_parse_nested/nla_parse
  erase the tb array properly, from Florent Fourcot.
- Merge the uadd and udel functions, the code is nicer
  this way, also from Florent Fourcot.
- Add a missing check for the return value of a
  nla_parse[_deprecated] call, from Aditya Pakki.
- Add the last missing check for the return value
  of nla_parse[_deprecated] call.
- Fix error path and release the references properly
  in set_target_v3_checkentry().
- Fix memory accounting which is reported to userspace
  for hash types on resize, from Stefano Brivio.
- Update my email address to kadlec@netfilter.org.
  The patch covers all places in the source tree where
  my kadlec@blackhole.kfki.hu address could be found.
  If the patch needs to be splitted up, just let me know!

Best regards,
Jozsef

The following changes since commit 16e6427c88c5b7e7b6612f6c286d5f71d659e5=
be:

  netfilter: ipv6: Fix undefined symbol nf_ct_frag6_gather (2019-06-06 11=
:52:59 +0200)

are available in the Git repository at:

  git://blackhole.kfki.hu/nf-next fe03d4745675cbd678cb8

for you to fetch changes up to fe03d4745675cbd678cb8c50d951df0abafdcaee:

  Update my email address (2019-06-10 13:00:24 +0200)

----------------------------------------------------------------
Aditya Pakki (1):
      netfilter: ipset: fix a missing check of nla_parse

Florent Fourcot (2):
      netfilter: ipset: remove useless memset() calls
      netfilter: ipset: merge uadd and udel functions

Jozsef Kadlecsik (3):
      netfilter: ipset: Fix the last missing check of nla_parse_deprecate=
d()
      netfilter: ipset: Fix error path in set_target_v3_checkentry()
      Update my email address

Stefano Brivio (1):
      ipset: Fix memory accounting for hash types on resize

 CREDITS                                        |  2 +-
 MAINTAINERS                                    |  2 +-
 include/linux/jhash.h                          |  2 +-
 include/linux/netfilter/ipset/ip_set.h         |  2 +-
 include/linux/netfilter/ipset/ip_set_counter.h |  2 +-
 include/linux/netfilter/ipset/ip_set_skbinfo.h |  2 +-
 include/linux/netfilter/ipset/ip_set_timeout.h |  2 +-
 include/uapi/linux/netfilter/ipset/ip_set.h    |  2 +-
 net/ipv4/netfilter/iptable_raw.c               |  2 +-
 net/ipv4/netfilter/nf_nat_h323.c               |  2 +-
 net/ipv6/netfilter/ip6table_raw.c              |  2 +-
 net/netfilter/ipset/ip_set_bitmap_gen.h        |  2 +-
 net/netfilter/ipset/ip_set_bitmap_ip.c         |  4 +-
 net/netfilter/ipset/ip_set_bitmap_ipmac.c      |  4 +-
 net/netfilter/ipset/ip_set_bitmap_port.c       |  4 +-
 net/netfilter/ipset/ip_set_core.c              | 97 ++++++++++----------=
------
 net/netfilter/ipset/ip_set_getport.c           |  2 +-
 net/netfilter/ipset/ip_set_hash_gen.h          |  4 +-
 net/netfilter/ipset/ip_set_hash_ip.c           |  4 +-
 net/netfilter/ipset/ip_set_hash_ipmark.c       |  2 +-
 net/netfilter/ipset/ip_set_hash_ipport.c       |  4 +-
 net/netfilter/ipset/ip_set_hash_ipportip.c     |  4 +-
 net/netfilter/ipset/ip_set_hash_ipportnet.c    |  4 +-
 net/netfilter/ipset/ip_set_hash_mac.c          |  4 +-
 net/netfilter/ipset/ip_set_hash_net.c          |  4 +-
 net/netfilter/ipset/ip_set_hash_netiface.c     |  4 +-
 net/netfilter/ipset/ip_set_hash_netnet.c       |  2 +-
 net/netfilter/ipset/ip_set_hash_netport.c      |  4 +-
 net/netfilter/ipset/ip_set_hash_netportnet.c   |  2 +-
 net/netfilter/ipset/ip_set_list_set.c          |  4 +-
 net/netfilter/nf_conntrack_h323_main.c         |  2 +-
 net/netfilter/nf_conntrack_proto_tcp.c         |  2 +-
 net/netfilter/xt_iprange.c                     |  4 +-
 net/netfilter/xt_set.c                         | 45 ++++++------
 34 files changed, 104 insertions(+), 130 deletions(-)
 =20
