Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E59EF38C288
	for <lists+netfilter-devel@lfdr.de>; Fri, 21 May 2021 11:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234881AbhEUJFH (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 21 May 2021 05:05:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:47420 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232533AbhEUJFG (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 21 May 2021 05:05:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1621587823; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type;
        bh=6IOycYvFyMfDJ+VKrjavqlm8a0HQ+hu1rNgjg0zaJvw=;
        b=YP21PavL4P6Fz1i64jY/hYRFG0K5YegaWulyiy12MLvbFxGtMcnB2ri8ccdT63DWvzMxiB
        85Jw2fpHufgQiY5eIcOvH5NiTTfWn5lCT60ATbN04n9Tub6eGb0UOE5mhET3oe4ZwZuXCz
        nJf+PRcSFTcSLdc9KUqJUqHlG3h6Wic=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 554E4AACA
        for <netfilter-devel@vger.kernel.org>; Fri, 21 May 2021 09:03:43 +0000 (UTC)
Date:   Fri, 21 May 2021 11:03:42 +0200
From:   Ali Abdallah <ali.abdallah@suse.com>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH] Disable RST seq number check when tcp_be_liberal is greater 1
Message-ID: <20210521090342.vcuwd7nupytqjwt3@Fryzen495>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This patch adds the possibility to disable RST seq number check by
setting tcp_be_liberal to a value greater than 1. The default old
behaviour is kept unchanged.

Signed-off-by: Ali Abdallah <aabdallah@suse.de>
---
 Documentation/networking/nf_conntrack-sysctl.rst | 10 ++++++----
 net/netfilter/nf_conntrack_proto_tcp.c           |  3 ++-
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/Documentation/networking/nf_conntrack-sysctl.rst b/Documentation/networking/nf_conntrack-sysctl.rst
index 11a9b76786cb..cfcc3bbd5dda 100644
--- a/Documentation/networking/nf_conntrack-sysctl.rst
+++ b/Documentation/networking/nf_conntrack-sysctl.rst
@@ -103,12 +103,14 @@ nf_conntrack_max - INTEGER
 	Size of connection tracking table.  Default value is
 	nf_conntrack_buckets value * 4.
 
-nf_conntrack_tcp_be_liberal - BOOLEAN
+nf_conntrack_tcp_be_liberal - INTEGER
 	- 0 - disabled (default)
-	- not 0 - enabled
+        - 1 - RST sequence number check only
+	- greater than 1 - turns off all sequence number/window checks
 
-	Be conservative in what you do, be liberal in what you accept from others.
-	If it's non-zero, we mark only out of window RST segments as INVALID.
+	Be conservative in what you do, be liberal in what you accept from
+	others. If it is set to 1, we mark only out of window RST segments as
+	INVALID. Values greater than 1 disables also RST sequence numbers check.
 
 nf_conntrack_tcp_loose - BOOLEAN
 	- 0 - disabled
diff --git a/net/netfilter/nf_conntrack_proto_tcp.c b/net/netfilter/nf_conntrack_proto_tcp.c
index 34e22416a721..bf4ba89eea6c 100644
--- a/net/netfilter/nf_conntrack_proto_tcp.c
+++ b/net/netfilter/nf_conntrack_proto_tcp.c
@@ -1032,7 +1032,8 @@ int nf_conntrack_tcp_packet(struct nf_conn *ct,
 		if (ct->proto.tcp.seen[!dir].flags & IP_CT_TCP_FLAG_MAXACK_SET) {
 			u32 seq = ntohl(th->seq);
 
-			if (before(seq, ct->proto.tcp.seen[!dir].td_maxack)) {
+			if (before(seq, ct->proto.tcp.seen[!dir].td_maxack) &&
+			    tn->tcp_be_liberal <= 1) {
 				/* Invalid RST  */
 				spin_unlock_bh(&ct->lock);
 				nf_ct_l4proto_log_invalid(skb, ct, "invalid rst");
-- 
2.26.2


