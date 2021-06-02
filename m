Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45AA2398E7C
	for <lists+netfilter-devel@lfdr.de>; Wed,  2 Jun 2021 17:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbhFBPZs (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 2 Jun 2021 11:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbhFBPZs (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 2 Jun 2021 11:25:48 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BACEC061574
        for <netfilter-devel@vger.kernel.org>; Wed,  2 Jun 2021 08:24:04 -0700 (PDT)
Received: from localhost ([::1]:43074 helo=xic)
        by orbyte.nwl.cc with esmtp (Exim 4.94.2)
        (envelope-from <phil@nwl.cc>)
        id 1loSiv-0007Nc-3v; Wed, 02 Jun 2021 17:24:01 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH 6/9] iptables-apply: Drop unused variable
Date:   Wed,  2 Jun 2021 17:24:00 +0200
Message-Id: <20210602152403.5689-7-phil@nwl.cc>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602152403.5689-1-phil@nwl.cc>
References: <20210602152403.5689-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

It was assigned to but never read.

Fixes: b45b4e3903414 ("iptables-apply: script and manpage update")
Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 iptables/iptables-apply | 1 -
 1 file changed, 1 deletion(-)

diff --git a/iptables/iptables-apply b/iptables/iptables-apply
index 4683b1b402d08..3a7df5e3cbc1f 100755
--- a/iptables/iptables-apply
+++ b/iptables/iptables-apply
@@ -231,7 +231,6 @@ case "$MODE" in
 		"$RUNCMD" &
 		CMD_PID=$!
 		( sleep "$TIMEOUT"; kill "$CMD_PID" 2>/dev/null; exit 0 ) &
-		CMDTIMEOUT_PID=$!
 		if ! wait "$CMD_PID"; then
 			echo "failed."
 			echo "Error: unknown error running command: $RUNCMD" >&2
-- 
2.31.1

