Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9392CC880
	for <lists+netfilter-devel@lfdr.de>; Wed,  2 Dec 2020 21:58:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388569AbgLBU55 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 2 Dec 2020 15:57:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388561AbgLBU55 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 2 Dec 2020 15:57:57 -0500
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC43C061A56
        for <netfilter-devel@vger.kernel.org>; Wed,  2 Dec 2020 12:56:21 -0800 (PST)
Received: from localhost ([::1]:47156 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.94)
        (envelope-from <phil@nwl.cc>)
        id 1kkZAi-0006FQ-7A; Wed, 02 Dec 2020 21:56:20 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [nft PATCH] doc: Document 'dccp type' match
Date:   Wed,  2 Dec 2020 21:56:16 +0100
Message-Id: <20201202205616.24399-1-phil@nwl.cc>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Add a description of dccp_pkttype and extend DCCP header expression
synopsis by the 'type' argument.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 doc/data-types.txt         | 44 ++++++++++++++++++++++++++++++++++++++
 doc/payload-expression.txt |  5 ++++-
 2 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/doc/data-types.txt b/doc/data-types.txt
index a42a55fae9534..0f049c044e9fc 100644
--- a/doc/data-types.txt
+++ b/doc/data-types.txt
@@ -492,3 +492,47 @@ For each of the types above, keywords are available for convenience:
 |==================
 
 Possible keywords for conntrack label type (ct_label) are read at runtime from /etc/connlabel.conf.
+
+DCCP PKTTYPE TYPE
+~~~~~~~~~~~~~~~~
+[options="header"]
+|==================
+|Name | Keyword | Size | Base type
+|DCCP packet type |
+dccp_pkttype |
+4 bit |
+integer
+|===================
+
+The DCCP packet type abstracts the different legal values of the respective
+four bit field in the DCCP header, as stated by RFC4340. Note that possible
+values 10-15 are considered reserved and therefore not allowed to be used. In
+iptables' *dccp* match, these values are aliased 'INVALID'. With nftables, one
+may simply match on the numeric value range, i.e. *10-15*.
+
+.keywords may be used when specifying the DCCP packet type
+[options="header"]
+|==================
+|Keyword |Value
+|request|
+0
+|response|
+1
+|data|
+2
+|ack|
+3
+|dataack|
+4
+|closereq|
+5
+|close|
+6
+|reset|
+7
+|sync|
+8
+|syncack|
+9
+|=================
+
diff --git a/doc/payload-expression.txt b/doc/payload-expression.txt
index ffd1b671637a9..a593e2e7b947d 100644
--- a/doc/payload-expression.txt
+++ b/doc/payload-expression.txt
@@ -392,7 +392,7 @@ integer (32 bit)
 DCCP HEADER EXPRESSION
 ~~~~~~~~~~~~~~~~~~~~~~
 [verse]
-*dccp* {*sport* | *dport*}
+*dccp* {*sport* | *dport* | *type*}
 
 .DCCP header expression
 [options="header"]
@@ -404,6 +404,9 @@ inet_service
 |dport|
 Destination port|
 inet_service
+|type|
+Packet type|
+dccp_pkttype
 |========================
 
 AUTHENTICATION HEADER EXPRESSION
-- 
2.28.0

