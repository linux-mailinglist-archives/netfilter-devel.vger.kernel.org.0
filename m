Return-Path: <netfilter-devel+bounces-2010-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C7598B35C9
	for <lists+netfilter-devel@lfdr.de>; Fri, 26 Apr 2024 12:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEA9A1C21AB0
	for <lists+netfilter-devel@lfdr.de>; Fri, 26 Apr 2024 10:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F63146D42;
	Fri, 26 Apr 2024 10:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kiW0Z0cQ"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84E714535D;
	Fri, 26 Apr 2024 10:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714128431; cv=none; b=o0MkXFj2BIz9qBNB0iVrgOqRRABpBUo539MNig7tk3oB5eZoC3W/J4XAZrrqgDbxWtFHzEvF30oggOhrqyZ4tB0yo4bn3jesRwu1bkwIN4VrsCftdolVcuQ4cpV1HEmbF4ZkrWQ+RIeIYlWI710pnqkZyahR9jm/vcHpGZvDgaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714128431; c=relaxed/simple;
	bh=GH2bezeza5fhtu1z47o7+tK1nF0tM45eNw6jY53xEPE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SiLYBwxYeIlfLNFJYabrANjp7c1AlzgiUFRRBl8MboaUw6K+ZU/rzDLL7teUvJnTz0Kq0jYi75RLHbtIowNQWDxxAl3u/yI0935gNaPq4Glh9fvybYGkTuLZcmlbTrDbF+1KsBPKoQagIh5xdrckoG5Epx4SHTEAHOPqvFVYlMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kiW0Z0cQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 880CEC4DDFD;
	Fri, 26 Apr 2024 10:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714128431;
	bh=GH2bezeza5fhtu1z47o7+tK1nF0tM45eNw6jY53xEPE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=kiW0Z0cQ7WgJZiEdkBZIJwyIs9FJJWesmJJEaKqH3PUZD+r+8eiASo2bq5QA60sYs
	 fOjDLnkCC3ZMzNkfJvLJyCm7HafCnMGiswi/CvHmRHm1q6DSUzEinXnX+8vZl3Xbjx
	 g68VikuKB0cl5riAY1SxrxfQSRaXpLWiBNrHsIFQz6AhWLKGHy6dJUfObhqZc1pMta
	 hCSFc2e9f/PA+KGf79fXLB91SsVLHQrHfApiFpfGnho67Uv0Kl5cIs+xGWg0wnkD4x
	 h/qb3LpKmoPC8USlaGIJbDPkK9Lc+4PMBnBfJHzudCYhY3uvm3YlM17h9ocXvWXIFf
	 l7Xh7nkjHQx2Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A85C4345F;
	Fri, 26 Apr 2024 10:47:11 +0000 (UTC)
From: Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel.org>
Date: Fri, 26 Apr 2024 12:47:00 +0200
Subject: [PATCH v5 8/8] ax.25: x.25: Remove the now superfluous sentinel
 elements from ctl_table array
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240426-jag-sysctl_remset_net-v5-8-e3b12f6111a6@samsung.com>
References: <20240426-jag-sysctl_remset_net-v5-0-e3b12f6111a6@samsung.com>
In-Reply-To: <20240426-jag-sysctl_remset_net-v5-0-e3b12f6111a6@samsung.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Alexander Aring <alex.aring@gmail.com>, 
 Stefan Schmidt <stefan@datenfreihafen.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, David Ahern <dsahern@kernel.org>, 
 Steffen Klassert <steffen.klassert@secunet.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, Ralf Baechle <ralf@linux-mips.org>, 
 Remi Denis-Courmont <courmisch@gmail.com>, 
 Allison Henderson <allison.henderson@oracle.com>, 
 David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, 
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, 
 Xin Long <lucien.xin@gmail.com>, Wenjia Zhang <wenjia@linux.ibm.com>, 
 Jan Karcher <jaka@linux.ibm.com>, "D. Wythe" <alibuda@linux.alibaba.com>, 
 Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>, 
 Trond Myklebust <trond.myklebust@hammerspace.com>, 
 Anna Schumaker <anna@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
 Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Jon Maloy <jmaloy@redhat.com>, 
 Ying Xue <ying.xue@windriver.com>, Martin Schiller <ms@dev.tdt.de>, 
 Pablo Neira Ayuso <pablo@netfilter.org>, 
 Jozsef Kadlecsik <kadlec@netfilter.org>, Florian Westphal <fw@strlen.de>, 
 Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, 
 Simon Horman <horms@verge.net.au>, Julian Anastasov <ja@ssi.bg>, 
 Joerg Reuter <jreuter@yaina.de>, Luis Chamberlain <mcgrof@kernel.org>, 
 Kees Cook <keescook@chromium.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dccp@vger.kernel.org, linux-wpan@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-hams@vger.kernel.org, linux-rdma@vger.kernel.org, 
 rds-devel@oss.oracle.com, linux-afs@lists.infradead.org, 
 linux-sctp@vger.kernel.org, linux-s390@vger.kernel.org, 
 linux-nfs@vger.kernel.org, tipc-discussion@lists.sourceforge.net, 
 linux-x25@vger.kernel.org, netfilter-devel@vger.kernel.org, 
 coreteam@netfilter.org, bridge@lists.linux.dev, lvs-devel@vger.kernel.org, 
 Joel Granados <j.granados@samsung.com>
