Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D08E5790B73
	for <lists+netfilter-devel@lfdr.de>; Sun,  3 Sep 2023 12:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236192AbjICKUm (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 3 Sep 2023 06:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235800AbjICKUm (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 3 Sep 2023 06:20:42 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0C20C110
        for <netfilter-devel@vger.kernel.org>; Sun,  3 Sep 2023 03:20:37 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft] doc: describe behaviour of {ip,ip6} length
Date:   Sun,  3 Sep 2023 12:20:32 +0200
Message-Id: <20230903102032.1460673-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This field exposes internal kernel GRO/GSO packet aggregation
implementation details to userspace, provide a hint to the user to
understand better when matching on this field.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 doc/payload-expression.txt | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/doc/payload-expression.txt b/doc/payload-expression.txt
index 06538832ec52..d12a7df78b08 100644
--- a/doc/payload-expression.txt
+++ b/doc/payload-expression.txt
@@ -134,6 +134,14 @@ Destination address |
 ipv4_addr
 |======================
 
+Careful with matching on *ip length*: If GRO/GSO is enabled, then the kernel
+might aggregate several packets into one big packet that is larger than MTU.
+If GRO/GSO maximum size is larger than 65535 (see man ip-link(8), specifically
+gro_ipv6_max_size and gso_ipv6_max_size), then *ip length* might be 0 for such
+jumbo packets.  *meta length* allows you to match on the packet length
+including the IP header size.  If you want to perform heuristics on the
+*ip length* field, then disable GRO/GSO.
+
 ICMP HEADER EXPRESSION
 ~~~~~~~~~~~~~~~~~~~~~~
 [verse]
@@ -244,6 +252,14 @@ Destination address |
 ipv6_addr
 |=======================
 
+Careful with matching on *ip6 length*: If GRO/GSO is enabled, then the kernel
+might aggregate several packets into one big packet that is larger than MTU.
+If GRO/GSO maximum size is larger than 65535 (see man ip-link(8), specifically
+gro_ipv6_max_size and gso_ipv6_max_size), then *ip6 length* might be 0 for such
+jumbo packets.  *meta length* allows you to match on the packet length
+including the IP header size.  If you want to perform heuristics on the
+*ip6 length* field, then disable GRO/GSO.
+
 .Using ip6 header expressions
 -----------------------------
 # matching if first extension header indicates a fragment
-- 
2.30.2

