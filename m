Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE3AEFE0F
	for <lists+netfilter-devel@lfdr.de>; Tue,  5 Nov 2019 14:14:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388925AbfKENOw (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 5 Nov 2019 08:14:52 -0500
Received: from orbyte.nwl.cc ([151.80.46.58]:59442 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388710AbfKENOv (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 5 Nov 2019 08:14:51 -0500
Received: from localhost ([::1]:44300 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1iRyfZ-0005tj-Sg; Tue, 05 Nov 2019 14:14:50 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [nft PATCH] doc: Drop incorrect requirement for nft configs
Date:   Tue,  5 Nov 2019 14:14:39 +0100
Message-Id: <20191105131439.31826-1-phil@nwl.cc>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

The shebang is not needed in files to be used with --file parameter.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 doc/nft.txt | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/doc/nft.txt b/doc/nft.txt
index ed2157638032a..c53327e25833d 100644
--- a/doc/nft.txt
+++ b/doc/nft.txt
@@ -85,8 +85,7 @@ For a full summary of options, run *nft --help*.
 
 *-f*::
 *--file 'filename'*::
-	Read input from 'filename'. If 'filename' is -, read from stdin. +
-	nft scripts must start *#!/usr/sbin/nft -f*
+	Read input from 'filename'. If 'filename' is -, read from stdin.
 
 *-i*::
 *--interactive*::
-- 
2.23.0