X-Mailer: b4 0.13-dev-2d940
X-Developer-Signature: v=1; a=openpgp-sha256; l=3995;
 i=j.granados@samsung.com; h=from:subject:message-id;
 bh=NZnJW6XWgopf75vh1g8TgFTlOj8qaKFukPEjDf1p53c=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGYrhixeiGtr0+3cn50MVCpNJqH3pUbctq+W8
 IALAHu076ZyXYkBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJmK4YsAAoJELqXzVK3
 lkFP14IL/RB8B5qMj08F0htyG3GLjxNGZowNF7f8ASmAGyCEJBAo1dwvrVPbWphTkoN0F4w8+69
 kGbOBFemyxiSB9/sU6hGmwbqBzLWGWVlGYoBQaFXmaXTshdupdmxkKyJAdWuvAvfxfoY/dy0yjJ
 swhEKwIONZVtmBlqZwBj7b7EILpjwK6jH3O/rEjU67bWlKPlu9GHoWb2N20nuaiReoU8StYBPot
 S6MsfjOAcaVqBGdtGdzGjeDbOrib3lAqRV8+iiXNPTG93cN67pyf5t+Np+t4HzhBHah9u3lF5Bw
 Qz9HZLtHnUuiU5ISlS2GpfSxRefL1afrN40+uIOGY8EjEZxZcYROoQ9u9ikf71rd4IXLXW8bTHN
 QeAj9nLYPFNQHiOSK4R6agj9tuJv+oTmvbBGndR9eq+KmjnatqxsdG7+30uFoHbQO+MVnuWW8bl
 3pHTcsCdAFrNme6Mqym7SNGMPypA7b2bPTtnlyRxD2i+c7wV2M/IW2O6hZZLs5XxEyFzDq26WE6
 Tw=
X-Developer-Key: i=j.granados@samsung.com; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for j.granados@samsung.com/default with
 auth_id=70
X-Original-From: Joel Granados <j.granados@samsung.com>
Reply-To: j.granados@samsung.com

From: Joel Granados <j.granados@samsung.com>

