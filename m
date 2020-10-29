Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 392CB29F05F
	for <lists+netfilter-devel@lfdr.de>; Thu, 29 Oct 2020 16:46:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbgJ2Pqy (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 29 Oct 2020 11:46:54 -0400
Received: from smtp-out.kfki.hu ([148.6.0.45]:54991 "EHLO smtp-out.kfki.hu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727966AbgJ2Pqx (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 29 Oct 2020 11:46:53 -0400
X-Greylist: delayed 419 seconds by postgrey-1.27 at vger.kernel.org; Thu, 29 Oct 2020 11:46:52 EDT
Received: from localhost (localhost [127.0.0.1])
        by smtp0.kfki.hu (Postfix) with ESMTP id E4D41674014B;
        Thu, 29 Oct 2020 16:39:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        blackhole.kfki.hu; h=mime-version:x-mailer:message-id:date:date
        :from:from:received:received:received; s=20151130; t=1603985990;
         x=1605800391; bh=dGE8XQW6qkYFLPQq0kVQ2SnBYcbEBo6sEYO7+yOU2cA=; b=
        GaaGnNm75q76kTespH/Hs9DGVXlq8b4PRp7tEz1dnkpDYUlSqjGltlruRaKlFUqW
        mgpSBj1uKVX557deu/sAHuCE0sGEgXERVUW4od9DJoU8u49yQwzwDyvzbzPAgLEq
        dtssn+PTi0ih6YsWwUG8bERZxG8bOkIx7DtKzIBDWKc=
X-Virus-Scanned: Debian amavisd-new at smtp0.kfki.hu
Received: from smtp0.kfki.hu ([127.0.0.1])
        by localhost (smtp0.kfki.hu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP; Thu, 29 Oct 2020 16:39:50 +0100 (CET)
Received: from blackhole.kfki.hu (blackhole.kfki.hu [IPv6:2001:738:5001:1::240:2])
        by smtp0.kfki.hu (Postfix) with ESMTP id DB39367400D9;
        Thu, 29 Oct 2020 16:39:49 +0100 (CET)
Received: by blackhole.kfki.hu (Postfix, from userid 1000)
        id CD485340D5C; Thu, 29 Oct 2020 16:39:49 +0100 (CET)
From:   Jozsef Kadlecsik <kadlec@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 0/4] ipset patches for nf-next
Date:   Thu, 29 Oct 2020 16:39:45 +0100
Message-Id: <20201029153949.6567-1-kadlec@netfilter.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi Pablo,

Please consider to apply the next patches in the nf-next tree:

- Update byte and packet counters regardless of whether they match patch
  from Stefano Brivio. Finally I accepted Stefano's reasoning about updat=
ing
  the counters always.
- Add supporting the -exist flag with the destroy command too. The -exist
  flag was supported with add/del and create only but not with destroy.
  Now it is possible to write restore "scripts" which contains destroy an=
d
  it won't abort when the set to be destroyed does not exist.
- Add the bucketsize parameter to all hash types, which makes possible to=
 limit
  the max bucket size in the hash. Thus one can tune for faster matching =
with
  the price of higher memory footprint.
- Expose the initval hash parameter to userspace: after saving the set, o=
ne
  can now restore exactly the same set content and structure.

Best regards,
Jozsef

The following changes since commit 3cb12d27ff655e57e8efe3486dca2a22f4e305=
78:

  Merge tag 'net-5.10-rc1' of git://git.kernel.org/pub/scm/linux/kernel/g=
it/netdev/net (2020-10-23 12:05:49 -0700)

are available in the Git repository at:

  git://blackhole.kfki.hu/nf-next 17eca1ad71619af37e

for you to fetch changes up to 17eca1ad71619af37e136606fb87f7fc8a6fe8b5:

  netfilter: ipset: Expose the initval hash parameter to userspace (2020-=
10-29 15:50:55 +0100)

----------------------------------------------------------------
Jozsef Kadlecsik (3):
      netfilter: ipset: Support the -exist flag with the destroy command
      netfilter: ipset: Add bucketsize parameter to all hash types
      netfilter: ipset: Expose the initval hash parameter to userspace

Stefano Brivio (1):
      netfilter: ipset: Update byte and packet counters regardless of whe=
ther they match

 include/linux/netfilter/ipset/ip_set.h       |  5 ++++
 include/uapi/linux/netfilter/ipset/ip_set.h  |  6 ++--
 net/netfilter/ipset/ip_set_core.c            |  9 ++++--
 net/netfilter/ipset/ip_set_hash_gen.h        | 45 ++++++++++++++++++----=
------
 net/netfilter/ipset/ip_set_hash_ip.c         |  7 +++--
 net/netfilter/ipset/ip_set_hash_ipmac.c      |  6 ++--
 net/netfilter/ipset/ip_set_hash_ipmark.c     |  7 +++--
 net/netfilter/ipset/ip_set_hash_ipport.c     |  7 +++--
 net/netfilter/ipset/ip_set_hash_ipportip.c   |  7 +++--
 net/netfilter/ipset/ip_set_hash_ipportnet.c  |  7 +++--
 net/netfilter/ipset/ip_set_hash_mac.c        |  6 ++--
 net/netfilter/ipset/ip_set_hash_net.c        |  7 +++--
 net/netfilter/ipset/ip_set_hash_netiface.c   |  7 +++--
 net/netfilter/ipset/ip_set_hash_netnet.c     |  7 +++--
 net/netfilter/ipset/ip_set_hash_netport.c    |  7 +++--
 net/netfilter/ipset/ip_set_hash_netportnet.c |  7 +++--
 16 files changed, 103 insertions(+), 44 deletions(-)
