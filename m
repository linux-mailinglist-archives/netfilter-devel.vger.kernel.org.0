Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D756113D578
	for <lists+netfilter-devel@lfdr.de>; Thu, 16 Jan 2020 08:58:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbgAPH6N (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 16 Jan 2020 02:58:13 -0500
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:33110 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726369AbgAPH6N (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 16 Jan 2020 02:58:13 -0500
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1is02e-0003KP-8r; Thu, 16 Jan 2020 08:58:12 +0100
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nf] netfilter: nft_tunnel: ERSPAN_VERSION must not be null
Date:   Thu, 16 Jan 2020 08:58:05 +0100
Message-Id: <20200116075805.28377-1-fw@strlen.de>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Fixes: af308b94a2a4a5 ("netfilter: nf_tables: add tunnel support")
Signed-off-by: Florian Westphal <fw@strlen.de>
---

diff --git a/net/netfilter/nft_tunnel.c b/net/netfilter/nft_tunnel.c
index d89c7c553030..5284fcf16be7 100644
--- a/net/netfilter/nft_tunnel.c
+++ b/net/netfilter/nft_tunnel.c
@@ -266,6 +266,9 @@ static int nft_tunnel_obj_erspan_init(const struct nlattr *attr,
 	if (err < 0)
 		return err;
 
+	if (!tb[NFTA_TUNNEL_KEY_ERSPAN_VERSION])
+		 return -EINVAL;
+
 	version = ntohl(nla_get_be32(tb[NFTA_TUNNEL_KEY_ERSPAN_VERSION]));
 	switch (version) {
 	case ERSPAN_VERSION:
-- 
2.24.1

