Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 469F543E54D
	for <lists+netfilter-devel@lfdr.de>; Thu, 28 Oct 2021 17:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbhJ1Pj7 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 28 Oct 2021 11:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbhJ1Pj7 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 28 Oct 2021 11:39:59 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BBDCC061570
        for <netfilter-devel@vger.kernel.org>; Thu, 28 Oct 2021 08:37:32 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1mg7T7-0003YS-FT; Thu, 28 Oct 2021 17:37:29 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nft] doc: update ct timeout section with the state names
Date:   Thu, 28 Oct 2021 17:37:24 +0200
Message-Id: <20211028153724.9192-1-fw@strlen.de>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

docs are too terse and did not have the list of valid timeout states.
While at it, adjust default stream timeout of udp to 120, this is the
current kernel default.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 doc/stateful-objects.txt | 11 +++++++++++
 src/rule.c               |  2 +-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/doc/stateful-objects.txt b/doc/stateful-objects.txt
index 4972969eb250..e3c79220811f 100644
--- a/doc/stateful-objects.txt
+++ b/doc/stateful-objects.txt
@@ -77,6 +77,17 @@ per ct timeout comment field |
 string
 |=================
 
+tcp connection state names that can have a specific timeout value are:
+
+'close', 'close_wait', 'established', 'fin_wait', 'last_ack', 'retrans', 'syn_recv', 'syn_sent', 'time_wait' and 'unack'.
+
+You can use 'sysctl -a |grep net.netfilter.nf_conntrack_tcp_timeout_' to view and change the system-wide defaults.
+'ct timeout' allows for flow-specific settings, without changing the global timeouts.
+
+For example, tcp port 53 could have much lower settings than other traffic.
+
+udp state names that can have a specific timeout value are 'replied' and 'unreplied'.
+
 .defining and assigning ct timeout policy
 ----------------------------------
 table ip filter {
diff --git a/src/rule.c b/src/rule.c
index c7bc6bcf3496..b1700c40079d 100644
--- a/src/rule.c
+++ b/src/rule.c
@@ -72,7 +72,7 @@ static uint32_t tcp_dflt_timeout[] = {
 
 static uint32_t udp_dflt_timeout[] = {
 	[NFTNL_CTTIMEOUT_UDP_UNREPLIED]		= 30,
-	[NFTNL_CTTIMEOUT_UDP_REPLIED]		= 180,
+	[NFTNL_CTTIMEOUT_UDP_REPLIED]		= 120,
 };
 
 struct timeout_protocol timeout_protocol[IPPROTO_MAX] = {
-- 
2.32.0

