Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 103A42601D2
	for <lists+netfilter-devel@lfdr.de>; Mon,  7 Sep 2020 19:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731200AbgIGRMk (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 7 Sep 2020 13:12:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:46346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730617AbgIGQc1 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 7 Sep 2020 12:32:27 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 331F92080A;
        Mon,  7 Sep 2020 16:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599496346;
        bh=N2TzsaDDwqM6tAPNhthsqRzY7Ob4UQpx+wDCC0gnkxQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gqoK64BhITZA1wY5V5vAzv/4aQAu/OTImrKxhm3Y8OeJnGGgDpulpMDei8UXcPlHi
         ZqhMsLUYhnefbD/aF28UHZiWhqHISvWMfgPJvK8uUKSmLHUWbdyY5rDhO8iKzsOrZl
         59V0ZZQxlT1URmaLk1PaXBBJpCUJJWGPkZWYNvs0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.8 04/53] netfilter: conntrack: allow sctp hearbeat after connection re-use
Date:   Mon,  7 Sep 2020 12:31:30 -0400
Message-Id: <20200907163220.1280412-4-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200907163220.1280412-1-sashal@kernel.org>
References: <20200907163220.1280412-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: Florian Westphal <fw@strlen.de>

[ Upstream commit cc5453a5b7e90c39f713091a7ebc53c1f87d1700 ]

If an sctp connection gets re-used, heartbeats are flagged as invalid
because their vtag doesn't match.

Handle this in a similar way as TCP conntrack when it suspects that the
endpoints and conntrack are out-of-sync.

When a HEARTBEAT request fails its vtag validation, flag this in the
conntrack state and accept the packet.

When a HEARTBEAT_ACK is received with an invalid vtag in the reverse
direction after we allowed such a HEARTBEAT through, assume we are
out-of-sync and re-set the vtag info.

v2: remove left-over snippet from an older incarnation that moved
    new_state/old_state assignments, thats not needed so keep that
    as-is.

Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/netfilter/nf_conntrack_sctp.h |  2 ++
 net/netfilter/nf_conntrack_proto_sctp.c     | 39 ++++++++++++++++++---
 2 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/include/linux/netfilter/nf_conntrack_sctp.h b/include/linux/netfilter/nf_conntrack_sctp.h
index 9a33f171aa822..625f491b95de8 100644
--- a/include/linux/netfilter/nf_conntrack_sctp.h
+++ b/include/linux/netfilter/nf_conntrack_sctp.h
@@ -9,6 +9,8 @@ struct ip_ct_sctp {
 	enum sctp_conntrack state;
 
 	__be32 vtag[IP_CT_DIR_MAX];
+	u8 last_dir;
+	u8 flags;
 };
 
 #endif /* _NF_CONNTRACK_SCTP_H */
diff --git a/net/netfilter/nf_conntrack_proto_sctp.c b/net/netfilter/nf_conntrack_proto_sctp.c
index 4f897b14b6069..810cca24b3990 100644
--- a/net/netfilter/nf_conntrack_proto_sctp.c
+++ b/net/netfilter/nf_conntrack_proto_sctp.c
@@ -62,6 +62,8 @@ static const unsigned int sctp_timeouts[SCTP_CONNTRACK_MAX] = {
 	[SCTP_CONNTRACK_HEARTBEAT_ACKED]	= 210 SECS,
 };
 
+#define	SCTP_FLAG_HEARTBEAT_VTAG_FAILED	1
+
 #define sNO SCTP_CONNTRACK_NONE
 #define	sCL SCTP_CONNTRACK_CLOSED
 #define	sCW SCTP_CONNTRACK_COOKIE_WAIT
@@ -369,6 +371,7 @@ int nf_conntrack_sctp_packet(struct nf_conn *ct,
 	u_int32_t offset, count;
 	unsigned int *timeouts;
 	unsigned long map[256 / sizeof(unsigned long)] = { 0 };
+	bool ignore = false;
 
 	if (sctp_error(skb, dataoff, state))
 		return -NF_ACCEPT;
@@ -427,15 +430,39 @@ int nf_conntrack_sctp_packet(struct nf_conn *ct,
 			/* Sec 8.5.1 (D) */
 			if (sh->vtag != ct->proto.sctp.vtag[dir])
 				goto out_unlock;
-		} else if (sch->type == SCTP_CID_HEARTBEAT ||
-			   sch->type == SCTP_CID_HEARTBEAT_ACK) {
+		} else if (sch->type == SCTP_CID_HEARTBEAT) {
+			if (ct->proto.sctp.vtag[dir] == 0) {
+				pr_debug("Setting %d vtag %x for dir %d\n", sch->type, sh->vtag, dir);
+				ct->proto.sctp.vtag[dir] = sh->vtag;
+			} else if (sh->vtag != ct->proto.sctp.vtag[dir]) {
+				if (test_bit(SCTP_CID_DATA, map) || ignore)
+					goto out_unlock;
+
+				ct->proto.sctp.flags |= SCTP_FLAG_HEARTBEAT_VTAG_FAILED;
+				ct->proto.sctp.last_dir = dir;
+				ignore = true;
+				continue;
+			} else if (ct->proto.sctp.flags & SCTP_FLAG_HEARTBEAT_VTAG_FAILED) {
+				ct->proto.sctp.flags &= ~SCTP_FLAG_HEARTBEAT_VTAG_FAILED;
+			}
+		} else if (sch->type == SCTP_CID_HEARTBEAT_ACK) {
 			if (ct->proto.sctp.vtag[dir] == 0) {
 				pr_debug("Setting vtag %x for dir %d\n",
 					 sh->vtag, dir);
 				ct->proto.sctp.vtag[dir] = sh->vtag;
 			} else if (sh->vtag != ct->proto.sctp.vtag[dir]) {
-				pr_debug("Verification tag check failed\n");
-				goto out_unlock;
+				if (test_bit(SCTP_CID_DATA, map) || ignore)
+					goto out_unlock;
+
+				if ((ct->proto.sctp.flags & SCTP_FLAG_HEARTBEAT_VTAG_FAILED) == 0 ||
+				    ct->proto.sctp.last_dir == dir)
+					goto out_unlock;
+
+				ct->proto.sctp.flags &= ~SCTP_FLAG_HEARTBEAT_VTAG_FAILED;
+				ct->proto.sctp.vtag[dir] = sh->vtag;
+				ct->proto.sctp.vtag[!dir] = 0;
+			} else if (ct->proto.sctp.flags & SCTP_FLAG_HEARTBEAT_VTAG_FAILED) {
+				ct->proto.sctp.flags &= ~SCTP_FLAG_HEARTBEAT_VTAG_FAILED;
 			}
 		}
 
@@ -470,6 +497,10 @@ int nf_conntrack_sctp_packet(struct nf_conn *ct,
 	}
 	spin_unlock_bh(&ct->lock);
 
+	/* allow but do not refresh timeout */
+	if (ignore)
+		return NF_ACCEPT;
+
 	timeouts = nf_ct_timeout_lookup(ct);
 	if (!timeouts)
 		timeouts = nf_sctp_pernet(nf_ct_net(ct))->timeouts;
-- 
2.25.1

