Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6231E3AB7B8
	for <lists+netfilter-devel@lfdr.de>; Thu, 17 Jun 2021 17:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233364AbhFQPnV (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 17 Jun 2021 11:43:21 -0400
Received: from mail.netfilter.org ([217.70.188.207]:48454 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232579AbhFQPnV (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 17 Jun 2021 11:43:21 -0400
Received: from localhost.localdomain (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id CE0AE6424D
        for <netfilter-devel@vger.kernel.org>; Thu, 17 Jun 2021 17:39:52 +0200 (CEST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft] parser_bison: memleak in osf flags
Date:   Thu, 17 Jun 2021 17:41:09 +0200
Message-Id: <20210617154109.1722-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Release osf string flag after processing.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/parser_bison.y | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/parser_bison.y b/src/parser_bison.y
index bd2232a3de27..5e702a054f44 100644
--- a/src/parser_bison.y
+++ b/src/parser_bison.y
@@ -4032,8 +4032,10 @@ osf_ttl			:	/* empty */
 				else {
 					erec_queue(error(&@2, "invalid ttl option"),
 						   state->msgs);
+					xfree($2);
 					YYERROR;
 				}
+				xfree($2);
 			}
 			;
 
-- 
2.20.1