This commit comes at the tail end of a greater effort to remove the
empty elements at the end of the ctl_table arrays (sentinels) which will
reduce the overall build time size of the kernel and run time memory
bloat by ~64 bytes per sentinel (further information Link :
https://lore.kernel.org/all/ZO5Yx5JFogGi%2FcBo@bombadil.infradead.org/)

Avoid a buffer overflow when traversing the ctl_table by ensuring that
AX25_MAX_VALUES is the same as the size of ax25_param_table. This is
done with a BUILD_BUG_ON where ax25_param_table is defined and a
CONFIG_AX25_DAMA_SLAVE guard in the unnamed enum definition as well as
in the ax25_dev_device_up and ax25_ds_set_timer functions.

The overflow happened when the sentinel was removed from
ax25_param_table. The sentinel's data element was changed when
CONFIG_AX25_DAMA_SLAVE was undefined. This had no adverse effects as it
still stopped on the sentinel's null procname but needed to be addressed
once the sentinel was removed.

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 include/net/ax25.h         | 2 ++
 net/ax25/ax25_dev.c        | 3 +++
 net/ax25/ax25_ds_timer.c   | 4 ++++
 net/ax25/sysctl_net_ax25.c | 3 +--
 net/x25/sysctl_net_x25.c   | 1 -
 5 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/include/net/ax25.h b/include/net/ax25.h
index 0d939e5aee4e..eb9cee8252c8 100644
--- a/include/net/ax25.h
+++ b/include/net/ax25.h
@@ -139,7 +139,9 @@ enum {
 	AX25_VALUES_N2,		/* Default N2 value */
 	AX25_VALUES_PACLEN,	/* AX.25 MTU */
 	AX25_VALUES_PROTOCOL,	/* Std AX.25, DAMA Slave, DAMA Master */
+#ifdef CONFIG_AX25_DAMA_SLAVE
 	AX25_VALUES_DS_TIMEOUT,	/* DAMA Slave timeout */
+#endif
 	AX25_MAX_VALUES		/* THIS MUST REMAIN THE LAST ENTRY OF THIS LIST */
 };
 
diff --git a/net/ax25/ax25_dev.c b/net/ax25/ax25_dev.c
index c5462486dbca..af547e185a94 100644
--- a/net/ax25/ax25_dev.c
+++ b/net/ax25/ax25_dev.c
@@ -78,7 +78,10 @@ void ax25_dev_device_up(struct net_device *dev)
 	ax25_dev->values[AX25_VALUES_N2]        = AX25_DEF_N2;
 	ax25_dev->values[AX25_VALUES_PACLEN]	= AX25_DEF_PACLEN;
 	ax25_dev->values[AX25_VALUES_PROTOCOL]  = AX25_DEF_PROTOCOL;
+
+#ifdef CONFIG_AX25_DAMA_SLAVE
 	ax25_dev->values[AX25_VALUES_DS_TIMEOUT]= AX25_DEF_DS_TIMEOUT;
+#endif
 
 #if defined(CONFIG_AX25_DAMA_SLAVE) || defined(CONFIG_AX25_DAMA_MASTER)
 	ax25_ds_setup_timer(ax25_dev);
diff --git a/net/ax25/ax25_ds_timer.c b/net/ax25/ax25_ds_timer.c
index c4f8adbf8144..8f385d2a7628 100644
--- a/net/ax25/ax25_ds_timer.c
+++ b/net/ax25/ax25_ds_timer.c
@@ -49,12 +49,16 @@ void ax25_ds_del_timer(ax25_dev *ax25_dev)
 
 void ax25_ds_set_timer(ax25_dev *ax25_dev)
 {
+#ifdef CONFIG_AX25_DAMA_SLAVE
 	if (ax25_dev == NULL)		/* paranoia */
 		return;
 
 	ax25_dev->dama.slave_timeout =
 		msecs_to_jiffies(ax25_dev->values[AX25_VALUES_DS_TIMEOUT]) / 10;
 	mod_timer(&ax25_dev->dama.slave_timer, jiffies + HZ);
+#else
+	return;
+#endif
 }
 
 /*
diff --git a/net/ax25/sysctl_net_ax25.c b/net/ax25/sysctl_net_ax25.c
index db66e11e7fe8..4e593d36d311 100644
--- a/net/ax25/sysctl_net_ax25.c
+++ b/net/ax25/sysctl_net_ax25.c
@@ -141,8 +141,6 @@ static const struct ctl_table ax25_param_table[] = {
 		.extra2		= &max_ds_timeout
 	},
 #endif
-
-	{ }	/* that's all, folks! */
 };
 
 int ax25_register_dev_sysctl(ax25_dev *ax25_dev)
@@ -155,6 +153,7 @@ int ax25_register_dev_sysctl(ax25_dev *ax25_dev)
 	if (!table)
 		return -ENOMEM;
 
+	BUILD_BUG_ON(ARRAY_SIZE(ax25_param_table) != AX25_MAX_VALUES);
 	for (k = 0; k < AX25_MAX_VALUES; k++)
 		table[k].data = &ax25_dev->values[k];
 
diff --git a/net/x25/sysctl_net_x25.c b/net/x25/sysctl_net_x25.c
index e9802afa43d0..643f50874dfe 100644
--- a/net/x25/sysctl_net_x25.c
+++ b/net/x25/sysctl_net_x25.c
@@ -71,7 +71,6 @@ static struct ctl_table x25_table[] = {
 		.mode = 	0644,
 		.proc_handler = proc_dointvec,
 	},
-	{ },
 };
 
 int __init x25_register_sysctl(void)

-- 
2.43.0



