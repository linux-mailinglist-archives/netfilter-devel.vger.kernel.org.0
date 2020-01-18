Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 979A51419D3
	for <lists+netfilter-devel@lfdr.de>; Sat, 18 Jan 2020 22:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbgARVXV (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 18 Jan 2020 16:23:21 -0500
Received: from kadath.azazel.net ([81.187.231.250]:55182 "EHLO
        kadath.azazel.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727050AbgARVXU (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 18 Jan 2020 16:23:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
         s=20190108; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=g0qES8VIZMRmjQBNINWBdVXFNmpN4pEbN1niPnx98mk=; b=qXVL3lPSQNJVEd2OupT+e5p+zB
        yx2QNyMkUnVkm2EDbBcLRi3eCKvrzLOl+E2zkT06XX70JVEIg5A2W9bSRlCPJa1K6ez1pHxxzMWPF
        ToGPn3MjpyPURBIUbleVl+BX/DiinPmKF1YAAtn0tecuADI9pMPXrt+J/5JofITPOnvq9vt7Et9D9
        STqf8wbpGSs/TD3KhHVmhA5za4/z3E7iZ9ocW/SI4UVRgnUop7duBnT1ctaPSMhYUmOJ9ABw+4BYq
        anNwwj6kBpExivAncIw81fEDyMG8UD2GNWbKv2khnFi/cDGRU95MAwxbMQxUDL1PWMsAYKT+IYJvc
        e97qXnCg==;
Received: from [2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae] (helo=ulthar.dreamlands)
        by kadath.azazel.net with esmtp (Exim 4.92)
        (envelope-from <jeremy@azazel.net>)
        id 1isvYt-0006Ji-9G
        for netfilter-devel@vger.kernel.org; Sat, 18 Jan 2020 21:23:19 +0000
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: [PATCH nft v2 1/9] Update gitignore.
Date:   Sat, 18 Jan 2020 21:23:11 +0000
Message-Id: <20200118212319.253112-2-jeremy@azazel.net>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200118212319.253112-1-jeremy@azazel.net>
References: <20200118212319.253112-1-jeremy@azazel.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae
X-SA-Exim-Mail-From: jeremy@azazel.net
X-SA-Exim-Scanned: No (on kadath.azazel.net); SAEximRunCond expanded to false
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Add ctags and etags tag files, and Emacs back-up files.

Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
---
 .gitignore | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/.gitignore b/.gitignore
index 2cb1e2afd45c..6b37b1237037 100644
--- a/.gitignore
+++ b/.gitignore
@@ -19,3 +19,12 @@ libtool
 
 # Debian package build temporary files
 build-stamp
+
+# Tag files for Vim and Emacs.
+TAGS
+tags
+
+# Emacs back-up files.
+*~
+\#*\#
+.\#*
-- 
2.24.1

