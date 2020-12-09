Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7E9A2D4847
	for <lists+netfilter-devel@lfdr.de>; Wed,  9 Dec 2020 18:50:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728251AbgLIRu2 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 9 Dec 2020 12:50:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728269AbgLIRuT (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 9 Dec 2020 12:50:19 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD46CC061793
        for <netfilter-devel@vger.kernel.org>; Wed,  9 Dec 2020 09:49:38 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1kn3ar-0004Qj-E0; Wed, 09 Dec 2020 18:49:37 +0100
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nft 02/10] proto: reduce size of proto_desc structure
Date:   Wed,  9 Dec 2020 18:49:16 +0100
Message-Id: <20201209174924.27720-3-fw@strlen.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201209174924.27720-1-fw@strlen.de>
References: <20201209174924.27720-1-fw@strlen.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This will need an additional field. We can compress state
here to avoid further size increase.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 include/proto.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/proto.h b/include/proto.h
index 6ef332c3966f..667650d67c97 100644
--- a/include/proto.h
+++ b/include/proto.h
@@ -39,8 +39,8 @@ struct proto_hdr_template {
 	const struct datatype		*dtype;
 	uint16_t			offset;
 	uint16_t			len;
-	enum byteorder			byteorder;
-	enum nft_meta_keys		meta_key;
+	enum byteorder			byteorder:8;
+	enum nft_meta_keys		meta_key:8;
 };
 
 #define PROTO_HDR_TEMPLATE(__token, __dtype,  __byteorder, __offset, __len)\
@@ -101,11 +101,11 @@ enum proto_desc_id {
  */
 struct proto_desc {
 	const char			*name;
-	enum proto_desc_id		id;
-	enum proto_bases		base;
-	enum nft_payload_csum_types	checksum_type;
-	unsigned int			checksum_key;
-	unsigned int			protocol_key;
+	enum proto_desc_id		id:8;
+	enum proto_bases		base:8;
+	enum nft_payload_csum_types	checksum_type:8;
+	uint16_t			checksum_key;
+	uint16_t			protocol_key;
 	unsigned int			length;
 	struct {
 		unsigned int			num;
-- 
2.26.2

