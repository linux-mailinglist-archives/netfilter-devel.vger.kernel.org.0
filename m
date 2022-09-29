Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 158315EF5EC
	for <lists+netfilter-devel@lfdr.de>; Thu, 29 Sep 2022 15:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235530AbiI2NB3 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 29 Sep 2022 09:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235610AbiI2NBZ (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 29 Sep 2022 09:01:25 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9678214663C
        for <netfilter-devel@vger.kernel.org>; Thu, 29 Sep 2022 06:01:24 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1odtAJ-00031g-0v; Thu, 29 Sep 2022 15:01:23 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nft 1/3] doc: mention vlan matching in ip/ip6/inet families
Date:   Thu, 29 Sep 2022 15:01:11 +0200
Message-Id: <20220929130113.22289-2-fw@strlen.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220929130113.22289-1-fw@strlen.de>
References: <20220929130113.22289-1-fw@strlen.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

It only works if vlan_reorder is turned off to disable the vlan tag
removal.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 doc/payload-expression.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/doc/payload-expression.txt b/doc/payload-expression.txt
index 106ff74ce57e..113f5bfc597c 100644
--- a/doc/payload-expression.txt
+++ b/doc/payload-expression.txt
@@ -23,6 +23,14 @@ VLAN HEADER EXPRESSION
 [verse]
 *vlan* {*id* | *dei* | *pcp* | *type*}
 
+The vlan expression is used to match on the vlan header fields.
+This expression will not work in the *ip*, *ip6* and *inet* families,
+unless the vlan interface is configured with the *reorder_hdr off* setting.
+The default is *reorder_hdr on* which will automatically remove the vlan tag
+from the packet. See ip-link(8) for more information.
+For these families its easier to match the vlan interface name
+instead, using the *meta iif* or *meta iifname* expression.
+
 .VLAN header expression
 [options="header"]
 |==================
-- 
2.35.1

