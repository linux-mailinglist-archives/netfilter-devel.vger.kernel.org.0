Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17768166C9C
	for <lists+netfilter-devel@lfdr.de>; Fri, 21 Feb 2020 03:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729529AbgBUCFV (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 20 Feb 2020 21:05:21 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28033 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729527AbgBUCFV (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 20 Feb 2020 21:05:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582250720;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eJSyZlYCrJ8YxEesS3BRknXSJksR0ZpNLpXKs/wE2RE=;
        b=WDXdbt4cDuSjYbz2YoQdiG4JPXQxgDgVPnk4wzOnhioJ6Gnrv9K6s/Wp5fOhRQwjo4ALsS
        s6dRlJ0pWvdoAw6KIfPIQHYpqKI+u0YUCaKZ+I5w2Q/JkyVsHA2jwodf/UOdWLdHinz4Vj
        cjRH3bzdWHBoVI0ypMUeaqZj3r1D5ss=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-lFTDkk7YO_a41DyBpf_eQA-1; Thu, 20 Feb 2020 21:05:16 -0500
X-MC-Unique: lFTDkk7YO_a41DyBpf_eQA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1355A107ACC5;
        Fri, 21 Feb 2020 02:05:15 +0000 (UTC)
Received: from epycfail.redhat.com (ovpn-200-25.brq.redhat.com [10.40.200.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BF8C760C87;
        Fri, 21 Feb 2020 02:05:13 +0000 (UTC)
From:   Stefano Brivio <sbrivio@redhat.com>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org, Phil Sutter <phil@nwl.cc>
Subject: [PATCH nf 1/2] nft_set_pipapo: Actually fetch key data in nft_pipapo_remove()
Date:   Fri, 21 Feb 2020 03:04:21 +0100
Message-Id: <a14ea089f46cd03d2d2afddc030803894ddf20d1.1582250437.git.sbrivio@redhat.com>
In-Reply-To: <cover.1582250437.git.sbrivio@redhat.com>
References: <cover.1582250437.git.sbrivio@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Phil reports that adding elements, flushing and re-adding them
right away:

  nft add table t '{ set s { type ipv4_addr . inet_service; flags interva=
l; }; }'
  nft add element t s '{ 10.0.0.1 . 22-25, 10.0.0.1 . 10-20 }'
  nft flush set t s
  nft add element t s '{ 10.0.0.1 . 10-20, 10.0.0.1 . 22-25 }'

triggers, almost reliably, a crash like this one:

  [   71.319848] general protection fault, probably for non-canonical add=
ress 0x6f6b6e696c2e756e: 0000 [#1] PREEMPT SMP PTI
  [   71.321540] CPU: 3 PID: 1201 Comm: kworker/3:2 Not tainted 5.6.0-rc1=
-00377-g2bb07f4e1d861 #192
  [   71.322746] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), B=
IOS ?-20190711_202441-buildvm-armv7-10.arm.fedoraproject.org-2.fc31 04/01=
/2014
  [   71.324430] Workqueue: events nf_tables_trans_destroy_work [nf_table=
s]
  [   71.325387] RIP: 0010:nft_set_elem_destroy+0xa5/0x110 [nf_tables]
  [   71.326164] Code: 89 d4 84 c0 74 0e 8b 77 44 0f b6 f8 48 01 df e8 41=
 ff ff ff 45 84 e4 74 36 44 0f b6 63 08 45 84 e4 74 2c 49 01 dc 49 8b 04 =
24 <48> 8b 40 38 48 85 c0 74 4f 48 89 e7 4c 8b
  [   71.328423] RSP: 0018:ffffc9000226fd90 EFLAGS: 00010282
  [   71.329225] RAX: 6f6b6e696c2e756e RBX: ffff88813ab79f60 RCX: ffff888=
13931b5a0
  [   71.330365] RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffff888=
13ab79f9a
  [   71.331473] RBP: ffff88813ab79f60 R08: 0000000000000008 R09: 0000000=
000000000
  [   71.332627] R10: 000000000000021c R11: 0000000000000000 R12: ffff888=
13ab79fc2
  [   71.333615] R13: ffff88813b3adf50 R14: dead000000000100 R15: ffff888=
13931b8a0
  [   71.334596] FS:  0000000000000000(0000) GS:ffff88813bd80000(0000) kn=
lGS:0000000000000000
  [   71.335780] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  [   71.336577] CR2: 000055ac683710f0 CR3: 000000013a222003 CR4: 0000000=
000360ee0
  [   71.337533] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000=
000000000
  [   71.338557] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000=
000000400
  [   71.339718] Call Trace:
  [   71.340093]  nft_pipapo_destroy+0x7a/0x170 [nf_tables_set]
  [   71.340973]  nft_set_destroy+0x20/0x50 [nf_tables]
  [   71.341879]  nf_tables_trans_destroy_work+0x246/0x260 [nf_tables]
  [   71.342916]  process_one_work+0x1d5/0x3c0
  [   71.343601]  worker_thread+0x4a/0x3c0
  [   71.344229]  kthread+0xfb/0x130
  [   71.344780]  ? process_one_work+0x3c0/0x3c0
  [   71.345477]  ? kthread_park+0x90/0x90
  [   71.346129]  ret_from_fork+0x35/0x40
  [   71.346748] Modules linked in: nf_tables_set nf_tables nfnetlink 802=
1q [last unloaded: nfnetlink]
  [   71.348153] ---[ end trace 2eaa8149ca759bcc ]---
  [   71.349066] RIP: 0010:nft_set_elem_destroy+0xa5/0x110 [nf_tables]
  [   71.350016] Code: 89 d4 84 c0 74 0e 8b 77 44 0f b6 f8 48 01 df e8 41=
 ff ff ff 45 84 e4 74 36 44 0f b6 63 08 45 84 e4 74 2c 49 01 dc 49 8b 04 =
24 <48> 8b 40 38 48 85 c0 74 4f 48 89 e7 4c 8b
  [   71.350017] RSP: 0018:ffffc9000226fd90 EFLAGS: 00010282
  [   71.350019] RAX: 6f6b6e696c2e756e RBX: ffff88813ab79f60 RCX: ffff888=
13931b5a0
  [   71.350019] RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffff888=
13ab79f9a
  [   71.350020] RBP: ffff88813ab79f60 R08: 0000000000000008 R09: 0000000=
000000000
  [   71.350021] R10: 000000000000021c R11: 0000000000000000 R12: ffff888=
13ab79fc2
  [   71.350022] R13: ffff88813b3adf50 R14: dead000000000100 R15: ffff888=
13931b8a0
  [   71.350025] FS:  0000000000000000(0000) GS:ffff88813bd80000(0000) kn=
lGS:0000000000000000
  [   71.350026] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  [   71.350027] CR2: 000055ac683710f0 CR3: 000000013a222003 CR4: 0000000=
000360ee0
  [   71.350028] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000=
000000000
  [   71.350028] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000=
000000400
  [   71.350030] Kernel panic - not syncing: Fatal exception
  [   71.350412] Kernel Offset: disabled
  [   71.365922] ---[ end Kernel panic - not syncing: Fatal exception ]--=
-

which is caused by dangling elements that have been deactivated, but
never removed.

On a flush operation, nft_pipapo_walk() walks through all the elements
in the mapping table, which are then deactivated by nft_flush_set(),
one by one, and added to the commit list for removal. Element data is
then freed.

On transaction commit, nft_pipapo_remove() is called, and failed to
remove these elements, leading to the stale references in the mapping.
The first symptom of this, revealed by KASan, is a one-byte
use-after-free in subsequent calls to nft_pipapo_walk(), which is
usually not enough to trigger a panic. When stale elements are used
more heavily, though, such as double-free via nft_pipapo_destroy()
as in Phil's case, the problem becomes more noticeable.

The issue comes from that fact that, on a flush operation,
nft_pipapo_remove() won't get the actual key data via elem->key,
elements to be deleted upon commit won't be found by the lookup via
pipapo_get(), and removal will be skipped. Key data should be fetched
via nft_set_ext_key(), instead.

Reported-by: Phil Sutter <phil@nwl.cc>
Fixes: 3c4287f62044 ("nf_tables: Add set type for arbitrary concatenation=
 of ranges")
Signed-off-by: Stefano Brivio <sbrivio@redhat.com>
---
 net/netfilter/nft_set_pipapo.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/nft_set_pipapo.c b/net/netfilter/nft_set_pipap=
o.c
index feac8553f6d9..4fc0c924ed5d 100644
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -1766,11 +1766,13 @@ static bool pipapo_match_field(struct nft_pipapo_=
field *f,
 static void nft_pipapo_remove(const struct net *net, const struct nft_se=
t *set,
 			      const struct nft_set_elem *elem)
 {
-	const u8 *data =3D (const u8 *)elem->key.val.data;
 	struct nft_pipapo *priv =3D nft_set_priv(set);
 	struct nft_pipapo_match *m =3D priv->clone;
+	struct nft_pipapo_elem *e =3D elem->priv;
 	int rules_f0, first_rule =3D 0;
-	struct nft_pipapo_elem *e;
+	const u8 *data;
+
+	data =3D (const u8 *)nft_set_ext_key(&e->ext);
=20
 	e =3D pipapo_get(net, set, data, 0);
 	if (IS_ERR(e))
--=20
2.25.0

