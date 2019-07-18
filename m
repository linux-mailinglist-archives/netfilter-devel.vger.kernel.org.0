Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15A876D0E2
	for <lists+netfilter-devel@lfdr.de>; Thu, 18 Jul 2019 17:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbfGRPRC (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 18 Jul 2019 11:17:02 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:35684 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726608AbfGRPRB (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 18 Jul 2019 11:17:01 -0400
Received: from localhost ([::1]:48774 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1ho89U-0004E0-AP; Thu, 18 Jul 2019 17:17:00 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [nft PATCH] json: Fix memleak in timeout_policy_json()
Date:   Thu, 18 Jul 2019 17:16:56 +0200
Message-Id: <20190718151656.19820-1-phil@nwl.cc>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Use the correct function when populating policy property value,
otherwise the temporary objects' refcounts are incremented.

Fixes: c82a26ebf7e9f ("json: Add ct timeout support")
Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 src/json.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/json.c b/src/json.c
index 96ba557a3478b..33e0ec15f2ee1 100644
--- a/src/json.c
+++ b/src/json.c
@@ -266,8 +266,8 @@ static json_t *timeout_policy_json(uint8_t l4, const uint32_t *timeout)
 
 		if (!root)
 			root = json_object();
-		json_object_set(root, timeout_protocol[l4].state_to_name[i],
-				json_integer(timeout[i]));
+		json_object_set_new(root, timeout_protocol[l4].state_to_name[i],
+				    json_integer(timeout[i]));
 	}
 	return root ? : json_null();
 }
-- 
2.22.0

