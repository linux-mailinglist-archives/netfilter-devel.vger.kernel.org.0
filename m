Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED5E5F5CC8
	for <lists+netfilter-devel@lfdr.de>; Thu,  6 Oct 2022 00:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbiJEWhq (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 5 Oct 2022 18:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiJEWhq (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 5 Oct 2022 18:37:46 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A049663F0E
        for <netfilter-devel@vger.kernel.org>; Wed,  5 Oct 2022 15:37:45 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next,v2 2/6] netfilter: nft_payload: access ipip payload for inner offset
Date:   Thu,  6 Oct 2022 00:37:36 +0200
Message-Id: <20221005223740.22991-3-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221005223740.22991-1-pablo@netfilter.org>
References: <20221005223740.22991-1-pablo@netfilter.org>
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
v2: no changes

 net/netfilter/nft_payload.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/netfilter/nft_payload.c b/net/netfilter/nft_payload.c
index 78a393d6a7c8..daf336331620 100644
--- a/net/netfilter/nft_payload.c
+++ b/net/netfilter/nft_payload.c
@@ -122,6 +122,9 @@ static int __nft_payload_inner_offset(struct nft_pktinfo *pkt)
 		pkt->inneroff = thoff + sizeof(struct gre_base_hdr) + offset;
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

