Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D979244F84A
	for <lists+netfilter-devel@lfdr.de>; Sun, 14 Nov 2021 15:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234137AbhKNOEi (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 14 Nov 2021 09:04:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbhKNOEX (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 14 Nov 2021 09:04:23 -0500
Received: from kadath.azazel.net (unknown [IPv6:2001:8b0:135f:bcd1:e0cb:4eff:fedf:e608])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 758ACC061200
        for <netfilter-devel@vger.kernel.org>; Sun, 14 Nov 2021 06:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
        s=20190108; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=YJDSq1MJxHJnZOnSwJU9fqNASWGAwk7dqrG5WCKbr5o=; b=pZHdPkMG4EDU5Xc8p2VItlTi5c
        hI9oIlyFJvULBEj5IZr3+AGQdKT9D5iZ5dAwIk+e2VMyNE023LHmNk0QGjs9NgVFdApS1TKZhjIyX
        uRjs/tZmsMrIo3xdmHPKkAiyvVhmkenaFl/UGmFZfBZ5KQ/0iVeMsXa4QCogGnX0Z1GD7FA2CcpNA
        S4VhUDrlDsWCjtks3wXt7bCX+s8y4DTJqJdel+9MU0gJg5Wck0g6nmGElC2eEWIj5rZ/QYk17YiqZ
        ZcIWmN+8D/jLDg39102RtfuVBMOz+TJgvTxYcQAs5PdTbMHBDA0hbw6Wu8qOHFAOM12GWwUSho4pU
        RoA42wYw==;
Received: from ulthar.dreamlands.azazel.net ([2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae])
        by kadath.azazel.net with esmtp (Exim 4.94.2)
        (envelope-from <jeremy@azazel.net>)
        id 1mmG4E-00Cdsh-JD
        for netfilter-devel@vger.kernel.org; Sun, 14 Nov 2021 14:01:10 +0000
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: [ulogd2 PATCH v3 01/16] gitignore: add Emacs artefacts
Date:   Sun, 14 Nov 2021 14:00:43 +0000
Message-Id: <20211114140058.752394-2-jeremy@azazel.net>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211114140058.752394-1-jeremy@azazel.net>
References: <20211114140058.752394-1-jeremy@azazel.net>
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

