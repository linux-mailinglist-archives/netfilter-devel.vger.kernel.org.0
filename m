Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE167331078
	for <lists+netfilter-devel@lfdr.de>; Mon,  8 Mar 2021 15:12:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbhCHOLw (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 8 Mar 2021 09:11:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbhCHOLk (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 8 Mar 2021 09:11:40 -0500
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A31C06174A
        for <netfilter-devel@vger.kernel.org>; Mon,  8 Mar 2021 06:11:40 -0800 (PST)
Received: from localhost ([::1]:53490 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.94)
        (envelope-from <phil@nwl.cc>)
        id 1lJGbi-0003Rn-UR; Mon, 08 Mar 2021 15:11:38 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [libnftnl PATCH 5/5] expr: data_reg: Reduce indenting level a bit
Date:   Mon,  8 Mar 2021 15:11:19 +0100
Message-Id: <20210308141119.17809-6-phil@nwl.cc>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210308141119.17809-1-phil@nwl.cc>
References: <20210308141119.17809-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Given there's only a single valid output_format left, catch other values
early to help a bit with those calls to overlong function names.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 src/expr/data_reg.c | 31 ++++++++-----------------------
 1 file changed, 8 insertions(+), 23 deletions(-)

diff --git a/src/expr/data_reg.c b/src/expr/data_reg.c
index d3ccc612ce812..60dc9b81cb4d3 100644
--- a/src/expr/data_reg.c
+++ b/src/expr/data_reg.c
@@ -66,35 +66,20 @@ int nftnl_data_reg_snprintf(char *buf, size_t size,
 			    uint32_t output_format, uint32_t flags,
 			    int reg_type)
 {
+	if (output_format != NFTNL_OUTPUT_DEFAULT)
+		return -1;
+
 	switch(reg_type) {
 	case DATA_VALUE:
-		switch(output_format) {
-		case NFTNL_OUTPUT_DEFAULT:
-			return nftnl_data_reg_value_snprintf_default(buf, size,
-								   reg, flags);
-		case NFTNL_OUTPUT_JSON:
-		case NFTNL_OUTPUT_XML:
-		default:
-			break;
-		}
-		break;
+		return nftnl_data_reg_value_snprintf_default(buf, size, reg,
+							     flags);
 	case DATA_VERDICT:
 	case DATA_CHAIN:
-		switch(output_format) {
-		case NFTNL_OUTPUT_DEFAULT:
-			return nftnl_data_reg_verdict_snprintf_def(buf, size,
-								 reg, flags);
-		case NFTNL_OUTPUT_JSON:
-		case NFTNL_OUTPUT_XML:
-		default:
-			break;
-		}
-		break;
+		return nftnl_data_reg_verdict_snprintf_def(buf, size, reg,
+							   flags);
 	default:
-		break;
+		return -1;
 	}
-
-	return -1;
 }
 
 static int nftnl_data_parse_cb(const struct nlattr *attr, void *data)
-- 
2.30.1

