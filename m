Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D812600D69
	for <lists+netfilter-devel@lfdr.de>; Mon, 17 Oct 2022 13:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbiJQLE2 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 17 Oct 2022 07:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbiJQLEW (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 17 Oct 2022 07:04:22 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A9E86CF1
        for <netfilter-devel@vger.kernel.org>; Mon, 17 Oct 2022 04:04:20 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft,v2 10/16] doc: add gre matching expression
Date:   Mon, 17 Oct 2022 13:04:02 +0200
Message-Id: <20221017110408.742223-11-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221017110408.742223-1-pablo@netfilter.org>
References: <20221017110408.742223-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Document new vxlan matching expression. This includes support for
matching the encapsulated ethernet frame layer 3 and 4 headers.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 doc/payload-expression.txt | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/doc/payload-expression.txt b/doc/payload-expression.txt
index c80198878c1a..86e364713953 100644
--- a/doc/payload-expression.txt
+++ b/doc/payload-expression.txt
@@ -532,6 +532,36 @@ compression Parameter Index |
 integer (16 bit)
 |============================
 
+GRE HEADER EXPRESSION
+~~~~~~~~~~~~~~~~~~~~~~~
+[verse]
+*gre* {*flags* | *version* | *protocol*}
+*gre* *ip* {*version* | *hdrlength* | *dscp* | *ecn* | *length* | *id* | *frag-off* | *ttl* | *protocol* | *checksum* | *saddr* | *daddr* }
+*gre* *ip6* {*version* | *dscp* | *ecn* | *flowlabel* | *length* | *nexthdr* | *hoplimit* | *saddr* | *daddr*}
+
+The gre expression is used to match on the gre header fields. This expression
+also allows to match on the IPv4 or IPv6 packet within the gre header.
+
+.GRE header expression
+[options="header"]
+|==================
+|Keyword| Description| Type
+|flags|
+checksum, routing, key, sequence and strict source route flags|
+integer (5 bit)
+|version|
+gre version field, 0 for GRE and 1 for PPTP|
+integer (3 bit)
+|protocol|
+EtherType of encapsulated packet|
+integer (16 bit)
+|==================
+
+.Matching inner IPv4 destination address encapsulated in gre
+------------------------------------------------------------
+netdev filter ingress gre ip daddr 9.9.9.9 counter
+------------------------------------------------------------
+
 VXLAN HEADER EXPRESSION
 ~~~~~~~~~~~~~~~~~~~~~~~
 [verse]
-- 
2.30.2

