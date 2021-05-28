Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9A50393F0D
	for <lists+netfilter-devel@lfdr.de>; Fri, 28 May 2021 10:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236074AbhE1I6l (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 28 May 2021 04:58:41 -0400
Received: from host.78.145.23.62.rev.coltfrance.com ([62.23.145.78]:58730 "EHLO
        proxy.6wind.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S236076AbhE1I6k (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 28 May 2021 04:58:40 -0400
X-Greylist: delayed 467 seconds by postgrey-1.27 at vger.kernel.org; Fri, 28 May 2021 04:58:39 EDT
Received: from bretzel (unknown [10.16.0.57])
        by proxy.6wind.com (Postfix) with ESMTPS id EAEC39C22F0;
        Fri, 28 May 2021 10:49:05 +0200 (CEST)
Received: from dichtel by bretzel with local (Exim 4.92)
        (envelope-from <dichtel@6wind.com>)
        id 1lmYAz-0004yo-Ta; Fri, 28 May 2021 10:49:05 +0200
From:   Nicolas Dichtel <nicolas.dichtel@6wind.com>
To:     pablo@netfilter.org
Cc:     netfilter-devel@vger.kernel.org,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Arturo Borrero Gonzalez <arturo@netfilter.org>
Subject: [PATCH nf] MAINTAINERS: netfilter: add irc channel
Date:   Fri, 28 May 2021 10:48:49 +0200
Message-Id: <20210528084849.19058-1-nicolas.dichtel@6wind.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

The community #netfilter IRC channel is now live on the libera.chat network
(https://libera.chat/).

CC: Arturo Borrero Gonzalez <arturo@netfilter.org>
Link: https://marc.info/?l=netfilter&m=162210948632717
Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1d834bebf469..d9c7f8b5cae2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12649,6 +12649,7 @@ W:	http://www.netfilter.org/
 W:	http://www.iptables.org/
 W:	http://www.nftables.org/
 Q:	http://patchwork.ozlabs.org/project/netfilter-devel/list/
+C:	irc://irc.libera.chat/netfilter
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pablo/nf.git
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pablo/nf-next.git
 F:	include/linux/netfilter*
-- 
2.30.0

