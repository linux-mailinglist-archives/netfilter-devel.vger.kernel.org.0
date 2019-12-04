Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F55A112C53
	for <lists+netfilter-devel@lfdr.de>; Wed,  4 Dec 2019 14:09:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbfLDNJc (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 4 Dec 2019 08:09:32 -0500
Received: from orbyte.nwl.cc ([151.80.46.58]:58444 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726215AbfLDNJc (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 4 Dec 2019 08:09:32 -0500
Received: from localhost ([::1]:43302 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1icUPK-0007nQ-8n; Wed, 04 Dec 2019 14:09:30 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH] extensions: CLUSTERIP: Mark as deprecated in man page
Date:   Wed,  4 Dec 2019 14:09:21 +0100
Message-Id: <20191204130921.2914-1-phil@nwl.cc>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Kernel even warns if being used, reflect its state in man page, too.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 extensions/libipt_CLUSTERIP.man | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/extensions/libipt_CLUSTERIP.man b/extensions/libipt_CLUSTERIP.man
index 8ec6d6b6e163d..768bb23e5a7ac 100644
--- a/extensions/libipt_CLUSTERIP.man
+++ b/extensions/libipt_CLUSTERIP.man
@@ -2,6 +2,9 @@ This module allows you to configure a simple cluster of nodes that share
 a certain IP and MAC address without an explicit load balancer in front of
 them.  Connections are statically distributed between the nodes in this
 cluster.
+.PP
+Please note that CLUSTERIP target is considered deprecated in favour of cluster
+match which is more flexible and not limited to IPv4.
 .TP
 \fB\-\-new\fP
 Create a new ClusterIP.  You always have to set this on the first rule
-- 
2.24.0

