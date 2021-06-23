Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9B593B1A6F
	for <lists+netfilter-devel@lfdr.de>; Wed, 23 Jun 2021 14:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbhFWMsd (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 23 Jun 2021 08:48:33 -0400
Received: from mail.netfilter.org ([217.70.188.207]:60646 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbhFWMsd (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 23 Jun 2021 08:48:33 -0400
Received: from localhost.localdomain (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id 13D706423C
        for <netfilter-devel@vger.kernel.org>; Wed, 23 Jun 2021 14:44:50 +0200 (CEST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft] rule: obj_free() releases timeout state string
Date:   Wed, 23 Jun 2021 14:46:11 +0200
Message-Id: <20210623124611.2663-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Missing free() on the timeout state string on object release.

Fixes: 7a0e26723496 ("rule: memleak of list of timeout policies"
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/rule.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/rule.c b/src/rule.c
index 10569aa7875a..877eae3cd85d 100644
--- a/src/rule.c
+++ b/src/rule.c
@@ -1714,6 +1714,7 @@ void obj_free(struct obj *obj)
 
 		list_for_each_entry_safe(ts, next, &obj->ct_timeout.timeout_list, head) {
 			list_del(&ts->head);
+			xfree(ts->timeout_str);
 			xfree(ts);
 		}
 	}
-- 
2.20.1

