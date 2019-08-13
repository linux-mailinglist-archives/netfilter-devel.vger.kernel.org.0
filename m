Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFA808C0F2
	for <lists+netfilter-devel@lfdr.de>; Tue, 13 Aug 2019 20:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbfHMSnx (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 13 Aug 2019 14:43:53 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:57248 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726094AbfHMSnx (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 13 Aug 2019 14:43:53 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@breakpoint.cc>)
        id 1hxblw-0003g7-4a; Tue, 13 Aug 2019 20:43:52 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nftables 2/4] src: parser: fix parsing of chain priority and policy on bigendian
Date:   Tue, 13 Aug 2019 20:44:07 +0200
Message-Id: <20190813184409.10757-3-fw@strlen.de>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190813184409.10757-1-fw@strlen.de>
References: <20190813184409.10757-1-fw@strlen.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

tests/shell/testcases/flowtable/0001flowtable_0
tests/shell/testcases/nft-f/0008split_tables_0
fail the 'dump compare' on s390x.
The priority (10) turns to 0, and accept turned to drop.

Problem is that '$1' is a 64bit value -- then we pass the address
and import 'int' -- we then get the upper all zero bits.

Use an intermediate value instead.

Fixes: 627c451b2351 ("src: allow variables in the chain priority specification")
Fixes: dba4a9b4b5fe ("src: allow variable in chain policy")
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 src/parser_bison.y | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/src/parser_bison.y b/src/parser_bison.y
index 939b9a8db6d7..406cf54bdeb8 100644
--- a/src/parser_bison.y
+++ b/src/parser_bison.y
@@ -1972,11 +1972,12 @@ extended_prio_name	:	OUT
 extended_prio_spec	:	int_num
 			{
 				struct prio_spec spec = {0};
+				int value = (int)$1;
 
 				spec.expr = constant_expr_alloc(&@$, &integer_type,
 								BYTEORDER_HOST_ENDIAN,
 								sizeof(int) *
-								BITS_PER_BYTE, &$1);
+								BITS_PER_BYTE, &value);
 				$$ = spec;
 			}
 			|	variable_expr
@@ -2052,10 +2053,12 @@ policy_expr		:	variable_expr
 			}
 			|	chain_policy
 			{
+				int value = (int)$1;
+
 				$$ = constant_expr_alloc(&@$, &integer_type,
 							 BYTEORDER_HOST_ENDIAN,
 							 sizeof(int) *
-							 BITS_PER_BYTE, &$1);
+							 BITS_PER_BYTE, &value);
 			}
 			;
 
-- 
2.21.0

