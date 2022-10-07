Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 974CD5F75F8
	for <lists+netfilter-devel@lfdr.de>; Fri,  7 Oct 2022 11:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbiJGJQf (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 7 Oct 2022 05:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbiJGJQU (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 7 Oct 2022 05:16:20 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F3426A287C
        for <netfilter-devel@vger.kernel.org>; Fri,  7 Oct 2022 02:16:18 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next,v3 2/6] netfilter: nft_payload: access ipip payload for inner offset
Date:   Fri,  7 Oct 2022 11:16:10 +0200
Message-Id: <20221007091614.339582-3-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221007091614.339582-1-pablo@netfilter.org>
References: <20221007091614.339582-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

ipip is an special case, transport and inner header offset are set to
the same offset to use the upcoming inner expression for matching on
inner tunnel headers.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
v3: no changes.

 net/netfilter/nft_payload.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/netfilter/nft_payload.c b/net/netfilter/nft_payload.c
index 448e32750fa0..2def75393074 100644
--- a/net/netfilter/nft_payload.c
+++ b/net/netfilter/nft_payload.c
@@ -138,6 +138,9 @@ static int __nft_payload_inner_offset(struct nft_pktinfo *pkt)
 		pkt->inneroff = thoff + offset;
 		}
 		break;
+	case IPPROTO_IPIP:
+		pkt->inneroff = thoff;
+		break;
 	default:
 		return -1;
 	}
-- 
2.30.2

