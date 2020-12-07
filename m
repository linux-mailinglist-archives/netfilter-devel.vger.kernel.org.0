Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA962D114A
	for <lists+netfilter-devel@lfdr.de>; Mon,  7 Dec 2020 14:04:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725966AbgLGNDt (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 7 Dec 2020 08:03:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbgLGNDs (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 7 Dec 2020 08:03:48 -0500
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99459C0613D0
        for <netfilter-devel@vger.kernel.org>; Mon,  7 Dec 2020 05:03:08 -0800 (PST)
Received: from localhost ([::1]:60542 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.94)
        (envelope-from <phil@nwl.cc>)
        id 1kmGAU-0000Qe-UU; Mon, 07 Dec 2020 14:03:06 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Steffen Klassert <steffen.klassert@secunet.com>
Cc:     linux-crypto@vger.kernel.org, netfilter-devel@vger.kernel.org,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>
Subject: [PATCH] xfrm: interface: Don't hide plain packets from netfilter
Date:   Mon,  7 Dec 2020 14:03:03 +0100
Message-Id: <20201207130303.30774-1-phil@nwl.cc>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

With an IPsec tunnel without dedicated interface, netfilter sees locally
generated packets twice as they exit the physical interface: Once as "the
inner packet" with IPsec context attached and once as the encrypted
(ESP) packet.

With xfrm_interface, the inner packet did not traverse NF_INET_LOCAL_OUT
hook anymore, making it impossible to match on both inner header values
and associated IPsec data from that hook.

Fix this by looping packets transmitted from xfrm_interface through
NF_INET_LOCAL_OUT before passing them on to dst_output(), which makes
behaviour consistent again from netfilter's point of view.

Fixes: f203b76d78092 ("xfrm: Add virtual xfrm interfaces")
Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 net/xfrm/xfrm_interface.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_interface.c b/net/xfrm/xfrm_interface.c
index aa4cdcf69d471..24af61c95b4d4 100644
--- a/net/xfrm/xfrm_interface.c
+++ b/net/xfrm/xfrm_interface.c
@@ -317,7 +317,8 @@ xfrmi_xmit2(struct sk_buff *skb, struct net_device *dev, struct flowi *fl)
 	skb_dst_set(skb, dst);
 	skb->dev = tdev;
 
-	err = dst_output(xi->net, skb->sk, skb);
+	err = NF_HOOK(skb_dst(skb)->ops->family, NF_INET_LOCAL_OUT, xi->net,
+		      skb->sk, skb, NULL, skb_dst(skb)->dev, dst_output);
 	if (net_xmit_eval(err) == 0) {
 		struct pcpu_sw_netstats *tstats = this_cpu_ptr(dev->tstats);
 
-- 
2.28.0

