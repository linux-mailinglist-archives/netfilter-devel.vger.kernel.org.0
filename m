Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35BA3243DFA
	for <lists+netfilter-devel@lfdr.de>; Thu, 13 Aug 2020 19:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgHMRGv (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 13 Aug 2020 13:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgHMRGu (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 13 Aug 2020 13:06:50 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E01C061757
        for <netfilter-devel@vger.kernel.org>; Thu, 13 Aug 2020 10:06:50 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1k6Ggj-0002oI-1A; Thu, 13 Aug 2020 19:06:49 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH lnf-conntrack] conntrack: sctp: update states
Date:   Thu, 13 Aug 2020 19:06:30 +0200
Message-Id: <20200813170630.22987-1-fw@strlen.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

with more recent kernels "conntrack -L" prints NONE instead of
HEARTBEAT_SENT/RECEIVED because the state is unknown in userspace.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 include/libnetfilter_conntrack/libnetfilter_conntrack_sctp.h | 2 ++
 src/conntrack/snprintf.c                                     | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/include/libnetfilter_conntrack/libnetfilter_conntrack_sctp.h b/include/libnetfilter_conntrack/libnetfilter_conntrack_sctp.h
index 192125928fd8..4982066e7eb0 100644
--- a/include/libnetfilter_conntrack/libnetfilter_conntrack_sctp.h
+++ b/include/libnetfilter_conntrack/libnetfilter_conntrack_sctp.h
@@ -14,6 +14,8 @@ enum sctp_state {
 	SCTP_CONNTRACK_SHUTDOWN_SENT,
 	SCTP_CONNTRACK_SHUTDOWN_RECD,
 	SCTP_CONNTRACK_SHUTDOWN_ACK_SENT,
+	SCTP_CONNTRACK_HEARTBEAT_SENT,
+	SCTP_CONNTRACK_HEARTBEAT_ACKED,
 	SCTP_CONNTRACK_MAX
 };
 
diff --git a/src/conntrack/snprintf.c b/src/conntrack/snprintf.c
index 17ad88506eae..ac0105518163 100644
--- a/src/conntrack/snprintf.c
+++ b/src/conntrack/snprintf.c
@@ -48,6 +48,8 @@ const char *const sctp_states[SCTP_CONNTRACK_MAX] = {
 	[SCTP_CONNTRACK_SHUTDOWN_SENT]	= "SHUTDOWN_SENT",
 	[SCTP_CONNTRACK_SHUTDOWN_RECD]	= "SHUTDOWN_RECD",
 	[SCTP_CONNTRACK_SHUTDOWN_ACK_SENT] = "SHUTDOWN_ACK_SENT",
+	[SCTP_CONNTRACK_HEARTBEAT_SENT] = "HEARTBEAT_SENT",
+	[SCTP_CONNTRACK_HEARTBEAT_ACKED]  = "HEARTBEAT_ACKED",
 };
 
 const char *const dccp_states[DCCP_CONNTRACK_MAX] = {
-- 
2.26.2

