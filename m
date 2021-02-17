Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC68131D8B5
	for <lists+netfilter-devel@lfdr.de>; Wed, 17 Feb 2021 12:45:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232289AbhBQLpD (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 17 Feb 2021 06:45:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbhBQLoN (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 17 Feb 2021 06:44:13 -0500
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBBC3C061574
        for <netfilter-devel@vger.kernel.org>; Wed, 17 Feb 2021 03:43:32 -0800 (PST)
Received: from localhost ([::1]:54880 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.94)
        (envelope-from <phil@nwl.cc>)
        id 1lCLEw-0002nr-PF; Wed, 17 Feb 2021 12:43:30 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [nft PATCH] monitor: Don't print newgen message with JSON output
Date:   Wed, 17 Feb 2021 12:43:23 +0100
Message-Id: <20210217114323.25322-1-phil@nwl.cc>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Iff this should be printed, it must adhere to output format settings. In
its current form it breaks JSON syntax, so skip it for non-default
output formats.

Fixes: cb7e02f44d6a6 ("src: enable json echo output when reading native syntax")
Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 src/monitor.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/monitor.c b/src/monitor.c
index af2998d4272b2..047d89db933a4 100644
--- a/src/monitor.c
+++ b/src/monitor.c
@@ -842,6 +842,9 @@ static int netlink_events_newgen_cb(const struct nlmsghdr *nlh, int type,
 	char name[256] = "";
 	int genid = -1, pid = -1;
 
+	if (monh->format != NFTNL_OUTPUT_DEFAULT)
+		return MNL_CB_OK;
+
 	mnl_attr_for_each(attr, nlh, sizeof(struct nfgenmsg)) {
 		switch (mnl_attr_get_type(attr)) {
 		case NFTA_GEN_ID:
-- 
2.28.0

