Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE681D4FE2
	for <lists+netfilter-devel@lfdr.de>; Fri, 15 May 2020 16:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbgEOOEd (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 15 May 2020 10:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726140AbgEOOEd (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 15 May 2020 10:04:33 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A62C061A0C
        for <netfilter-devel@vger.kernel.org>; Fri, 15 May 2020 07:04:33 -0700 (PDT)
Received: from localhost ([::1]:52360 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1jZawx-0006rZ-K1; Fri, 15 May 2020 16:04:31 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH v2 1/2] nfnl_osf: Fix broken conversion to nfnl_query()
Date:   Fri, 15 May 2020 16:03:29 +0200
Message-Id: <20200515140330.13669-2-phil@nwl.cc>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200515140330.13669-1-phil@nwl.cc>
References: <20200515140330.13669-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Due to missing NLM_F_ACK flag in request, nfnetlink code in kernel
didn't create an own ACK message but left it upon subsystem to ACK or
not. Since nfnetlink_osf doesn't ACK by itself, nfnl_query() got stuck
waiting for a reply.

Whoever did the conversion from deprecated nfnl_talk() obviously didn't
even test basic functionality of the tool.

Fixes: 52aa15098ebd6 ("nfnl_osf: Replace deprecated nfnl_talk() by nfnl_query()")
Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 utils/nfnl_osf.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/utils/nfnl_osf.c b/utils/nfnl_osf.c
index 15d531975e11d..922d90ac135b7 100644
--- a/utils/nfnl_osf.c
+++ b/utils/nfnl_osf.c
@@ -378,9 +378,11 @@ static int osf_load_line(char *buffer, int len, int del)
 	memset(buf, 0, sizeof(buf));
 
 	if (del)
-		nfnl_fill_hdr(nfnlssh, nmh, 0, AF_UNSPEC, 0, OSF_MSG_REMOVE, NLM_F_REQUEST);
+		nfnl_fill_hdr(nfnlssh, nmh, 0, AF_UNSPEC, 0, OSF_MSG_REMOVE,
+			      NLM_F_ACK | NLM_F_REQUEST);
 	else
-		nfnl_fill_hdr(nfnlssh, nmh, 0, AF_UNSPEC, 0, OSF_MSG_ADD, NLM_F_REQUEST | NLM_F_CREATE);
+		nfnl_fill_hdr(nfnlssh, nmh, 0, AF_UNSPEC, 0, OSF_MSG_ADD,
+			      NLM_F_ACK | NLM_F_REQUEST | NLM_F_CREATE);
 
 	nfnl_addattr_l(nmh, sizeof(buf), OSF_ATTR_FINGER, &f, sizeof(struct xt_osf_user_finger));
 
-- 
2.26.2

