Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9B332FFFF
	for <lists+netfilter-devel@lfdr.de>; Sun,  7 Mar 2021 10:57:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbhCGJ5N (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 7 Mar 2021 04:57:13 -0500
Received: from zucker.schokokeks.org ([178.63.68.96]:54637 "EHLO
        zucker.schokokeks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbhCGJ4k (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 7 Mar 2021 04:56:40 -0500
Received: from blood-stain-child.wan.ruderich.org (localhost [::1])
  (AUTH: PLAIN simon@ruderich.org, TLS: TLSv1.3,256bits,TLS_AES_256_GCM_SHA384)
  by zucker.schokokeks.org with ESMTPSA
  id 0000000000000110.000000006044A229.000068BB; Sun, 07 Mar 2021 10:51:37 +0100
From:   Simon Ruderich <simon@ruderich.org>
To:     simon@ruderich.org, netfilter-devel@vger.kernel.org
Subject: [PATCH 1/3] doc: add * to include example to actually include files
Date:   Sun,  7 Mar 2021 10:51:34 +0100
Message-Id: <209ab0d3cbd52520edfc45b7260c5e4a6d10c68c.1615108958.git.simon@ruderich.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1615108958.git.simon@ruderich.org>
References: <cover.1615108958.git.simon@ruderich.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mime-Autoconverted: from 8bit to 7bit by courier 1.0
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

"/etc/firewall/rules/" causes no error but also doesn't include any
files contained in the directory.

Signed-off-by: Simon Ruderich <simon@ruderich.org>
---
 doc/nft.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/nft.txt b/doc/nft.txt
index 32261e26..e4f32179 100644
--- a/doc/nft.txt
+++ b/doc/nft.txt
@@ -153,7 +153,7 @@ directory via the *-h*/*--help* option. +
 Include statements support the usual shell wildcard symbols (*,?,[]). Having no
 matches for an include statement is not an error, if wildcard symbols are used
 in the include statement. This allows having potentially empty include
-directories for statements like **include "/etc/firewall/rules/"**. The wildcard
+directories for statements like **include "/etc/firewall/rules/*"**. The wildcard
 matches are loaded in alphabetical order. Files beginning with dot (.) are not
 matched by include statements.
 
-- 
2.30.1

