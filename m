Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2C52AA319
	for <lists+netfilter-devel@lfdr.de>; Sat,  7 Nov 2020 08:56:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727886AbgKGH4D (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 7 Nov 2020 02:56:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727242AbgKGH4D (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 7 Nov 2020 02:56:03 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 778F6C0613D2
        for <netfilter-devel@vger.kernel.org>; Fri,  6 Nov 2020 23:56:01 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id w4so4437482ybq.21
        for <netfilter-devel@vger.kernel.org>; Fri, 06 Nov 2020 23:56:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=jIeEqn8DjifdijUbE9P+939DFnPxPOakX6eDafn0MtI=;
        b=u1aTvZxAXwdIq/SraXXzIVM2gSKJda052aDlbK0HJEZRPF9zOaOKy2HO0eJkSflTgM
         92EHWfBwgrgouazSyT95zgWQczY27gtgrYpJV/Pr47LxGGv/AQTNKP8AYMD9+Kk/MxuZ
         aj2Ijivy27FKXMw9/eY5/LjsubIRHLpTjiSWoTFOHIR32T3DVO+V1LtedCzkokbzV978
         QSf2hkWbHJr/yQsdpRqsNXaCkolRgWNe5FFNA1ss83DJpOla3DETCMQqRRu9YR6Jkmeg
         /gRcmFpjaS+ROnP8LQ11ese5jpHmvFdicRhjDdTD5AUaqevkV8w6jkKWhFgA28FN+pjd
         kzFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=jIeEqn8DjifdijUbE9P+939DFnPxPOakX6eDafn0MtI=;
        b=ZhHzH9bkZ6Ee1WOMd83C/l8P3tqaWBgW3KWVRRCe1S9Y3Lv0O+jFOdUxgBCML7btBj
         43PlQ5Q+ptP22KGAfGMLWZgEXJeGupg5ufVXZqBeBmuFgP6/hq3vO6kE8JrapBr3rZuj
         PmarkpqXSRUoy5NxeZYe3tjQCbrafUGWGeGTeORgjCpd0w6qDJeNMZDmzZ0yfbml4N81
         zZ6qaARz+pZQrypqhnd7qCUvOqmqqHalT+Yt3GQuj91qavYwt2Mb8jwWA+W6TfZYTalL
         3+UN+48OqOu+iawp4Ja8TM0DypavlwYgn1eYZfvz577Yu7K4Dhl3jUrOprfS+9dP8sIK
         1J+w==
X-Gm-Message-State: AOAM531lF1auXmhmwPLiQBPk9QWRBWGEs6RGlrkj1JTbsycoKcmDUrF6
        SUSL40NlvqEvbYGs/1aNrYxIdp3xEa1djm7ob94=
X-Google-Smtp-Source: ABdhPJzR9iuyIm++F87KftDrwL9BVO+hm9aoSe4S8ZbteAFmwgVBnzk+wfReZz0nn6JVHoEo8RCzTot3TWwoyXXRnz0=
Sender: "ndesaulniers via sendgmr" 
        <ndesaulniers@ndesaulniers1.mtv.corp.google.com>
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:4d25])
 (user=ndesaulniers job=sendgmr) by 2002:a25:7811:: with SMTP id
 t17mr7217154ybc.450.1604735760577; Fri, 06 Nov 2020 23:56:00 -0800 (PST)
Date:   Fri,  6 Nov 2020 23:55:50 -0800
Message-Id: <20201107075550.2244055-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
Subject: [PATCH] netfilter: conntrack: fix -Wformat
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Clang is more aggressive about -Wformat warnings when the format flag
specifies a type smaller than the parameter. Fixes 8 instances of:

warning: format specifies type 'unsigned short' but the argument has
type 'int' [-Wformat]

Link: https://github.com/ClangBuiltLinux/linux/issues/378
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 net/netfilter/nf_conntrack_standalone.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/net/netfilter/nf_conntrack_standalone.c b/net/netfilter/nf_conntrack_standalone.c
index 46c5557c1fec..c5aa45c38eb2 100644
--- a/net/netfilter/nf_conntrack_standalone.c
+++ b/net/netfilter/nf_conntrack_standalone.c
@@ -50,38 +50,38 @@ print_tuple(struct seq_file *s, const struct nf_conntrack_tuple *tuple,
 
 	switch (l4proto->l4proto) {
 	case IPPROTO_ICMP:
-		seq_printf(s, "type=%u code=%u id=%u ",
+		seq_printf(s, "type=%u code=%u id=%hu ",
 			   tuple->dst.u.icmp.type,
 			   tuple->dst.u.icmp.code,
-			   ntohs(tuple->src.u.icmp.id));
+			   (__be16)ntohs(tuple->src.u.icmp.id));
 		break;
 	case IPPROTO_TCP:
 		seq_printf(s, "sport=%hu dport=%hu ",
-			   ntohs(tuple->src.u.tcp.port),
-			   ntohs(tuple->dst.u.tcp.port));
+			   (__be16)ntohs(tuple->src.u.tcp.port),
+			   (__be16)ntohs(tuple->dst.u.tcp.port));
 		break;
 	case IPPROTO_UDPLITE:
 	case IPPROTO_UDP:
 		seq_printf(s, "sport=%hu dport=%hu ",
-			   ntohs(tuple->src.u.udp.port),
-			   ntohs(tuple->dst.u.udp.port));
+			   (__be16)ntohs(tuple->src.u.udp.port),
+			   (__be16)ntohs(tuple->dst.u.udp.port));
 
 		break;
 	case IPPROTO_DCCP:
 		seq_printf(s, "sport=%hu dport=%hu ",
-			   ntohs(tuple->src.u.dccp.port),
-			   ntohs(tuple->dst.u.dccp.port));
+			   (__be16)ntohs(tuple->src.u.dccp.port),
+			   (__be16)ntohs(tuple->dst.u.dccp.port));
 		break;
 	case IPPROTO_SCTP:
 		seq_printf(s, "sport=%hu dport=%hu ",
-			   ntohs(tuple->src.u.sctp.port),
-			   ntohs(tuple->dst.u.sctp.port));
+			   (__be16)ntohs(tuple->src.u.sctp.port),
+			   (__be16)ntohs(tuple->dst.u.sctp.port));
 		break;
 	case IPPROTO_ICMPV6:
-		seq_printf(s, "type=%u code=%u id=%u ",
+		seq_printf(s, "type=%u code=%u id=%hu ",
 			   tuple->dst.u.icmp.type,
 			   tuple->dst.u.icmp.code,
-			   ntohs(tuple->src.u.icmp.id));
+			   (__be16)ntohs(tuple->src.u.icmp.id));
 		break;
 	case IPPROTO_GRE:
 		seq_printf(s, "srckey=0x%x dstkey=0x%x ",
-- 
2.29.2.222.g5d2a92d10f8-goog

