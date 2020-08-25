Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB2102523E4
	for <lists+netfilter-devel@lfdr.de>; Wed, 26 Aug 2020 00:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbgHYW4N (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 25 Aug 2020 18:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726471AbgHYW4N (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 25 Aug 2020 18:56:13 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89BF9C061574
        for <netfilter-devel@vger.kernel.org>; Tue, 25 Aug 2020 15:56:12 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1kAhrM-00066z-P4; Wed, 26 Aug 2020 00:56:09 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH lnf-conntrack] include: add CTA_STATS_CLASH_RESOLVE
Date:   Wed, 26 Aug 2020 00:56:01 +0200
Message-Id: <20200825225601.8860-1-fw@strlen.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 include/libnetfilter_conntrack/linux_nfnetlink_conntrack.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/libnetfilter_conntrack/linux_nfnetlink_conntrack.h b/include/libnetfilter_conntrack/linux_nfnetlink_conntrack.h
index aa45723138db..0e9af6c1ebd7 100644
--- a/include/libnetfilter_conntrack/linux_nfnetlink_conntrack.h
+++ b/include/libnetfilter_conntrack/linux_nfnetlink_conntrack.h
@@ -255,6 +255,7 @@ enum ctattr_stats_cpu {
 	CTA_STATS_EARLY_DROP,
 	CTA_STATS_ERROR,
 	CTA_STATS_SEARCH_RESTART,
+	CTA_STATS_CLASH_RESOLVE,
 	__CTA_STATS_MAX,
 };
 #define CTA_STATS_MAX (__CTA_STATS_MAX - 1)
-- 
2.26.2

