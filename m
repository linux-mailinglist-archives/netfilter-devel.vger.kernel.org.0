Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79BEB44F8D3
	for <lists+netfilter-devel@lfdr.de>; Sun, 14 Nov 2021 16:52:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234393AbhKNPzh (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 14 Nov 2021 10:55:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbhKNPzg (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 14 Nov 2021 10:55:36 -0500
Received: from kadath.azazel.net (unknown [IPv6:2001:8b0:135f:bcd1:e0cb:4eff:fedf:e608])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D74BC061766
        for <netfilter-devel@vger.kernel.org>; Sun, 14 Nov 2021 07:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
        s=20190108; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=YJDSq1MJxHJnZOnSwJU9fqNASWGAwk7dqrG5WCKbr5o=; b=AT6L4vyB59Vo0Uo3diR8gmjvaA
        jOTIdBbyQ+p9A9Gjfzqa21Q/VzpaumsuicVb8KzuV2oW3HCUBnWd8Zh3dSq/fmIVeDqWB7PdEEhmJ
        1eLewW1gskVwS6n7zO8FgrH4Qihh+DdGnYX00le1sk8df8yhet9h/mKUJ8eV4EyzV/fA7TyZ16LGm
        EOo86aTndWpjtOn9y4GGaid0/p/dkeihTylDM6FjhXg3ZoVrBrTgGDAA5tc6b8exVYCD0e6idLvqP
        a0t0dfPnmPZayZ/xl4Bg0wtELcfcV8MvJzQ9/SQJgDJEnwQ5jERE6jZDV0gAmAJtDuJTgr6YQgSBr
        76NtGGDw==;
Received: from ulthar.dreamlands.azazel.net ([2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae])
        by kadath.azazel.net with esmtp (Exim 4.94.2)
        (envelope-from <jeremy@azazel.net>)
        id 1mmHo8-00CfJ1-Iu
        for netfilter-devel@vger.kernel.org; Sun, 14 Nov 2021 15:52:40 +0000
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: [ulogd2 PATCH v4 01/15] gitignore: add Emacs artefacts
Date:   Sun, 14 Nov 2021 15:52:17 +0000
Message-Id: <20211114155231.793594-2-jeremy@azazel.net>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211114155231.793594-1-jeremy@azazel.net>
References: <20211114155231.793594-1-jeremy@azazel.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae
X-SA-Exim-Mail-From: jeremy@azazel.net
X-SA-Exim-Scanned: No (on kadath.azazel.net); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
---
 .gitignore | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/.gitignore b/.gitignore
index 0ff56cfe0423..3f218218dfc9 100644
--- a/.gitignore
+++ b/.gitignore
@@ -1,3 +1,6 @@
+*~
+.\#*
+\#*\#
 # global
 *.la
 *.lo
-- 
2.33.0

