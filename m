Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1389C142095
	for <lists+netfilter-devel@lfdr.de>; Sun, 19 Jan 2020 23:57:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728898AbgASW5L (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 19 Jan 2020 17:57:11 -0500
Received: from kadath.azazel.net ([81.187.231.250]:56576 "EHLO
        kadath.azazel.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728831AbgASW5L (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 19 Jan 2020 17:57:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
         s=20190108; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=g0qES8VIZMRmjQBNINWBdVXFNmpN4pEbN1niPnx98mk=; b=bYHwH09VVw/GhEUlnXOrR94lBX
        aln1ZSY6qz1YUDWr+oUKja2aAuLACylZDbw53gNsw5RgcVwoxy4kYKmq7CICvvXkRrBNMIuQ7ytaA
        oFil5Rn54m7nwhwJwqoaWTuz8L14WZvHJAI7gNk8jn/JDUKZu6GgUt7CgiY10TLx24ngANGFfS9Cl
        53TQHAnqQF3i1TPPsP30AFKWUwXb6wDByxDvXL19XH9sj5aFttAKJxT4J/dQ4+r1vjMBZvOLuxP+V
        +DNq4h0gHgUGC6iupRK4+G4XE5EEj5i+HY1fNxcK5IDvftOBuiEv3u9kMFv7abhJD/cCcWDjCF+JV
        6gJFwP4g==;
Received: from [2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae] (helo=ulthar.dreamlands)
        by kadath.azazel.net with esmtp (Exim 4.92)
        (envelope-from <jeremy@azazel.net>)
        id 1itJVG-0006wh-JC
        for netfilter-devel@vger.kernel.org; Sun, 19 Jan 2020 22:57:10 +0000
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: [PATCH nft v3 1/9] Update gitignore.
Date:   Sun, 19 Jan 2020 22:57:02 +0000
Message-Id: <20200119225710.222976-2-jeremy@azazel.net>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200119225710.222976-1-jeremy@azazel.net>
References: <20200119225710.222976-1-jeremy@azazel.net>
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

