Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75F2652890B
	for <lists+netfilter-devel@lfdr.de>; Mon, 16 May 2022 17:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245419AbiEPPjN (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 16 May 2022 11:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245407AbiEPPjM (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 16 May 2022 11:39:12 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 123C33C721
        for <netfilter-devel@vger.kernel.org>; Mon, 16 May 2022 08:39:09 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1nqcoN-0002Xo-6X; Mon, 16 May 2022 17:39:07 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH conntrack-tools] conntrack: remove -o userspace
Date:   Mon, 16 May 2022 17:39:01 +0200
Message-Id: <20220516153901.173460-1-fw@strlen.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This flag makes life a lot harder because lack of the flag hides
very useful information.  Remove it and always tag events triggered
by userspace flush.

Option is still parsed for backwards compatibility sake.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 conntrack.8     | 2 +-
 src/conntrack.c | 7 +++----
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/conntrack.8 b/conntrack.8
index c3214ee0c886..0db427b7b9ea 100644
--- a/conntrack.8
+++ b/conntrack.8
@@ -114,7 +114,7 @@ Load entries from a given file. To read from stdin, "\-" should be specified.
 Atomically zero counters after reading them.  This option is only valid in
 combination with the "\-L, \-\-dump" command options.
 .TP
-.BI "-o, --output [extended,xml,save,timestamp,id,ktimestamp,labels,userspace] "
+.BI "-o, --output [extended,xml,save,timestamp,id,ktimestamp,labels] "
 Display output in a certain format. With the extended output option, this tool
 displays the layer 3 information. With ktimestamp, it displays the in-kernel
 timestamp available since 2.6.38 (you can enable it via the \fBsysctl(8)\fP
diff --git a/src/conntrack.c b/src/conntrack.c
index a77354344290..bd02b139dc97 100644
--- a/src/conntrack.c
+++ b/src/conntrack.c
@@ -1128,8 +1128,7 @@ enum {
 	_O_ID	= (1 << 3),
 	_O_KTMS	= (1 << 4),
 	_O_CL	= (1 << 5),
-	_O_US	= (1 << 6),
-	_O_SAVE	= (1 << 7),
+	_O_SAVE	= (1 << 6),
 };
 
 enum {
@@ -1149,7 +1148,7 @@ static struct parse_parameter {
 	{ {"ALL", "NEW", "UPDATES", "DESTROY"}, 4,
 	  { CT_EVENT_F_ALL, CT_EVENT_F_NEW, CT_EVENT_F_UPD, CT_EVENT_F_DEL } },
 	{ {"xml", "extended", "timestamp", "id", "ktimestamp", "labels", "userspace", "save"}, 8,
-	  { _O_XML, _O_EXT, _O_TMS, _O_ID, _O_KTMS, _O_CL, _O_US, _O_SAVE },
+	  { _O_XML, _O_EXT, _O_TMS, _O_ID, _O_KTMS, _O_CL, 0, _O_SAVE },
 	},
 };
 
@@ -1978,7 +1977,7 @@ static int event_cb(const struct nlmsghdr *nlh, void *data)
 
 	nfct_snprintf_labels(buf, sizeof(buf), ct, type, op_type, op_flags, labelmap);
 done:
-	if ((output_mask & _O_US) && nlh->nlmsg_pid) {
+	if (nlh->nlmsg_pid) {
 		char *prog = get_progname(nlh->nlmsg_pid);
 
 		if (prog)
-- 
2.35.3

